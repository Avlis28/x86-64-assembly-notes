section .data 
        lf              equ      10            ; Line Feed  
        null            equ      0             ; Final da String 
        sys_exit        equ      60            ; Código chamada para o fim
        sys_read        equ      0             ; Operação de leitura 
        sys_write       equ      1             ; Operação de escrita 
        ret_exit        equ      0             ; Operação realizada com sucesso 
        std_in          equ      0             ; Entrada padrão 
        std_out         equ      1             ; Saída padrão
        tamanhoBuffer   equ      10            ; Tamanho do buffer de entrada

section .bss
bufferEntrada   resb   tamanhoBuffer            ; Reserva 10 bytes para o buffer de entrada

section .text

; ---------------------------------
; saída no terminal da string 
; ---------------------------------
mstrsaida:
   mov rcx, rsi  ; Ponteiro da string em rcx (esperado de rsi no chamador)
   call tamString
   mov rax, sys_write 
   mov rdi, std_out
   mov rsi, rcx  ; Buffer
   syscall 
   ret 

; ---------------------------------
; calcular o tamanho da string 
; entrada: valor da string em rcx 
; saída: tamanho da string em rdx 
; ---------------------------------
tamString: 
    mov rdx, rcx 
  proxchar: 
    cmp byte [rdx], null 
    jz terminei 
    inc rdx
    jmp proxchar 
  terminei:
    sub rdx, rcx
    ret 

; ---------------------------------
; leitura de entrada
; ---------------------------------
mstrentrada:
   mov rax, sys_read
   mov rdi, std_in
   mov rsi, bufferEntrada
   mov rdx, tamanhoBuffer
   syscall
   ret

; ---------------------------------
; saída do resultado
; ---------------------------------
saidaResultado:
   mov rcx, rsi  ; Ponteiro da string em rcx (de int_to_string)
   call tamString
   mov rax, sys_write                       ; Chamada de escrita    
   mov rdi, std_out                          ; Saída padrão
   mov rsi, rcx                              ; Buffer
   syscall                                  ; Executa a chamada do sistema
   ret                                       ; Retorna da sub-rotina

; ------------------------------
; string para inteiro 
; ------------------------------ 
; entrada --> RSI (valor conv.), RCX tam 
; saída --> RAX 
; ------------------------------
string_to_int:           
   xor rbx, rbx                               ; RBX = 0 (acumulador)
.prox_digito:                                        
   movzx  rax, byte[rsi]        
   inc rsi      
   sub al, "0"                 
   imul rbx, 10
   add rbx, rax                               ; RBX = RBX*10 + RAX 
   loop .prox_digito                          ; repetir para todos os dígitos
   mov rax, rbx                               ; resultado em RAX
   ret

; ------------------------------
; inteiro para string 
; ------------------------------ 
; entrada --> inteiro em RAX 
; saída --> bufferEntrada (ponteiro em RSI)
int_to_string:
   mov rbx, 10
   lea rsi, [bufferEntrada]
   add rsi, 9 
   mov byte[rsi], null
.prox_digito:
   xor rdx, rdx                                ; zera RDX para divisão
   div rbx 
   add dl, '0'
   dec rsi
   mov [rsi], dl
   test rax, rax
   jnz .prox_digito
   ret
