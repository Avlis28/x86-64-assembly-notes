%include ".bibliotecaE.inc"

section .data
   array1: db 12, 34, 56, 78, 90
   newline: db 10


section .text 

global _start 

_start:
   movzx rax, byte [array1 + 0]        ; [array1 + 0 * 2] jeito mais simples de acessar o primeiro elemento e outros arrays  
   call saidaResultado
   mov rax, 1

   mov rdi, 1
   lea rsi, [rel newline]
   mov rdx, 1
   syscall

   mov rax, 0x3c                     ; Chamada de saída = SYS_EXIT
   mov rdi, 0x0                      ; Código de saída = 0
   syscall                           ; Executa a chamada do sistema
