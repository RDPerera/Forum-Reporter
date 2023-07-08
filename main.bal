import ballerina/log;
import ballerina/regex;
import ballerina/time;

const TYPE_FORUM_CHANNEL = 15;
const time:Seconds ONE_DAY_IN_SECONDS = 86400;
configurable int forumChannelId = ?;

function readThreads(ActiveThreads activeThreads) returns string|error {
    string result = "";
    foreach ChannelThread thread in activeThreads.threads {

        if !check hasRecentMessages(thread) {
            continue;
        }
        string prompt = check constructPrompt(thread);

        string|error generateChatCompletionResult = generateChatCompletion(prompt);
        if generateChatCompletionResult is error {
            log:printError("Error occured when connecting to OpenAI: ",
                generateChatCompletionResult,
                stackTrace = generateChatCompletionResult.stackTrace()
            );
        }
        result += check generateChatCompletionResult;
    }
    return result;
}

function constructPrompt(ChannelThread thread) returns string|error {
    string prompt = string `${PROMPT}Thread URL: ${getThreadURL(thread.guild_id, thread.id)}${"\n"}Title: ${thread.name}${"\n"}Question: `;
    Message[] allMessages = (check getMessages(thread.id)).reverse();

    if allMessages.length() == 0 {
        return prompt;
    }

    prompt += let Message {content, timestamp, author} = allMessages[0] in
                string `${content} (${timestamp})${"\n"}Question Asked by: ${author.username} Reply: `;

    foreach int index in 1 ..< allMessages.length() {
        Message {author: {username}, content, timestamp} = allMessages[index];
        prompt += string `${username}: ${content} (${timestamp})${"\n"}`;
    }
    return prompt;
}

function hasRecentMessages(ChannelThread thread) returns boolean|error {
    time:Utc oneDayAgoTime = time:utcAddSeconds(time:utcNow(), -ONE_DAY_IN_SECONDS);
    int snowflakeTime = check timestampToSnowflake(oneDayAgoTime);
    Message[] recentMessages = check getMessages(thread.id, snowflakeTime.toString());
    return recentMessages.length() > 0;
}

public function main() returns error? {
    Channel channel = check getChannelDetails(forumChannelId);
    if channel.'type != TYPE_FORUM_CHANNEL {
        log:printError(string `The channel with ID ${forumChannelId} is not a Forum channel.`);
        return;
    }

    ActiveThreads activeThreads = check getActiveThreads(channel.guild_id);

    string result = check readThreads(activeThreads);
    if result == "" {
        return;
    }

    string subject = string `[Discord Forum Summery] Bellerina Forum Threads : ${regex:split(time:utcToString(time:utcNow()), "T")[0]}`;
    check sendEmail(subject, TOP_HTML + result + BOTTOM_HTML);
}
