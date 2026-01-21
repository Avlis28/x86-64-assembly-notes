%include "../biblioteca/biblioteca.inc"

section .data 
   v1 db "105",lf, null

section .text

global _start

_start:
   ; CORRIGIDO: Convertido de 32-bit (elf32) para 64-bit (elf64)
   ; Registradores 64-bit: RSI, RCX, RBX, RDX em vez de ESI, ECX, EBX, EDX
   call converte_valor
   call mostrar_resultado

   ; Encerrar programa
   mov rax, sys_exit                ; SYS_EXIT = 60
   mov rdi, ret_exit                ; Código de retorno
   syscall                          ; Executa a chamada do sistema

converte_valor:
   ; CORRIGIDO: usar registradores 64-bit (RSI, RCX, RAX)
   lea rsi, [v1]                              ; RSI = endereço da string (1º parâmetro)
   mov rcx, 0x3                               ; RCX = tamanho da string (3 dígitos)
   call string_to_int                         ; Converte string para inteiro em RAX
   add rax, 0x2                               ; Adiciona 2 ao resultado
   ret 

mostrar_resultado:
   ; CORRIGIDO: funções adaptadas para 64-bit (ABI x86-64)
   call int_to_string                       ; Converte inteiro (RAX) para string
   call saidaResultado                      ; Exibe a string no stdout               
   ret 


; ==============================
; FUNÇÃO: string_to_int
; Converte string decimal em inteiro
; ==============================
; Entrada:  RSI = endereço da string (1º param)
;           RCX = tamanho da string (contador)
; Saída:    RAX = valor inteiro convertido
; ==============================
string_to_int:           
   ; CORRIGIDO: usar registrador 64-bit RBX em vez de EBX
   xor rbx, rbx                               ; RBX = 0 (acumulador)
   
.prox_digito:
   movzx rax, byte[rsi]                      ; Carrega próximo dígito (zero-extend para 64-bit)
   inc rsi                                   ; Próximo caractere
   sub al, "0"                               ; Converte '0'-'9' para 0-9
   imul rbx, 0xa                             ; RBX *= 10
   add rbx, rax                              ; RBX += dígito
   loop .prox_digito                         ; Repete enquanto RCX > 0
   mov rax, rbx                              ; Resultado em RAX
   ret

; ==============================
; FUNÇÃO: int_to_string
; Converte inteiro em string decimal
; ==============================
; Entrada:  RAX = inteiro a converter
; Saída:    bufferEntrada = string resultante
; ==============================
int_to_string:
   ; CORRIGIDO: usar registrador 64-bit (RBX, RSI, RDX) conforme ABI x86-64
   mov rbx, 10                               ; Divisor (base 10)
   lea rsi, [bufferEntrada]                  ; RSI = endereço do buffer
   add rsi, 0x9                              ; Posiciona no final do buffer
   mov byte[rsi], 0xa                        ; Terminador: line feed
   
.prox_digito:
   ; Função para converter inteiro em string (escrita de trás para frente)
   xor rdx, rdx                              ; RDX = 0 (resto da divisão)
   div rbx                                   ; RAX = RAX / 10, RDX = RAX % 10
   add dl, '0'                               ; Converte 0-9 para '0'-'9'
   dec rsi                                   ; Posição anterior no buffer
   mov [rsi], dl                             ; Escreve dígito
   test rax, rax                             ; Verifica se RAX == 0
