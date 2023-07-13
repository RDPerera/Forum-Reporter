import ballerinax/openai.chat;
import ballerina/log;
import ballerina/lang.runtime;

const decimal TIME_OUT = 3000;
const MAX_TRIES = 5;

configurable string openAIToken = ?;

final chat:Client chatClient = check new ({
    auth: {
        token: openAIToken
    },
    timeout: TIME_OUT
});

function generateChatCompletion(string prompt, string model = "gpt-3.5-turbo") returns string|error {
    int tries = 0;
    while (tries < MAX_TRIES) {
        chat:CreateChatCompletionResponse res = check chatClient->/chat/completions.post({
            model,
            messages: [{role: "user", content: prompt}]
        });
        runtime:sleep(20);
        string? content = res.choices[0]?.message?.content;
        if (content is string) {
            log:printInfo(string `OpenAI Chat Response at the ${tries.toBalString()} try.`);
            return content;
        }
        tries += 1;
    }
    return error("The message is empty.");
}