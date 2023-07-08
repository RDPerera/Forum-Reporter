# Discord Forum Thread Summary to Email
Send email of the latest summery of Discord forum threads. Written in Ballerina (https://ballerina.io).

## Overview
This is a Ballerina project, that uses the Discord and OpenAI APIs to send an email of the latest summary of questions and answers in Ballerina Discord forum threads.

## Configuration
Create a file called `Config.toml` at the root of the project.

### Config.toml
```
openAIToken = "<OPENAI_API_KEY>"
forumChannelId = <DISCORD_FORUM_CHANNEL_ID>
botToken = "Bot <DISCORD_BOT_TOKEN>"
host = "EMAIL_HOST"
username = "EMAIL_USERNAME"
password = "EMAIL_PASSWORD"
toList = [EMAIL_TO_STRING_ARRAY]
ccList = [EMAIL_CC_STRING_ARRAY]
```

**Note:** The `forumChannelId` should be an integer and the `botToken` should be prefixed with `Bot` as shown above.
