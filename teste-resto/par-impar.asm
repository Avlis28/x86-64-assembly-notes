%include "bibliotecaE.inc"

section .data 
    msg db "Entre com um valor de 3 digitos", lf, null
    tam equ $ - msg 
    parMsg db "O numero e par", lf, null
    tamPar equ $ - parMsg
    imparMsg db "O numero e impar", lf, null
    tamImpar equ $ - imparMsg

section .bss
    numero resb 4

section .text

global _start

_start:

    mov rax, sys_write         
    mov rdi, std_out
    mov rsi, msg
    mov rdx, tam
    syscall

entrada_valor:

    mov rax, sys_read
    mov rdi, std_in
    mov rsi, numero
    mov rdx, 0x4
    syscall

    lea rsi, [numero]
    mov rcx, 0x3
    call string_to_int
    
verificar:
    mov rdx, 0x0
    mov rbx, 0x2
    mov rbx, 2
    cmp rdx, 0x0
    jz mostrar_par

mostrar_impar:
    mov rax, sys_write         
    mov rdi, std_out
    mov rsi, imparMsg
    mov rdx, tamImpar
    syscall
    jmp saida 

mostrar_par:
    mov rax, sys_write         
    mov rdi, std_out        
    mov rsi, parMsg
    mov rdx, tamPar
    syscall
    jmp saida

saida:
    mov rax, sys_exit
    mov rdi, 0x0
    syscall

; Rotinas / Funcoes / Sub-rotinas
; ----------------------------------------
; Converte string para inteiro
    ; Entrada: RSI - endereco da string
    ;          RCX - tamanho da string
    ; Saida:   RAX - valor inteiro
; ----------------------------------------
    ; Algoritmo:
    ;   1. Ler o proximo digito da string
    ;   2. Converter o digito de ASCII para valor numerico
    ;   3. Multiplicar o valor atual por 10
    ;   4. Somar o digito convertido ao valor atual
    ;   5. Repetir ate o tamanho da string ser zero
; ----------------------------------------

    ;   Exemplo de chamada:
    ;   lea rsi, [string]
    ;   mov rcx, tamanho_da_string
    ;   call string_to_int
    ;   Resultado em RAX      