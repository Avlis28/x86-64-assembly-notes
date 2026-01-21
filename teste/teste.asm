; Teste de arrays e saída
; CORRIGIDO: include correto sem ponto extra
%include "bibliotecaE.inc"

section .data
   array1: db 12, 34, 56, 78, 90
   newline: db 10


section .text 

global _start 

_start:
   ; CORRIGIDO: usar registradores 64-bit (RAX) conforme ABI x86-64
   movzx rax, byte [array1 + 0]        ; Acessa primeiro elemento do array
   call saidaResultado                 ; Chama sub-rotina de saída
   mov rax, 1                          ; SYS_WRITE

   ; CORRIGIDO: registradores 64-bit (RDI, RSI, RDX) conforme ABI x86-64
   mov rdi, 1                          ; stdout
   lea rsi, [rel newline]              ; Endereço da nova linha
   mov rdx, 1                          ; Tamanho
   syscall                             ; Executa syscall

   ; Encerrar programa
   mov rax, 0x3c                       ; SYS_EXIT = 60
   mov rdi, 0x0                        ; Código de retorno: sucesso
   syscall                             ; Executa a chamada do sistema
