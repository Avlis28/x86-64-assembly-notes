; Teste de biblioteca com conversão de inteiros para string
; CORRIGIDO: include com extensão correta (biblioteca.inc)
%include "biblioteca.inc"

section .text

global _start

_start:
   ; CORRIGIDO: usar registrador 64-bit RSI em vez de ESI (ABI x86-64)
   lea rsi, [bufferEntrada]          ; Carrega endereço efetivo do buffer
   add rsi, 0x9                      ; Desloca para o final do buffer (10 bytes)
   mov byte [rsi], 0xa               ; Terminador: line feed (0x0a)
   
   ; Escreve digit '2' (0x12 + '0')
   dec rsi 
   mov dl, 0x12
   add dl, '0'                    
   mov [rsi], dl
   
   ; Escreve digit '3' (0x13 + '0')
   dec rsi 
   mov dl, 0x13
   add dl, '0'                    
   mov [rsi], dl
   
   ; Escreve digit '1' (0x11 + '0')
   dec rsi 
   mov dl, 0x11
   add dl, '0'                    
   mov [rsi], dl

   ; CORRIGIDO: usar syscall em vez de "int sys_call" (converte para ABI x86-64)
   call saidaResultado              ; Chama sub-rotina para exibir resultado

   ; Encerrar programa
   mov rax, sys_exit                ; SYS_EXIT = 60
   mov rdi, ret_exit                ; Código de retorno: 0 (sucesso)
   syscall                          ; Executa a chamada do sistema
