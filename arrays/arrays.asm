%include "bibliotecaE.inc"

section .data
    msg1: db "Parte 1", lf, null
    msg2: db "Parte 2", lf, null
    msg3: db "Parte 3", lf, null
    msg4: db "Parte 4", lf, null

section .text 

global _start 

_start:

   mov rax, 0x1                     ; Chamada de escrita = SYS_WRITE
   mov rdi, 0x1                     ; Saida padrão = STDOUT
   mov rsi, msg1                    ; Endereço do buffer = MSG1
   mov rdx, 0x8                     ; Tamanho do buffer = 8 BYTES/TAMANHO
   syscall                          ; Executa a chamada do sistema

   mov rax, 0x3c                    ; Chamada de saída = SYS_EXIT
   mov rdi, 0x0                     ; Código de saída = 0
   syscall                          ; Executa a chamada do sistema