
The provided text is a guide on how to securely collect sensitive information using Twilio's Voice and Functions features. The text explains the potential security risks of collecting sensitive information and how to mitigate those risks by using encryption and PCI Mode.

Here are some key points from the text:

1. Twilio's Voice and Functions features can be used to collect sensitive information such as credit card numbers.
2. However, this information is collected in plain text and could be exposed if not properly secured.
3. To securely collect sensitive information, you can use encryption and PCI Mode.
4. PCI Mode redacts all data captured from any <Gather> operation, preventing it from being displayed in the Call log.
5. Enabling PCI Mode on your account is a one-way street, and once it's on, you won't be able to turn it off.
6. To test the encryption and PCI Mode, you can place a call and enter specific digits as the last 4 digits of your credit card and unique PIN.
7. If you enter the correct digits, you will hear a successful API response, and if you enter any other digits, you will hear an unsuccessful response with an 82005 error from Functions.
8. The secret key used for encryption and decryption is stored as an Environment Variable on the Service, meaning users to whom the service is delegated will not have access to the key.
9. To rate this post and provide feedback, you can use the rating stars and the "Send your feedback" button at the end of the post.

Overall, the text provides a detailed guide on how to securely collect sensitive information using Twilio's Voice and Functions features, along with the potential risks and mitigation strategies.