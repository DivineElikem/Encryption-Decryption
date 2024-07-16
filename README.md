# Encryption-Decryption
An encryption/decryption algorithm with Assembly language


**EXPLANATION OF THE ALGORITHM**

**encryption.asm**

This program takes some text you type in, scrambles it (encrypts it), and then shows you the scrambled text. Here's how it works:

1. Section: .data
   - Key: This is like a secret code used to scramble and unscramble your message. In this case, it's the number 0xAA.
   - Buffer length: This is just a number that tells the computer how much space to use for the text (128 characters).
   - Messages: These are the texts shown to you, like "Enter the text to be encrypted" and "This is your encrypted text".

2. Section: .bss
   - Plaintext and Ciphertext: These are like storage boxes. One is for the message you type in (plaintext), and the other is for the scrambled message (ciphertext).

3. Section: .text
   - global _start: This tells the computer where to start running the program.

4. Starting the Program:
   - Print the prompt message: The program first shows "Enter the text to be encrypted".
   - Read the plaintext: It then waits for you to type your message and stores it in the plaintext box.
   - Store number of bytes read: It keeps track of how many characters you typed.
   - Load the XOR key: The program gets the secret code ready.
   - Encrypt: The program scrambles each character of your message by combining it with the secret code.
   - Print the result message: It then shows "This is your encrypted text".
   - Write the ciphertext: Finally, it shows you the scrambled message.


**decryption.asm**

This program takes the scrambled text you got from the first program, unscrambles it (decrypts it), and shows you the original message. Here's how it works:

1. Section: .data
   - Key: This is the same secret code used to scramble the message (0xAA).
   - Buffer length: This tells the computer how much space to use for the text (128 characters).
   - Messages: These are the texts shown to you, like "Enter the ciphertext to be decrypted" and "This is your decrypted text".

2. Section: .bss
   - Ciphertext and Plaintext: These are storage boxes. One is for the scrambled message you enter (ciphertext), and the other is for the original message (plaintext).

3. Section: .text
   - Global _start: This tells the computer where to start running the program.

4. Starting the Program:
   - Print the prompt message: The program first shows "Enter the ciphertext to be decrypted".
   - Read the ciphertext: It then waits for you to type the scrambled message and stores it in the ciphertext box.
   - Store number of bytes read: It keeps track of how many characters you typed.
   - Load the XOR key: The program gets the secret code ready.
   - Decrypt: The program unscrambles each character of your message by combining it with the secret code.
   - Print the result message: It then shows "This is your decrypted text".
   - Write the plaintext: Finally, it shows you the original message.

**Summary**
- Encryption Program: You type a message, it gets scrambled using a secret code, and you see the scrambled message.
- Decryption Program: You type the scrambled message, it gets unscrambled using the same secret code, and you see the original message.
