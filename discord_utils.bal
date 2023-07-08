import ballerina/http;
import ballerina/log;
import ballerina/time;

const DISCORD_API_URL = "https://discord.com/api/v10";
const time:Seconds DISCORD_EPOCH = 1420070400000.00;

configurable string botToken = ?;

final map<string> & readonly headers = {
    Authorization: botToken
};

final http:Client discordClient = check new (DISCORD_API_URL);

function getChannelDetails(int channelId) returns Channel|error {
    return discordClient->/channels/[channelId](headers);
}

function getActiveThreads(string guildId) returns ActiveThreads|error {
    return discordClient->/guilds/[guildId]/threads/active(headers);
}

function getMessages(string threadId, string? timestamp = ()) returns Message[]|error {
    if timestamp != () {
        return discordClient->/channels/[threadId]/messages(headers, after = timestamp);
    }
    return discordClient->/channels/[threadId]/messages(headers);
}

function getThreadURL(string guildId, string threadId) returns string =>
    string `https://discord.com/channels/${guildId}/${threadId}`;

function timestampToSnowflake(time:Utc timestamp, boolean high = true) returns int|error {
    int|error snowFlake = trap ((<int>((<decimal>timestamp[0] + timestamp[1]) * 1000 - DISCORD_EPOCH) << 22) + (high ? 2 ^ 22 - 1 : 0));
    if (snowFlake is error) {
        log:printError("Snowflake exceeds the range of the int type: " + snowFlake.message());
    }
    return snowFlake;
}
