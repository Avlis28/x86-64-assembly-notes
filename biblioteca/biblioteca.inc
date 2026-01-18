section .data 
        lf              equ      0xa            ; Line Feet  
        null            equ      0xd            ; Final da String 
        sys_exit        equ      0x3c           ; Codigo chamada para o fim (60)
        sys_read        equ      0x0            ; Operação de leitura 
        sys__write      equ      0x1            ; Operação de escrita 
        ret_exit        equ      0x0            ; Operação realizada com sucesso 
        std_in          equ      0x0            ; Entrada padrão 
        std_out         equ      0x1            ; Saida padrão
        tamanhoBuffer   equ      0xa            ; Tamanho do buffer de entrada

section .bss
bufferEntrada   resb   tamanhoBuffer            ; Reserva 10 bytes para o buffer de entrada


section .text


saidaResultado:
    mov rax, sys__write                       ; Chamada de escrita    
    mov rdi, std_out                          ; Saida padrão (1º argumento)
    mov rsi, bufferEntrada                    ; Endereço do buffer (2º argumento)
    mov rdx, tamanhoBuffer                    ; Tamanho do buffer (3º argumento)
    syscall                                   ; Executa a chamada do sistema
    ret                                       ; Retorna da sub-rotina


into_to_string:

    lea rsi [buffer]             
    add rsi, 0x9
    mov [rsi], 0xa 
    mov rbx, 0xa

proximo_digito:
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov [rsi], dl
    cmp rax, 0
    jne proximo_digito
    mov rcx, rsi
    ret