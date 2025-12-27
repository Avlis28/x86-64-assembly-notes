%include "biblioteca.asm"

section .text

global _start

_start:
   lea esi, [bufferEntrada]          ; Load effective address
   add esi, 0x9                      ; Move to the end of the buffer 
   mov byte [esi], 0xa               ; Null-terminate the string
   
   dec esi 
   mov dl, 0x12
   add dl, '0'                    
   mov [esi], dl
   
   dec esi 
   mov dl, 0x13
   add dl, '0'                    
   mov [esi], dl
   
   dec esi 
   mov dl, 0x11
   add dl, '0'                    
   mov [esi], dl

   

   call saidaResultado               ; Call the output function

    mov eax, sys_exit                ; Prepare to exit
    mov ebx, ret_exit                ; Exit code 0
    int sys_call                     ; Make the system call