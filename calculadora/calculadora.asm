%include "calculadora.inc"

; calculadora.asm
; nasm -f elf64 calculadora.asm
; ld -o calculadora calculadora.o

section .data
    msg1 db "Numero 1: ", 0
    msg2 db "Numero 2: ", 0
    msg3 db "Operacao (+ ou -): ", 0
    msgR db "Resultado: ", 0
    nl   db 10

section .bss
    n1  resb 8
    n2  resb 8
    op  resb 2

section .text
global _start

_start:

    mov rax, 1
    mov rdi, 1
    mov rsi, msg1
    mov rdx, 10
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, n1
    mov rdx, 8
    syscall


    mov rax, 1
    mov rdi, 1
    mov rsi, msg2
    mov rdx, 10
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, n2
    mov rdx, 8
    syscall


    mov rax, 1
    mov rdi, 1
    mov rsi, msg3
    mov rdx, 20
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, op
    mov rdx, 2
    syscall


    mov al, [n1]
    sub al, '0'
    mov bl, [n2]
    sub bl, '0'

    mov cl, [op]
    cmp cl, '+'
    je soma
    cmp cl, '-'
    je subtrai

soma:
    add al, bl
    jmp imprime

subtrai:
    sub al, bl

imprime:
    add al, '0'
    mov [n1], al

    mov rax, 1
    mov rdi, 1
    mov rsi, msgR
    mov rdx, 11
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, n1
    mov rdx, 1
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall