; Programa em Assembly x86-64 para Linux que utiliza todos os registradores de propósito geral
; Compilar com: nasm -f elf64 registradores.asm
; Linkar com: ld -s -o registradores registradores.o

section .data
    msg db "Registers initialized!", 0xA
    tam equ $ - msg

section .text
    global _start

_start:
    ; Inicializando todos os registradores de propósito geral com valores únicos
    mov rax, 1      ; Registrador de acumulação
    mov rbx, 2      ; Registrador base
    mov rcx, 3      ; Registrador contador
    mov rdx, 4      ; Registrador de dados
    mov rsi, 5      ; Registrador de índice fonte
    mov rdi, 6      ; Registrador de índice destino
    mov rbp, 7      ; Registrador ponteiro base
    mov rsp, rsp    ; Registrador ponteiro pilha (não alterar diretamente)
    mov r8, 8       ; Registrador adicional 8
    mov r9, 9       ; Registrador adicional 9
    mov r10, 10     ; Registrador adicional 10
    mov r11, 11     ; Registrador adicional 11
    mov r12, 12     ; Registrador adicional 12
    mov r13, 13     ; Registrador adicional 13
    mov r14, 14     ; Registrador adicional 14
    mov r15, 15     ; Registrador adicional 15

    ; Imprimir mensagem
    mov rax, 1      ; syscall write
    mov rdi, 1      ; stdout
    mov rsi, msg
    mov rdx, tam
    syscall

    ; Sair do programa
    mov rax, 60     ; syscall exit
    mov rdi, 0      ; código de saída
    syscall