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
        x dd 50                                          ; DD = define doubleword, 4 bytes/ DW = define word, 2 bytes
        y dd 10                                          ; DQ = define quadword, 8 bytes/ DB = define byte, 1 byte/ DT= define ten bytes, 10 bytes 
        msg1 db "x eh maior que y", lf, null
        tam1 equ $- msg1
        msg2 db "x eh menor que y", lf, null
        tam2 equ $- msg2

 section .text 

 global _start 

 _start:
        mov eax, dword [x]                              ; Move o valor de x para o registrador eax
        mov ebx, dword [y]                              ; Move o valor de y para o registrador ebx
        cmp eax, ebx                                    ; Compara os valores em eax e ebx/CMP = If eax > ebx then set ZF=0 and SF=0
        jge maior                                       ; Se eax > ebx, pula para o rótulo maior/je = jg > jge = jge >= jl = < jle <= jne !=
        mov ecx, msg2                                   ; Move a mensagem "x eh menor que y" para o registrador ecx
        mov edx, tam2                                   ; Move o tamanho da mensagem para o registrador edx
        jmp final                                       ; Pula para o rótulo final

maior:
        mov ecx, msg1                                   ; Move a mensagem "x eh maior que y" para o registrador ecx
        mov edx, tam1                                   ; Move o tamanho da mensagem para o registrador edx

final:
        mov eax, sys__write
        mov ebx, std_out 
        int sys_call                                    ; Chama a interrupção do sistema para escrever a mensagem

        mov eax, sys_exit
        xor ebx, ebx                                    ; OR/XOR/AND/NOT são operações lógicas bit a bit 
        int sys_call                                    ; Chama a interrupção do sistema para sair do programa