; Programa em Assembly x86-64 para Linux que utiliza todos os registradores de propósito geral
; Compilar com: nasm -f elf64 registradores.asm
; Linkar com: ld -s -o registradores registradores.o

; =============================================================================
; PADRÃO x86-32 LINUX (i386 ABI)
; =============================================================================
;
; Este documento também cobre o padrão i386 ABI para Linux 32 bits:
; - Convenções de chamada de funções
; - Uso de registradores
; - Alinhamento de pilha
;
; REGISTRADORES DE PROPÓSITO GERAL (32 bits):
; - EAX: Acumulador, valor de retorno de funções
; - EBX: Base, preservado pelo callee (callee-saved)
; - ECX: Contador, usado em loops e shifts
; - EDX: Dados, extensão de EAX para multiplicações/divisões
; - ESI: Índice fonte, usado em operações de string
; - EDI: Índice destino, usado em operações de string
; - EBP: Ponteiro base da pilha, preservado pelo callee
; - ESP: Ponteiro da pilha (não alterar diretamente)
;
; CONVENÇÃO DE CHAMADA:
; - Argumentos: Passados na pilha (push antes da call)
; - Ordem: Último argumento primeiro (direita para esquerda)
; - Retorno: EAX (até 32 bits), EDX:EAX (64 bits)
; - Chamador salva: EAX, ECX, EDX
; - Chamado salva: EBX, ESI, EDI, EBP
; - Estruturas pequenas: Passadas por valor na pilha
; - Estruturas grandes: Passadas por referência
;
; PILHA E ALINHAMENTO:
; - Alinhada a 4 bytes (não 16 como em 64 bits)
; - Sem zona vermelha
; - Chamador limpa a pilha após a call (cdecl)
;
; SYSCALLS (32 bits):
; - Número do syscall em EAX
; - Argumentos em EBX, ECX, EDX, ESI, EDI (até 5 args)
; - Retorno em EAX
;
; =============================================================================

; =============================================================================
; PADRÃO x86-64 LINUX (System V AMD64 ABI)
; =============================================================================
;
; Este documento segue o padrão System V AMD64 ABI para Linux, que define:
; - Convenções de chamada de funções
; - Uso de registradores
; - Alinhamento de pilha
; - Zona vermelha (red zone)
;
; REGISTRADORES DE PROPÓSITO GERAL (64 bits):
; - RAX (EAX): Acumulador, valor de retorno de funções (até 64 bits)
; - RBX (EBX): Base, preservado pelo callee (callee-saved)
; - RCX (ECX): Contador, 4º argumento de função
; - RDX (EDX): Dados, 3º argumento de função, parte alta de retorno (128 bits)
; - RSI (ESI): Índice fonte, 2º argumento de função
; - RDI (EDI): Índice destino, 1º argumento de função
; - RBP (EBP): Ponteiro base da pilha, preservado pelo callee
; - RSP (ESP): Ponteiro da pilha (não alterar diretamente)
; - R8: 5º argumento de função
; - R9: 6º argumento de função
; - R10: Chamador salvo (caller-saved), ponteiro de cadeia estática
; - R11: Chamador salvo (caller-saved)
; - R12: Preservado pelo callee
; - R13: Preservado pelo callee
; - R14: Preservado pelo callee
; - R15: Preservado pelo callee
;
; REGISTRADORES DE PONTO FLUTUANTE (SSE/AVX):
; - XMM0-XMM7: Argumentos de ponto flutuante (1º a 8º), retorno de valores float
; - XMM0-XMM1: Retorno de valores de ponto flutuante
; - YMM0-YMM15: Extensões AVX (256 bits)
; - ZMM0-ZMM15: Extensões AVX-512 (512 bits)
;
; CONVENÇÃO DE CHAMADA:
; - Argumentos inteiros/ponteiros: RDI, RSI, RDX, RCX, R8, R9 (primeiros 6)
; - Argumentos float: XMM0-XMM7 (primeiros 8)
; - Argumentos extras: Pilha (alinhada a 16 bytes)
; - Retorno: RAX (até 64 bits), RAX+RDX (128 bits), XMM0+XMM1 (float)
; - Chamador salva: RAX, RCX, RDX, RSI, RDI, R8-R11, XMM0-XMM15
; - Chamado salva: RBX, RBP, RSP, R12-R15
; - Estruturas grandes: Passadas por referência (ponteiro como primeiro arg)
;
; PILHA E ALINHAMENTO:
; - Alinhada a 16 bytes na entrada de função
; - Zona vermelha: 128 bytes abaixo de RSP para funções folha (leaf functions)
; - Chamador aloca espaço de sombra (shadow space) se necessário
;
; SYSCALLS:
; - Número do syscall em RAX
; - Argumentos em RDI, RSI, RDX, R10, R8, R9
; - Retorno em RAX
;
; =============================================================================

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