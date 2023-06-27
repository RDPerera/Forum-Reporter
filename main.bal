import ballerina/email;
import ballerina/io;


configurable string host = ?;
configurable string username = ?;
configurable string password = ?;
configurable string to = ?;

public function main() returns error? {
    final email:SmtpClient smtpClient = check new (host, username, password);

    email:Message email = {
        to: to,
        subject: "[IGNORE]",
        body: "Hello World! by Choreo"
    };
    check smtpClient->sendMessage(email);
    io:println("Email sent successfully");
}