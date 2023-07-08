import ballerinax/openai.chat;
import ballerina/lang.runtime;

configurable string openAIToken = ?;

final chat:Client chatClient = check new ({
    auth: {
        token: openAIToken
    },
    retryConfig: {
        count: 10,
        interval: 300,
        backOffFactor: 2.0,
        maxWaitInterval: 60000
    }
});

function generateChatCompletion(string prompt, string model = "gpt-3.5-turbo") returns string|error {
    chat:CreateChatCompletionResponse res = check chatClient->/chat/completions.post({
        model,
        messages: [{role: "user", content: prompt}]
    });
    string? content = res.choices[0]?.message?.content;
    runtime:sleep(25);
    return content ?: error("The message is empty.");
}
