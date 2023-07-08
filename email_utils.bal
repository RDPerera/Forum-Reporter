import ballerina/email;
import ballerina/mime;

configurable string host = ?;
configurable string username = ?;
configurable string password = ?;
configurable string[] to = ?;
configurable string[] cc = ?;

public function sendEmail(string subject, string body) returns error? {
    final email:SmtpClient smtpClient = check new (host, username, password);

    email:Message email = {
        to,
        cc,
        subject,
        body,
        contentType: mime:TEXT_HTML
    };
    check smtpClient->sendMessage(email);
}
