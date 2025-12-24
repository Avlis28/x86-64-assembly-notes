;================================
;Hello World- Linux AMD64 
;NASM + syscalls diretas 
;================================

;nasm -f elf64 hello.asm (codigo bash compilador asm)
; ld -s -o hello ./hello.o (Linkedição)
;retorna um hello.o (new file) = linguagem baixo nivel compilada 

;================================
;em ASSEMBLY temos 3 sections 
;section .data/ section .text/section .bss
;================================


section .data                        ;constantes usadas durante o programa 
     msg db "Hello, world!",  0xA    ;label de apontamento que  vai apontar para um local na memoria/ 0xA tabela ASCII  vem como quebra de linhas para linguagem baixo nivel
     tam equ $ - msg                 ;sinaliza a saida a quantidade de caracteres na saida 


section .text                        ;Usada junto com global _start, usamos para iniciar o programa           

global _start                        ;label obrigatoria 

_start:
    mov eax,    0x4                  ;vou mandar algo para a saida padrão 
    mov ebx,    0x1                  ;paridade com saida padrão ebx
    mov ecx,    msg                  
    mov edx,    tam                  
    int         0x80
    mov eax,    0x1                  ;SO (Operation System), estou terminando o programa
    mov ebx,    0x0                  ;SO (Operation System), o valor de retorno é 0 
    int         0x80
