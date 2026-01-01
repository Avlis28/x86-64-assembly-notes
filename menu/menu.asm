%include "menu.inc"

section .data
title db lf, '+-------------+', lf,'| Calculadora |', lf,'+-------------+', lf, null
obVal1 db lf, 'valor 1:', null
obVal2 db lf, 'valor 2:', null
opc1 db lf, '1. somar', null
opc2 db lf, '2. subtrair', null
opc3 db lf, '3. multiplicar', null
opc4 db lf, '4. dividir', null
msgOpc db lf, 'deseja realizar?', null
msgErr db lf, 'opcao invalida!', lf, 'tente novamente!', lf, null 
p1 db lf, 'processo de adicao,', lf, null 
p2 db lf, 'processo de subtracao,', lf, null 
p3 db lf, 'processo de multiplicacao,', lf, null
p4 db lf, 'processo de divisao,', lf, null
msgFim db lf, 'fim do programa!', lf, null

section .bss 

    opc resb 2  
    num1 resb 4 
    num2 resb 4  

section .text 

global _start 

_start:
   mov rsi, title 
   call mstrsaida

   ; menu de opcoes 
   mov rsi, opc1
   call mstrsaida
   mov rsi, opc2
   call mstrsaida
   mov rsi, opc3
   call mstrsaida
   mov rsi, opc4
   call mstrsaida

   ; obter a opcao do usuario 
   mov rsi, msgOpc
   call mstrsaida
   mov rax, sys_read
   mov rdi, std_in
   mov rsi, opc
   mov rdx, 0x2
   syscall

   ; converte e vai para a opcao escolhida
   mov ah, [opc]
   sub ah, '0'

   ; verifica se a opcao e valida
   cmp ah, 4
   jg msgErro
   cmp ah, 1
   jl msgErro

   ; obter os valores
   mov rsi, obVal1
   call mstrsaida
   mov rax, sys_read
   mov rbx, std_in
   mov rsi, num1
   mov rdx, 0x4
   syscall  

   mov rsi, obVal2
   call mstrsaida
   mov rax, sys_read
   mov rbx, std_in
   mov rsi, num2
   mov rdx, 0x4
   syscall

   ; seleciona a funcao
   mov ah, [opc]
   sub ah, '0'

   cmp ah, 1
   je adicionar 
   cmp ah, 2
   je subtrair
   cmp ah, 3
   je multiplicar
   cmp ah, 4
   je dividir
   mov rsi, msgErr
   call mstrsaida
   jmp saida

; rotinas de saida e funcoes
saida:
   mov rsi, msgFim
   call mstrsaida

   mov rax, sys_exit 
   mov rdi, ret_exit 
   syscall  

; funcoes a serem executadas
adicionar:
   mov rsi, p1
   call mstrsaida
   jmp saida

subtrair:
   mov rsi, p2
   call mstrsaida
   jmp saida

multiplicar:
   mov rsi, p3
   call mstrsaida
   jmp saida

dividir:
   mov rsi, p4
   call mstrsaida
   jmp saida

msgErro:
   mov rsi, msgErr
   call mstrsaida
   jmp saida