section .data
    plaintext db 'Hello, World!', 0  ; Null-terminated string to be encrypted
    key       db 0xAA                ; Simple XOR key
    plaintext_len equ $ - plaintext  ; Calculate the length of the plaintext

section .bss
    ciphertext resb plaintext_len    ; Buffer to store the encrypted data

section .text
    global _start

_start:
    ; Load the address of the plaintext and ciphertext into registers
    mov rsi, plaintext
    mov rdi, ciphertext

    ; Load the length of the plaintext into rcx
    mov rcx, plaintext_len

    ; Load the XOR key into al
    mov al, [key]

encrypt:
    ; Check if we've reached the end of the string
    cmp byte [rsi], 0
    je write_ciphertext

    ; Perform XOR encryption
    mov bl, [rsi]
    xor bl, al
    mov [rdi], bl

    ; Move to the next character
    inc rsi
    inc rdi
    loop encrypt

write_ciphertext:
    ; Write the ciphertext to stdout
    mov rax, 1         ; sys_write system call number
    mov rdi, 1         ; file descriptor 1 (stdout)
    mov rsi, ciphertext ; address of the ciphertext
    mov rdx, plaintext_len ; number of bytes to write
    syscall

    ; Exit the program
    mov rax, 60         ; sys_exit system call number
    xor rdi, rdi        ; exit code 0
    syscall
`