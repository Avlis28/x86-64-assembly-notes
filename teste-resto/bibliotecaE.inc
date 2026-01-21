section .data 
        lf              equ      0xa            ; Line Feed  
        null            equ      0x0            ; Null (fim da string) 
        sys_exit        equ      0x3c           ; Codigo chamada para o fim (60)
        sys_read        equ      0x0            ; Operação de leitura 
        sys_write       equ      0x1            ; Operação de escrita 
        ret_exit        equ      0x0            ; Operação realizada com sucesso 
        std_in          equ      0x0            ; Entrada padrão 
        std_out         equ      0x1            ; Saida padrão
        tamanhoBuffer   equ      0xa            ; Tamanho do buffer de entrada

section .bss
        buffer          resq    1              ; Buffer para armazenar a string

section .text


saidaResultado:                               ; label/etiqueta da sub-rotina de saida de resultado
    mov rax, sys_write                        ; Chamada de escrita    
    mov rdi, std_out                          ; Saida padrão (1º argumento)
    mov rsi, buffer                           ; Endereço do buffer (2º argumento)
    mov rdx, tamanhoBuffer                    ; Tamanho do buffer (3º argumento)
    syscall                                   ; Executa a chamada do sistema
    ret                                       ; Retorna da sub-rotina


into_to_string:                               ; label/etiqueta da sub-rotina de conversao de inteiro para string
    mov rsi, buffer             
    add rsi, 0x9
    mov byte [rsi], 0xa 
    mov rbx, 0xa

proximo_digito:                              ; label/etiqueta do proximo digito
    xor rdx, rdx
    div rbx
    add dl, '0'
    mov [rsi], dl
    cmp rax, 0
    jne proximo_digito
    mov rcx, rsi
    ret