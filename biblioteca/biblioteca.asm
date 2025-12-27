section .data 
        lf              equ      0xa            ; Line Feet  
        null            equ      0xd            ; Final da String 
        sys_call        equ      0x80           ; Envia informação ao SO
        sys_exit        equ      0x1            ; Codigo chamada para o fim
        sys_read        equ      0x3            ; Operação de leitura 
        sys__write      equ      0x4            ; Operação de escrita 
        ret_exit        equ      0x0            ; Operação realizada com sucesso 
        std_in          equ      0x0            ; Entrada padrão 
        std_out         equ      0x1            ; Saida padrão
        tamanhoBuffer   equ      0xa            ; Tamanho do buffer de entrada


section .bss
bufferEntrada   resb    tamanhoBuffer           ; Reserva 10 bytes para o buffer de entrada


section .text


saidaResultado:
      mov eax, sys__write                       ; Chamada de escrita    
      mov ebx, std_out                          ; Saida padrão
      mov ecx, bufferEntrada                    ; Endereço do buffer
      mov edx, tamanhoBuffer                    ; Tamanho do buffer
      int sys_call                              ; Executa a chamada do sistema
      ret                                       ; Retorna da sub-rotina