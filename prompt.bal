final string PROMPT = string `
Summarize the following conversation in the Reply. Don't summarize the Question give Question as it is. Question means question + the context given by the user (It can be some code segments or links,etc). You should try to find if the answer for the question asked by the op or the resolution made to the question or you have to explicitly mention that the question is not answered and still getting investigated. Your output should be in the following format. You shouldn't try to answer the question by yourself. You have to use the conversation given to you to come up with the answer to the question only if the answer is in the conversation.
You should strictly follow this Output Format. We aim for the question to be as comprehensive as possible. But never answer the question by yourself.

Input Format
Thread URL:
Title:
Question:
Question Asked By:
Reply:

Output Format(Don't do any modification to the output format or styles. Just copy paste the output format and fill the details)
<tr><td class='first-column' width='90px'>Thread URL</td><td class='first-column'><a style='color: #FFFFFF; text-decoration: underline' href='Thread URL goes here'> Thread URL goes here</a></td></tr>
<tr><td class='gray-column'>Title</td> <td>Title goes here</td></tr>
<tr><td class='gray-column'>Question</td><td class='odd-row'>Question goes here</td></tr> (also include the any additional replies realted to question as well)
<tr><td class='gray-column'>Asked By </td><td>Question Asked By goes here</td></tr>
<tr><td class='gray-column'>Answer</td><td class='odd-row'>Answer goes here</td></tr>(don't include any of the users names in the answer)
<tr><td class='gray-column'>Answered By </td><td>the users who answer to that questions goes here</td></tr>


(If there are multiple Questions then you can use the following format.
Output Format 
<tr><td class='first-column' width='90px'>Thread URL</td><td class='first-column'><a style='color: #FFFFFF; text-decoration: underline' href='Thread URL goes here'> Thread URL goes here</a></td></tr>
<tr><td class='gray-column'>Title</td> <td>Title goes here</td></tr>
<tr><td class='gray-column'>Question 1</td> <td class='odd-row'>Question 1 goes here</td></tr>
<tr><td class='gray-column'>Question 1 Asked By </td><td>Question 1 Asked By goes here</td></tr>
<tr><td class='gray-column'>Answer 1</td> <td class='odd-row'>Answer 1 goes here</td></tr>
<tr><td class='gray-column'>Answered By </td><td>Answered By goes here</td></tr>
<tr><td class='gray-column'>Question 2</td> <td class='odd-row'>Question 2 goes here</td></tr>
<tr><td class='gray-column'>Question 2 Asked By </td><td class='odd-row'>Question 2 Asked By goes here</td></tr>
<tr><td class='gray-column'>Answer 2</td> <td>Answer 2 goes here</td></tr>
<tr><td class='gray-column'>Answered By </td><td class='odd-row'>Answered By goes here</td></tr>
etc...)
`;
