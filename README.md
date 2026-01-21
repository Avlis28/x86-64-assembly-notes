# x86-64 Assembly Notes

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Linux](https://img.shields.io/badge/OS-Linux-blue.svg)](https://www.linux.org/)
[![Assembly](https://img.shields.io/badge/Language-Assembly%20x86--64-red.svg)](https://en.wikibooks.org/wiki/X86_Assembly)
[![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen.svg)](./CORRECOES.md)

## 📚 Descrição

Este repositório reúne notas, exemplos e exercícios de **Assembly x86-64** para Linux, com foco em:

- ✅ Código em **NASM** (Netwide Assembler)
- ✅ **Syscalls diretas** (instrução `syscall`) sem dependência de libc
- ✅ Interface direta CPU ↔ Kernel Linux
- ✅ Padrão **System V AMD64 ABI**
- ✅ Código educacional e comentado

> **Status:** Todos os 10 projetos compilando com sucesso ✓

## 🏗️ Arquitetura

| Item | Especificação |
|------|---------------|
| **CPU** | x86-64 (AMD64 / Intel 64) |
| **SO** | Linux (64-bit) |
| **Formato** | ELF64 |
| **Assembler** | NASM (Netwide Assembler) |
| **Linker** | GNU ld |
| **Syscalls** | Instrução `syscall` (x86-64 nativa) |
| **ABI** | System V AMD64 |
| **Parâmetros** | RDI, RSI, RDX, RCX, R8, R9 |

## 📁 Estrutura de Projetos

Todos os projetos estão compilando com sucesso. Lista completa:

| Projeto | Status | Descrição |
|---------|--------|-----------|
| `arrays/` | ✅ | Manipulação de arrays em memory |
| `basics-entrada/` | ✅ | Leitura de entrada padrão (stdin) |
| `basics-saida/` | ✅ | Hello World - saída padrão (stdout) |
| `biblioteca/` | ✅ | Biblioteca com funções reutilizáveis |
| `calculadora/` | ✅ | Operações matemáticas básicas |
| `comparar-valores/` | ✅ | Comparação e jumps condicionais |
| `converter/` | ✅ | Conversão inteiro ↔ string (64-bit) |
| `registradores/` | ✅ | Demonstração de registradores 64-bit |
| `teste/` | ✅ | Teste de arrays e saída |
| `teste-resto/` | ✅ | Teste de paridade de números |

## 📝 Exemplo de Código

Aqui está um exemplo simples (echo) em Assembly x86-64 que imprime um prompt, lê até 128 bytes do stdin e ecoa de volta:

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

## 🔨 Compilação e Linkedição

Para montar e linkar no sistema x86-64:

```bash
# Compilar (NASM → Objeto ELF64)
nasm -f elf64 projeto.asm -o projeto.o

# Linkar (Objeto → Executável)
ld -s -o projeto projeto.o

# Executar
./projeto
```

### 📚 Com Makefile

Todos os projetos incluem makefile:

```bash
cd arrays/
make            # Compila tudo
make clean      # Remove .o e executável
```

Padrão de makefile:

```makefile
nome = projeto

all: $(nome)

$(nome): $(nome).o
	ld -s -o $(nome) $(nome).o

%.o: %.asm 
	nasm -f elf64 $< -o $@
```

## 📖 Documentação

Este repositório inclui documentação completa sobre normas e convenções:

### 📄 [CORRECOES.md](./CORRECOES.md)
Relatório detalhado de todas as correções realizadas (21 jan 2026):
- 10 categorias de correções
- Exemplos antes/depois
- Referências técnicas
- Status de compilação

### 📄 [NORMAS_ASSEMBLY.md](./NORMAS_ASSEMBLY.md)
Guia completo de estilo e convenções:
- Convenções de arquivo
- Padrões de makefile
- Registradores 64-bit
- Convenção de chamada (ABI x86-64)
- Syscalls Linux
- Padrões de comentários
- Checklist pré-commit

## 🎯 Convenções de Código

### Registradores 64-bit
```assembly
RAX, RBX, RCX, RDX    ; Registradores gerais
RSI, RDI              ; Source/Destination Index
RBP, RSP              ; Base/Stack Pointer
R8-R15                ; Registradores extras
```

### Parâmetros (System V AMD64 ABI)
```assembly
; Função: resultado = funcao(param1, param2, param3)
mov rdi, param1       ; 1º parâmetro
mov rsi, param2       ; 2º parâmetro
mov rdx, param3       ; 3º parâmetro
call funcao
; RAX contém retorno
```

### Syscalls
```assembly
mov rax, numero       ; Número da syscall
mov rdi, arg1         ; 1º argumento
mov rsi, arg2         ; 2º argumento
mov rdx, arg3         ; 3º argumento
mov r10, arg4         ; 4º argumento (não RCX!)
mov r8,  arg5         ; 5º argumento
mov r9,  arg6         ; 6º argumento
syscall               ; Executa
```

## 📊 Commits Recentes

```
d51bbe2 - docs: adicionar resumo visual dos commits e correções
b8a234d - docs: adicionar guia de normas e estilo para código assembly x86-64
01c2ac1 - docs: adicionar relatório de correções e normas aplicadas
6da8b4c - fix(makefiles): corrigir variáveis e regras de compilação
```

Veja [git log](https://github.com/Avlis28/x86-64-assembly-notes/commits/main) para histórico completo.

## ✅ Checklist de Qualidade

Todo novo código deve seguir:

- [ ] Compila sem erros: `make`
- [ ] Registradores 64-bit (RAX, não EAX)
- [ ] ABI x86-64 respeitada
- [ ] Comentários em português
- [ ] Blocos de documentação com `; ====...`
- [ ] Makefile com variável `nome`
- [ ] Includes com extensão `.inc`

## 🚀 Como Contribuir

1. Fork este repositório
2. Crie uma branch (`git checkout -b feature/minhaFeatura`)
3. Faça as alterações respeitando [NORMAS_ASSEMBLY.md](./NORMAS_ASSEMBLY.md)
4. Commit com mensagem descritiva
5. Push para a branch
6. Abra um Pull Request

## 📝 Licença

Este projeto está sob licença [MIT](./LICENSE).

## 👤 Autor

Código educacional para aprendizado de Assembly x86-64 em Linux.

---

**Última atualização:** 21 de janeiro de 2026  
**Status de Compilação:** ✅ Todos os 10 projetos OK
