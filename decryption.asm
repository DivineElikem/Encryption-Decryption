section .data
    key       db 0xAA                ; Simple XOR key
    buffer_len equ 128               ; Maximum length of input buffer

section .bss
    ciphertext resb buffer_len       ; Buffer to store the ciphertext
    plaintext resb buffer_len        ; Buffer to store the decrypted data

section .text
    global _start

_start:
    ; Read the ciphertext from stdin
    mov rax, 0         ; sys_read system call number
    mov rdi, 0         ; file descriptor 0 (stdin)
    mov rsi, ciphertext ; address of the ciphertext buffer
    mov rdx, buffer_len ; number of bytes to read
    syscall

    ; Store the number of bytes read in rdx
    mov rdx, rax
    ; Copy the number of bytes read to rcx
    mov rcx, rdx

    ; Load the XOR key into al
    mov al, [key]

    ; Load the address of the ciphertext and plaintext into registers
    mov rsi, ciphertext
    mov rdi, plaintext

decrypt:
    ; Check if we've reached the end of the input
    cmp rcx, 0
    je write_plaintext

    ; Perform XOR decryption
    mov bl, [rsi]
    xor bl, al
    mov [rdi], bl

    ; Move to the next character
    inc rsi
    inc rdi
    dec rcx
    jmp decrypt

write_plaintext:
    ; Write the plaintext to stdout
    mov rax, 1         ; sys_write system call number
    mov rdi, 1         ; file descriptor 1 (stdout)
    mov rsi, plaintext ; address of the plaintext
    syscall

    ; Exit the program
    mov rax, 60         ; sys_exit system call number
    xor rdi, rdi        ; exit code 0
    syscall
