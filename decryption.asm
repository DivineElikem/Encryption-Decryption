section .data
    key       db 0xAA                ; Simple XOR key
    ciphertext db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ; Buffer to be replaced with ciphertext
    ciphertext_len equ $ - ciphertext ; Calculate the length of the ciphertext

section .bss
    plaintext resb ciphertext_len    ; Buffer to store the decrypted data

section .text
    global _start

_start:
    ; Load the address of the ciphertext and plaintext into registers
    mov rsi, ciphertext
    mov rdi, plaintext

    ; Load the length of the ciphertext into rcx
    mov rcx, ciphertext_len

    ; Load the XOR key into al
    mov al, [key]

decrypt:
    ; Check if we've reached the end of the string
    cmp byte [rsi], 0
    je write_plaintext

    ; Perform XOR decryption
    mov bl, [rsi]
    xor bl, al
    mov [rdi], bl

    ; Move to the next character
    inc rsi
    inc rdi
    loop decrypt

write_plaintext:
    ; Write the plaintext to stdout
    mov rax, 1         ; sys_write system call number
    mov rdi, 1         ; file descriptor 1 (stdout)
    mov rsi, plaintext ; address of the plaintext
    mov rdx, ciphertext_len ; number of bytes to write
    syscall

    ; Exit the program
    mov rax, 60         ; sys_exit system call number
    xor rdi, rdi        ; exit code 0
    syscall
