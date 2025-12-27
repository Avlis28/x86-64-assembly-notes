========================================
 x86-64 Assembly Notes
========================================

Descrição
-------
Este repositório reúne notas e exemplos de Assembly x86-64 para Linux, escritos com NASM e syscalls diretas (instrução syscall). O foco é ensinar I/O e fluxo mínimo sem libc, direto da CPU para o kernel.

Arquitetura
----------
- CPU: x86-64 (AMD64 / Intel 64)
- Sistema Operacional: Linux (ELF64)
- Assembler: NASM
- Linker: GNU ld
- Interface de chamadas de sistema: instrução syscall

Exemplo de código
------------------
Aqui está um exemplo simples (echo) em Assembly x86-64 que: imprime um prompt, lê até 128 bytes do stdin e ecoa de volta.

```asm
; echo64.asm - I/O básico em Assembly x86-64 (Linux)
; NASM + syscalls (syscall instruction)

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
    ; write(1, prompt, plen)
    mov rax, 1          ; sys_write (1)
    mov rdi, 1          ; fd = stdout
    mov rsi, prompt
    mov rdx, plen
    syscall

    ; read(0, buffer, 128)
    mov rax, 0          ; sys_read (0)
    mov rdi, 0          ; fd = stdin
    mov rsi, buffer
    mov rdx, 128
    syscall
    mov r12, rax        ; bytes lidos

    ; write(1, outmsg, olen)
    mov rax, 1
    mov rdi, 1
    mov rsi, outmsg
    mov rdx, olen
    syscall

    ; write(1, buffer, bytes_lidos)
    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, r12
    syscall

    ; exit(0)
    mov rax, 60         ; sys_exit (60)
    xor rdi, rdi        ; status = 0
    syscall
```

Compilação e linkedição
------------------------
Para montar e linkar no sistema x86-64: 

```sh
nasm -f elf64 src/echo64.asm -o echo64.o
ld echo64.o -o echo64
```


Commit: docs: update README with banner and structured layout
