; =============================
; anotação da seção e alertas!
; =============================

segment .data 
        lf              equ      0xa            ; Line Feet  
        null            equ      0xd            ; Final da String 
        sys_call        equ      0x80           ; Envia informação ao SO
        sys_exit        equ      0x1            ; Codigo chamada para o fim
        sys_read        equ      0x3            ; Operação de leitura 
        sys__write      equ      0x4            ; Operação de escrita 
        ret_exit        equ      0x0            ; Operação realizada com sucesso 
        std_in          equ      0x0            ; Entrada padrão 
        std_out         equ      0x1            ; Saida padrão


section .data 
        msg db "entre com sua mensagem:", lf, null
        tam equ $- msg 

section .bss
nome resb 1

section .text 

global _start

_start:
        mov eax, sys__write
        mov ebx, std_out 
        mov ecx, msg
        mov edx, tam
        int sys_call

        mov eax, sys_read
        mov ebx, std_in
        mov ecx, nome
        mov edx, tam
        int sys_call
