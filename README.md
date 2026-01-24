# 📚 x86-64 Assembly Notes - Documentação Completa

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Linux](https://img.shields.io/badge/OS-Linux-blue.svg)](https://www.linux.org/)
[![Assembly](https://img.shields.io/badge/Language-Assembly%20x86--64-red.svg)](https://en.wikibooks.org/wiki/X86_Assembly)
[![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen.svg)](./CORRECOES.md)
[![NASM](https://img.shields.io/badge/Assembler-NASM-orange.svg)](https://www.nasm.us/)

---

## 🎯 Descrição Geral

Este repositório contém **uma coleção educacional completa de Assembly x86-64 para Linux**, com 10 projetos funcionais que exploram:

- ✅ **Programação em NASM** (Netwide Assembler)
- ✅ **Syscalls diretas** via instrução `syscall` (sem dependência de libc)
- ✅ **Interface CPU ↔ Kernel** (Linux nativo)
- ✅ **System V AMD64 ABI** - Padrão de convenção de chamada
- ✅ **Registradores x86-64** (RAX, RBX, RCX, RDX, RSI, RDI, R8-R15)
- ✅ **I/O em Assembly** (stdin, stdout, stderr)
- ✅ **Manipulação de memória** (arrays, buffers, conversões)
- ✅ **Operações aritméticas** e lógicas
- ✅ **Jumps e comparações** condicionais
- ✅ **Funções e bibliotecas** reutilizáveis

> **Status:** ✅ Todos os 10 projetos compilando e executando com sucesso!  
> **Última atualização:** 24 de janeiro de 2026

---

## 🏗️ Especificações Técnicas

| Especificação | Detalhe |
|---|---|
| **Arquitetura CPU** | x86-64 (AMD64 / Intel 64) |
| **Sistema Operacional** | Linux (64-bit) |
| **Formato Executável** | ELF64 (Executable and Linkable Format) |
| **Assembler** | NASM (Netwide Assembler) |
| **Linker** | GNU ld (Linker padrão do GNU) |
| **Syscalls** | Instrução `syscall` (x86-64 nativa) |
| **Convenção ABI** | System V AMD64 ABI (Application Binary Interface) |
| **Parâmetros de Função** | RDI, RSI, RDX, RCX, R8, R9 (ordem) |
| **Registrador Retorno** | RAX (até 64-bit), RDX:RAX (até 128-bit) |
| **Registradores Preservados** | RBX, RBP, RSP, R12-R15 (callee-saved) |
| **Registradores Temporários** | RAX, RCX, RDX, RSI, RDI, R8-R11 (caller-saved) |

---

## 📁 Estrutura Completa do Repositório

```
x86-64-assembly-notes/
├── README.md                    # Este arquivo (documentação principal)
├── NORMAS_ASSEMBLY.md           # Guia de estilo e convenções
├── CORRECOES.md                 # Relatório detalhado de correções aplicadas
├── RESUMO_COMMITS.txt           # Histórico de commits e mudanças
├── LICENSE                      # Licença MIT
│
├── 📂 basics-saida/             # Projeto 1: Hello World (saída básica)
│   ├── makefile
│   ├── saida-hello.asm          # Programa Hello World
│   ├── saida-hello.o            # Objeto compilado
│   └── saida-hello              # Executável
│
├── 📂 basics-entrada/           # Projeto 2: Entrada de dados
│   ├── makefile
│   ├── entrada.asm              # Leitura do stdin
│   ├── entrada.o
│   └── entrada
│
├── 📂 registradores/            # Projeto 3: Uso de registradores
│   ├── makefile
│   ├── registradores.asm        # Demonstração de todos os registradores
│   ├── registradores.o
│   └── registradores
│
├── 📂 arrays/                   # Projeto 4: Manipulação de arrays
│   ├── makefile
│   ├── arrays.asm               # Trabalho com arrays em memória
│   ├── bibliotecaE.inc          # Include com funções utilitárias
│   ├── arrays.o
│   └── arrays
│
├── 📂 comparar-valores/         # Projeto 5: Comparações condicionais
│   ├── makefile
│   ├── valores.asm              # Jumps e comparações (CMP, JGE, JLE)
│   ├── valores.o
│   └── valores
│
├── 📂 converter/                # Projeto 6: Conversão inteiro ↔ string
│   ├── makefile
│   ├── converter.asm            # Conversão de tipos
│   ├── converter.o
│   └── converter
│
├── 📂 calculadora/              # Projeto 7: Operações matemáticas
│   ├── makefile
│   ├── calculadora.asm          # Calculadora básica (+, -)
│   ├── calculadora.inc          # Include da calculadora
│   ├── calculadora.o
│   └── calculadora
│
├── 📂 biblioteca/               # Projeto 8: Biblioteca de funções
│   ├── makefile
│   ├── biblioteca.inc           # Funções reutilizáveis
│   ├── tstBiblioteca.asm        # Teste da biblioteca
│   ├── tstBiblioteca.o
│   └── tstBiblioteca
│
├── 📂 teste/                    # Projeto 9: Testes de arrays
│   ├── makefile
│   ├── teste.asm                # Programa teste
│   ├── bibliotecaE.inc
│   ├── teste.o
│   └── teste
│
└── 📂 teste-resto/              # Projeto 10: Teste de paridade
    ├── makefile
    ├── par-impar.asm            # Verifica se número é par/impar
    ├── resto.asm
    ├── bibliotecaE.inc
    ├── par-impar.o
    └── par-impar
```

---

## 🚀 Projetos Detalhados

### 1️⃣ **basics-saida/** - Hello World (Saída Padrão)

**Objetivo:** Demonstrar a syscall básica de escrita em stdout.

**Características:**
- Uso de `syscall` instrução x86-64
- Syscall #1 (SYS_WRITE) para escrever na saída
- Syscall #60 (SYS_EXIT) para terminar o programa
- Formato ELF64
- Sem dependência de libc

**Compilação:**
```bash
cd basics-saida
make
./saida-hello
# Saída: Hello, world!
```

---

### 2️⃣ **basics-entrada/** - Leitura de Entrada

**Objetivo:** Ler dados do stdin e armazená-los em um buffer.

**Características:**
- Syscall #0 (SYS_READ) para ler da entrada
- Syscall #1 (SYS_WRITE) para exibir prompt
- Uso de buffer em seção .bss
- Manipulação de constantes e labels

**Fluxo:**
1. Exibe prompt: "entre com sua mensagem:"
2. Lê até 1 byte do stdin
3. Armazena em buffer

**Compilação:**
```bash
cd basics-entrada
make
echo "teste" | ./entrada
```

---

### 3️⃣ **registradores/** - Demonstração de Registradores

**Objetivo:** Documentar e demonstrar todos os registradores x86-64.

**Registradores 64-bit Cobertos:**

| Registrador | Nome | Uso Típico | Callee-Saved? |
|---|---|---|---|
| RAX | Acumulador | Retorno de função, cálculos | ❌ |
| RBX | Base | Variáveis locais | ✅ |
| RCX | Contador | Loops, 4º argumento | ❌ |
| RDX | Dados | 3º argumento, divisão | ❌ |
| RSI | Source Index | 2º argumento | ❌ |
| RDI | Dest Index | 1º argumento | ❌ |
| RBP | Base Pointer | Frame pointer | ✅ |
| RSP | Stack Pointer | Pilha (não alterar) | ✅ |
| R8-R11 | Extra | 5º-6º arg, temporários | ❌ |
| R12-R15 | Extra | Variáveis locais | ✅ |

**Compilação:**
```bash
cd registradores
make
./registradores
```

---

### 4️⃣ **arrays/** - Manipulação de Arrays

**Objetivo:** Trabalhar com estruturas de dados em memória.

**Características:**
- Define arrays em seção .data
- Acessa elementos via indexação de memória
- Usa loops para iterar sobre arrays
- Integração com biblioteca include

**Compilação:**
```bash
cd arrays
make
./arrays
```

---

### 5️⃣ **comparar-valores/** - Comparações e Jumps Condicionais

**Objetivo:** Usar instruções CMP e jumps condicionais (JGE, JLE, JNE, etc).

**Instruções Cobertas:**
- `CMP` - Compara dois valores
- `JGE` - Jump if greater or equal (>=)
- `JLE` - Jump if less or equal (<=)
- `JG` - Jump if greater (>)
- `JL` - Jump if less (<)
- `JE` - Jump if equal (==)
- `JNE` - Jump if not equal (!=)

**Compilação:**
```bash
cd comparar-valores
make
./valores
# Saída: x eh maior que y
```

---

### 6️⃣ **converter/** - Conversão Inteiro ↔ String

**Objetivo:** Converter entre tipos de dados (string para inteiro e vice-versa).

**Funções Implementadas:**

#### `string_to_int`
Converte string decimal para inteiro (64-bit).

Algoritmo:
1. Inicializa acumulador RBX = 0
2. Para cada dígito:
   - Carrega byte da string
   - Subtrai '0' para converter '0'-'9' em 0-9
   - RBX = RBX * 10 + dígito
3. Retorna resultado em RAX

#### `int_to_string`
Converte inteiro para string decimal.

Algoritmo:
1. Usa divisão sucessiva por 10
2. Acumula dígitos (resto da divisão)
3. Escreve dígitos de trás para frente
4. Termina com '\n'

**Compilação:**
```bash
cd converter
make
./converter
```

---

### 7️⃣ **calculadora/** - Operações Matemáticas

**Objetivo:** Implementar operações aritméticas básicas (+, -).

**Operações Suportadas:**
- Adição (+)
- Subtração (-)
- Multiplicação (*)
- Divisão (/)

**Fluxo:**
1. Lê primeiro número
2. Lê segundo número
3. Lê operador
4. Executa operação
5. Exibe resultado

**Compilação:**
```bash
cd calculadora
make
./calculadora
```

---

### 8️⃣ **biblioteca/** - Biblioteca de Funções Reutilizáveis

**Objetivo:** Criar um conjunto de funções que podem ser incluídas em outros projetos.

**Funções Exportadas:**

- `saidaResultado` - Exibe um buffer no stdout
- `string_to_int` - Converte string para inteiro
- `int_to_string` - Converte inteiro para string

**Constantes Definidas:**
```assembly
lf          equ  0xa        ; Line Feed
null        equ  0xd        ; CR
sys_exit    equ  0x3c       ; SYS_EXIT
sys_read    equ  0x0        ; SYS_READ
sys_write   equ  0x1        ; SYS_WRITE
std_in      equ  0x0        ; stdin
std_out     equ  0x1        ; stdout
```

**Compilação:**
```bash
cd biblioteca
make
./tstBiblioteca
```

---

### 9️⃣ **teste/** - Testes de Arrays

**Objetivo:** Testar a funcionalidade de arrays e saída.

**Testes Realizados:**
- Definição e acesso a arrays
- Iteração sobre elementos
- Exibição formatada

**Compilação:**
```bash
cd teste
make
./teste
```

---

### 🔟 **teste-resto/** - Teste de Paridade

**Objetivo:** Verificar se um número é par ou impar (cálculo do resto).

**Operação:**
1. Recebe um número
2. Calcula resto da divisão por 2
3. Se resto = 0: número é par
4. Se resto = 1: número é ímpar

**Compilação:**
```bash
cd teste-resto
make
./par-impar
```

---

## 🔧 Como Compilar e Executar

### Pré-requisitos

```bash
# Instalar NASM (Netwide Assembler)
sudo apt-get install nasm

# Instalar ferramentas de linker (GNU binutils)
sudo apt-get install binutils
```

### Compilar um Projeto

```bash
# Ir para o diretório do projeto
cd <nome-do-projeto>

# Compilar com make (recomendado)
make

# Ou compilar manualmente
nasm -f elf64 <arquivo.asm> -o <arquivo.o>
ld -s -o <executável> <arquivo.o>
```

### Executar

```bash
./<nome-do-executável>
```

### Exemplo Completo

```bash
cd basics-saida
make
./saida-hello
# Saída: Hello, world!
```

---

## 📋 Convenções e Padrões

### System V AMD64 ABI (Convenção de Chamada)

Este repositório segue rigorosamente o **System V AMD64 ABI**, o padrão oficial para x86-64 em sistemas UNIX/Linux.

**Passagem de Parâmetros:**
```
1º parâmetro  → RDI
2º parâmetro  → RSI
3º parâmetro  → RDX
4º parâmetro  → RCX
5º parâmetro  → R8
6º parâmetro  → R9
7º+ (stack)   → Pilha
```

**Retorno de Valores:**
```
Inteiro/Ponteiro (≤64-bit) → RAX
Inteiro (65-128 bit)        → RDX:RAX (RDX=high, RAX=low)
```

**Registradores Preservados (callee-saved):**
```
RBX, RBP, RSP, R12, R13, R14, R15
```

**Registradores Temporários (caller-saved):**
```
RAX, RCX, RDX, RSI, RDI, R8, R9, R10, R11
```

### Estrutura Básica de Arquivo Assembly

```assembly
; ======================================================
; Comentário descritivo do programa
; ======================================================

section .data
    msg     db "Hello", 0xA
    tam     equ $ - msg

section .bss
    buffer  resb 256

section .text
    global _start

_start:
    mov rax, 60         ; SYS_EXIT
    mov rdi, 0          ; retorno = 0
    syscall
```

### Nomenclatura de Makefiles

Todos os makefiles seguem este padrão:

```makefile
nome = projeto_name

all: $(nome)

$(nome): $(nome).o
ld -s -o $(nome) $(nome).o

%.o: %.asm
nasm -f elf64 $< -o $@
```

---

## 📚 Referência de Syscalls x86-64

### Syscalls Mais Comuns

| Número | Nome | Parâmetros | Retorno |
|---|---|---|---|
| **0** | `read` | RDI=fd, RSI=buf, RDX=count | RAX=bytes lidos |
| **1** | `write` | RDI=fd, RSI=buf, RDX=count | RAX=bytes escritos |
| **2** | `open` | RDI=path, RSI=flags, RDX=mode | RAX=fd |
| **3** | `close` | RDI=fd | RAX=status |
| **60** | `exit` | RDI=code | (sem retorno) |

### Constantes de Descritores de Arquivo

```assembly
stdin   equ 0           ; Entrada padrão
stdout  equ 1           ; Saída padrão
stderr  equ 2           ; Saída de erro
```

---

## 🔍 Instruções x86-64 Mais Utilizadas

### Movimento de Dados
```assembly
mov rax, rbx          ; Copia RBX para RAX
lea rsi, [buffer]     ; Carrega endereço efetivo
```

### Operações Aritméticas
```assembly
add rax, rbx          ; RAX = RAX + RBX
sub rax, rbx          ; RAX = RAX - RBX
imul rax, rbx         ; RAX = RAX * RBX (signed)
div rbx               ; RAX = RAX / RBX, RDX = resto
```

### Operações Lógicas
```assembly
and rax, rbx          ; RAX = RAX AND RBX
or rax, rbx           ; RAX = RAX OR RBX
xor rax, rbx          ; RAX = RAX XOR RBX
```

### Comparação e Jumps
```assembly
cmp rax, rbx          ; Compara RAX com RBX
je .label             ; Jump if equal
jne .label            ; Jump if not equal
jg .label             ; Jump if greater
jl .label             ; Jump if less
jge .label            ; Jump if ≥
jle .label            ; Jump if ≤
```

### Loops
```assembly
loop .label           ; RCX--, jump se RCX != 0
loopz .label          ; Loop se zero flag = 1
loopnz .label         ; Loop se zero flag = 0
```

### Stack (Pilha)
```assembly
push rax              ; Empilha RAX
pop rbx               ; Desempilha para RBX
call .funcao          ; Chama função
ret                   ; Retorna
```

---

## 🐛 Correções Realizadas

Este repositório passou por correções significativas documentadas em [CORRECOES.md](CORRECOES.md) e [RESUMO_COMMITS.txt](RESUMO_COMMITS.txt).

### Principais Correções:

1. **Makefiles Corrigidos** - variáveis `nome`, dependências
2. **Conversão 32-bit → 64-bit** - elf32 → elf64, EAX → RAX
3. **Includes Renomeados** - .asm → .inc
4. **ABI Compliance** - Sistema V AMD64
5. **Syscalls Atualizadas** - int 0x80 → syscall
6. **Registradores Padronizados** - RDI, RSI, RDX, RCX, R8, R9

**Status:** ✅ Todos os 10 projetos compilando com sucesso!

---

## 📖 Recursos de Aprendizado

### Documentação Interna
- [NORMAS_ASSEMBLY.md](NORMAS_ASSEMBLY.md) - Guia de estilo e convenções
- [CORRECOES.md](CORRECOES.md) - Detalhamento de todas as correções
- [RESUMO_COMMITS.txt](RESUMO_COMMITS.txt) - Histórico de mudanças

### Referências Externas
- [NASM Manual](https://www.nasm.us/doc/) - Documentação oficial
- [System V AMD64 ABI](https://refspecs.linuxbase.org/elf/x86-64-abi-0.99.pdf) - Especificação oficial
- [OSDev.org x86-64](https://wiki.osdev.org/X86-64) - Comunidade de desenvolvimento
- [Linux Syscalls](https://man7.org/linux/man-pages/man2/syscalls.2.html) - Referência Linux
- [Intel x86-64 Manual](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/) - Manual da Intel

---

## 💡 Exemplos de Uso

### Compilar Todos os Projetos

```bash
#!/bin/bash
for dir in */; do
    if [ -f "$dir/makefile" ]; then
        cd "$dir"
        make
        cd ..
    fi
done
```

### Limpar Todos os Projetos

```bash
#!/bin/bash
for dir in */; do
    if [ -f "$dir/makefile" ]; then
        cd "$dir"
        make clean
        cd ..
    fi
done
```

---

## 📜 Licença

Este projeto está licenciado sob a **MIT License** - veja [LICENSE](LICENSE) para detalhes.

---

## 👤 Autor

**Repositório Educacional - Assembly x86-64**

Este é um projeto educacional focado em ensinar os fundamentos de Assembly x86-64 para Linux, com ênfase em:
- Syscalls diretas (sem libc)
- Conformidade com ABI System V AMD64
- Código bem documentado e comentado
- Boas práticas de programação em Assembly

---

## 🔄 Histórico de Atualizações

### Versão 2.0 (24 de janeiro de 2026)
- ✅ Todos os 10 projetos compilando e testados
- ✅ Documentação completa de cada projeto
- ✅ Referências de syscalls e instruções
- ✅ Guias de compilação e execução
- ✅ Exemplos de código comentado
- ✅ README completo com estrutura profissional

### Versão 1.0 (21 de janeiro de 2026)
- ✅ Correção de makefiles
- ✅ Conversão de 32-bit para 64-bit
- ✅ Aplicação de normas ABI
- ✅ Documentação de correções

---

## ❓ FAQ

**P: Posso rodar isso em Windows?**
R: Não. Este código é específico para Linux x86-64.

**P: Preciso de libc?**
R: Não! Todo este código usa syscalls diretas via `syscall`.

**P: Por que usar Assembly?**
R: Para aprender como a CPU funciona, otimizar performance crítica, desenvolver kernels/bootloaders, e compreender linguagens de alto nível.

**P: Qual é a diferença entre int 0x80 e syscall?**
R: `int 0x80` é a forma antiga. `syscall` é a forma nativa x86-64 e é mais rápida.

**P: Como debugar Assembly?**
R: Use `gdb` (GNU Debugger): `gdb ./executável`

---

## ✅ Checklist de Verificação

Antes de commitar novos projetos, verifique:

- [ ] Arquivo `.asm` com comentários descritivos
- [ ] Makefile com variável `nome` definida
- [ ] Usa `syscall` (não `int 0x80`)
- [ ] Registradores 64-bit (RAX, RBX, etc.)
- [ ] Segue ABI System V AMD64
- [ ] Compila com `nasm -f elf64`
- [ ] Linkado com `ld -s -o`
- [ ] Código comentado e legível
- [ ] Teste manual realizado
- [ ] Include usando `.inc`

---

**Última revisão:** 24 de janeiro de 2026  
**Status:** ✅ Completo e Funcional  
**Suporte:** Educacional (Linux x86-64)
