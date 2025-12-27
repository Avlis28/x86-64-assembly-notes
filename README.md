🧠 Assembly x86 (32-bit Linux)

Assembly x86 • Linux • NASM • Syscalls Diretas

� � � � �
📌 Descrição
Este repositório contém um programa em Assembly x86 (32 bits) para Linux, utilizando syscalls diretas via int 0x80.
Não é um Hello World trivial.
O programa:
escreve múltiplas mensagens no terminal
lê entrada do usuário (stdin)
ecoa o conteúdo digitado
encerra corretamente o processo
Sem libc.
Sem main.
Sem abstrações modernas.
Apenas CPU → Kernel → Terminal.
🧩 Arquitetura
CPU: x86 (IA-32)
Sistema Operacional: Linux 32-bit
Assembler: NASM
Linker: GNU ld
Modelo: ELF32
Interface: int 0x80

; echo.asm — I/O básico em Assembly x86 (32-bit Linux)
; NASM + syscalls diretas (int 0x80)

section .data
    prompt  db "Digite algo: ", 0xA
    plen    equ $ - prompt

    outmsg  db "Voce digitou: ", 0xA
    olen    equ $ - outmsg

section .bss
    buffer  resb 128

section .text
    global _start

_start:
    ; write(stdout, prompt, plen)
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, prompt
    mov edx, plen
    int 0x80

    ; read(stdin, buffer, 128)
    mov eax, 3          ; sys_read
    mov ebx, 0          ; stdin
    mov ecx, buffer
    mov edx, 128
    int 0x80
    mov esi, eax        ; bytes lidos

    ; write(stdout, outmsg, olen)
    mov eax, 4
    mov ebx, 1
    mov ecx, outmsg
    mov edx, olen
    int 0x80

    ; write(stdout, buffer, bytes_lidos)
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, esi
    int 0x80

    ; exit(0)
    mov eax, 1          ; sys_exit
    xor ebx, ebx
    int 0x80

------------------------------------
compilação e linkedição

nasm -f elf32 src/echo.asm -o echo.o
ld -m elf_i386 echo.o -o echo