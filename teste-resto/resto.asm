%include "bibliotecaE.inc"

section .text

global _start

_start:

    mov rdx, 0x0                ; Resto da divisão
    mov rax, 0xa                ; Número a ser testado
    mov rbx, 0x3                ; Divisor para teste de paridade (2)
    div rbx                     ; Divide RAX por RBX, quociente em RAX, resto em RDX

    mov rax, rdx                ; Move o resto (RDX) para RAX
    call into_to_string         ; Converte o valor em RAX para string
    call saidaResultado         ; Chama a sub-rotina para exibir o resultado 


saida:
    mov rax, sys_exit           ; Chamada de saída do programa
    mov rdi, ret_exit           ; Código de retorno (0 = sucesso)
    syscall                     ; Chama a interrupção do sistema para sair do programa
