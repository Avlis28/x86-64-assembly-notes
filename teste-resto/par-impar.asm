%include "bibliotecaE.inc"

section .data 
    msg db "Entre com um valor de 3 digitos", lf, null
    tam equ $ - msg 
    parMsg db "O numero e par", lf, null
    tamPar equ $ - parMsg
    imparMsg db "O numero e impar", lf, null
    tamImpar equ $ - imparMsg

section .bss
    numero resb 1

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