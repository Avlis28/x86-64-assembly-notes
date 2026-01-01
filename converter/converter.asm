%include "../biblioteca/biblioteca.asm"

section .data 
   v1 db "105",lf, null

section .text

global _start

_start:
   call converte_valor
   call mostrar_resultado

   mov eax, sys_exit
   mov ebx, ret_exit
   int sys_call

converte_valor:
   lea esi, [v1]                              ; carrega o endereço da string em ESI
   mov ecx, 0x3                               ; tamanho da string (3 caracteres)
   call string_to_int                         ; converte string para inteiro
   add eax, 0x2 
   ret 

mostrar_resultado:
   call int_to_string                       ; converte inteiro para string 
   call saidaResultado                      ; mostra a string resultante               
   ret 


; ------------------------------
; string para inteiro 
; ------------------------------ 
; entrada --> ESI (valor conv.) ECX tam 
; saida --> EAX 
; ------------------------------
string_to_int:           
;função para converter string em inteiro                             
   xor ebx, ebx                               ; EBX = 0 (acumulador)/ zera o registrador                              
.prox_digito:                                        
   movzx  eax, byte[esi]        
   inc esi      
   sub al, "0"                 
   imul ebx, 0xa
   add ebx, eax                               ; EBX = EAX*10 + EAX 
   loop .prox_digito                          ; repetir para todos os digitos/while = enquanto (-- ecx)
   mov eax, ebx                               ; resultado em EAX
   ret

; ------------------------------
; inteiro para string 
; ------------------------------ 
; entrada --> inteiro em EAX 
; saida --> buffer (valor ecx) tam_buffer (EDX)
int_to_string:
   mov ebx, 10
   lea esi, [bufferEntrada]
   add esi, 0x9 
   mov byte[esi], 0xa
.prox_digito:
; função para converter inteiro em string
   xor edx, edx                                ; zera EDX para divisão
   div ebx 
   add dl, '0'
   dec esi
   mov [esi], dl
   test eax, eax
   jnz .prox_digito
   ret 


