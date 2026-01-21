; ======================================================
; BIBLIOTECA: Definições e macros x86-64 Linux
; Autor: Código educacional
; Descrição: Include com constantes, syscalls e funções
;            Segue ABI System V AMD64 (x86-64 Linux)
; ======================================================

section .data 
        ; Constantes ASCII
        lf              equ      0xa            ; Line Feed (nova linha)
        null            equ      0xd            ; Final da String (CR)
        
        ; Syscall numbers (x86-64 AMD64 ABI)
        sys_exit        equ      0x3c           ; exit() = 60
        sys_read        equ      0x0            ; read() = 0
        sys_write       equ      0x1            ; write() = 1
        
        ; Valores de retorno
        ret_exit        equ      0x0            ; Retorno com sucesso
        
        ; Descritores de arquivo padrão
        std_in          equ      0x0            ; stdin = 0
        std_out         equ      0x1            ; stdout = 1
        
        ; Tamanho do buffer
        tamanhoBuffer   equ      0xa            ; 10 bytes para entrada

section .bss
bufferEntrada   resb   tamanhoBuffer            ; Buffer: reserva 10 bytes


section .text

; ======================================================
; FUNÇÃO: saidaResultado
; Exibe string do buffer na saída padrão (stdout)
; ======================================================
; Parâmetros: Usa buffer global (bufferEntrada)
; Retorno: Sem valor de retorno (utiliza syscall)
; Registradores: RAX (syscall number), RDI, RSI, RDX
; ======================================================
saidaResultado:
    mov rax, sys_write                        ; RAX = 1 (SYS_WRITE)
    mov rdi, std_out                          ; RDI = 1 (stdout) - 1º parâmetro
    mov rsi, bufferEntrada                    ; RSI = endereço do buffer - 2º parâmetro
    mov rdx, tamanhoBuffer                    ; RDX = tamanho - 3º parâmetro
    syscall                                   ; Executa syscall
    ret                                       ; Retorna ao chamador

; ======================================================
; FUNÇÃO: into_to_string (nota: nome original mantido)
; Converte inteiro em string decimal
; ======================================================
; Entrada:  RAX = inteiro a converter
; Saída:    RCX = endereço início da string
; Usa:      RBX (divisor), RSI (ponteiro buffer),
;           RDX (resto), RAX (quociente)
; ======================================================
into_to_string:
    lea rsi, [bufferEntrada]                  ; RSI = endereço do buffer
    add rsi, 0x9                              ; Posiciona no final (offset 9)
    mov byte [rsi], 0xa                       ; Terminador: line feed
    mov rbx, 0xa                              ; RBX = 10 (divisor - base decimal)

proximo_digito:
    xor rdx, rdx                              ; RDX = 0 (limpa resto anterior)
    div rbx                                   ; RAX = RAX / 10, RDX = RAX % 10
    add dl, '0'                               ; Converte 0-9 para '0'-'9'
    dec rsi                                   ; Volta uma posição
    mov [rsi], dl                             ; Escreve dígito
    cmp rax, 0                                ; Verifica se ainda há dígitos
    jne proximo_digito                        ; Loop se RAX != 0
    mov rcx, rsi                              ; RCX = endereço da string resultante
    ret                                       ; Retorna ao chamador