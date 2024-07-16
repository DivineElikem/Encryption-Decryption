section .data
    key       db 0xAA                ; Simple XOR key
    buffer_len equ 128               ; Maximum length of input buffer

section .bss
    plaintext resb buffer_len        ; Buffer to store the plaintext
    ciphertext resb buffer_len       ; Buffer to store the encrypted data

section .text
    global _start

_start:
    ; Read the plaintext from stdin
    mov rax, 0         ; sys_read system call number
    mov rdi, 0         ; file descriptor 0 (stdin)
    mov rsi, plaintext ; address of the plaintext buffer
    mov rdx, buffer_len ; number of bytes to read
    syscall

    ; Store the number of bytes read in rdx
    mov rdx, rax
    ; Copy the number of bytes read to rcx
    mov rcx, rdx

    ; Load the XOR key into al
    mov al, [key]

    ; Load the address of the plaintext and ciphertext into registers
    mov rsi, plaintext
    mov rdi, ciphertext

encrypt:
    ; Check if we've reached the end of the input
    cmp rcx, 0
    je write_ciphertext

    ; Perform XOR encryption
    mov bl, [rsi]
    xor bl, al
    mov [rdi], bl

    ; Move to the next character
    inc rsi
    inc rdi
    dec rcx
    jmp encrypt

write_ciphertext:
    ; Write the ciphertext to stdout
    mov rax, 1         ; sys_write system call number
    mov rdi, 1         ; file descriptor 1 (stdout)
    mov rsi, ciphertext ; address of the ciphertext
    syscall

    ; Exit the program
    mov rax, 60         ; sys_exit system call number
    xor rdi, rdi        ; exit code 0
    syscall
