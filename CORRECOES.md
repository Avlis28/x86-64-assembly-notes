# Relatório de Correções - x86-64 Assembly Notes

**Data:** 21 de janeiro de 2026  
**Commit:** 6da8b4cd5972c71f1b9b5851ddbeb301da51f519

## Resumo Executivo

Foram corrigidos **10 projetos** com múltiplos erros de compilação e estrutura. Todos os projetos agora compilam com sucesso.

---

## 1. CORREÇÕES DE MAKEFILES

### 1.1 Variáveis Não Definidas
**Arquivos:** `arrays/makefile`, `teste/makefile`

**Problema:** A variável `nome` não estava definida no início do makefile, causando expansão vazia.

**Correção:**
```makefile
# ANTES
all: $(nome)      # $(nome) = vazio!

# DEPOIS
nome = arrays     # ou 'teste'
all: $(nome)      # $(nome) = arrays
```

**Erro Observado:** `make: Nada a ser feito para 'all'` ou `cc: fatal error: no input files`

### 1.2 Dependência Circular
**Arquivo:** `teste/makefile`

**Problema:** Alvo `all` apontava para `$(nome).o` em vez de `$(nome)`, causando invocação de regras padrão do make (que tenta usar `cc`).

**Correção:**
```makefile
# ANTES
all: $(nome).o
    ld -s -o $(nome) $(nome).o

# DEPOIS
all: $(nome)
$(nome): $(nome).o
    ld -s -o $(nome) $(nome).o
```

### 1.3 Novos Makefiles
**Arquivos criados:**
- `basics-saida/makefile`
- `registradores/makefile`

**Padrão aplicado:**
```makefile
nome = hello    # ou registradores

all: $(nome)

$(nome): $(nome).o
    ld -s -o $(nome) $(nome).o

%.o: %.asm 
    nasm -f elf64 $< -o $@
```

### 1.4 Dependências Incorretas
**Arquivo:** `calculadora/makefile`

**Problema:** Makefile dependia de `menu.inc` que não existia.

**Correção:**
```makefile
# ANTES
%.o: %.asm menu.inc

# DEPOIS
%.o: %.asm calculadora.inc
```

---

## 2. CORREÇÕES DE INCLUDES

### 2.1 Sintaxe Incorreta em Include
**Arquivo:** `teste/teste.asm` (linha 1)

**Problema:** Ponto extra no nome do arquivo include.

**Correção:**
```assembly
# ANTES
%include ".bibliotecaE.inc"

# DEPOIS
%include "bibliotecaE.inc"
```

**Erro:** `error: unable to open include file .bibliotecaE.inc`

### 2.2 Extensão de Arquivo Incorreta
**Arquivos:**
- `biblioteca/tstBiblioteca.asm`
- `converter/converter.asm`

**Problema:** Include apontava para `.asm` em vez de `.inc`

**Correção:**
```assembly
# ANTES
%include "biblioteca.asm"
%include "../biblioteca/biblioteca.asm"

# DEPOIS
%include "biblioteca.inc"
%include "../biblioteca/biblioteca.inc"
```

**Erro:** `error: unable to open include file biblioteca.asm`

---

## 3. CONVERSÃO DE 32-BIT PARA 64-BIT

### 3.1 Arquivo: converter/converter.asm

#### 3.1.1 Makefile
**Problema:** Compilando com `-f elf32` mas código era 64-bit

**Correção:**
```makefile
# ANTES
%.o: %.asm
    nasm -f elf32 $< -o $@

# DEPOIS
%.o: %.asm
    nasm -f elf64 $< -o $@
```

#### 3.1.2 Registradores 32-bit → 64-bit
**Problema:** Uso de registradores 32-bit incompatível com x86-64 System V AMD64 ABI

**Correção em converter.asm:**
```assembly
# ANTES
lea esi, [v1]          # 32-bit
mov ecx, 0x3           # 32-bit
add eax, 0x2           # 32-bit

# DEPOIS
lea rsi, [v1]          # 64-bit (System V AMD64 ABI 1º param)
mov rcx, 0x3           # 64-bit
add rax, 0x2           # 64-bit
```

#### 3.1.3 Funções de Conversão
**Problema:** Variáveis locais referenciavam registrador não definido

**Correção:**
```assembly
# ANTES
lea rsi, [buffer]      # buffer não existe

# DEPOIS
lea rsi, [bufferEntrada]  # variável correta em .bss
```

---

## 4. CORREÇÕES DE ASSEMBLY (64-bit)

### 4.1 Arquivo: biblioteca/tstBiblioteca.asm

**Problema:** Mistura de registradores 32-bit e 64-bit com instrução inadequada

**Correção:**
```assembly
# ANTES (32-bit)
lea esi, [bufferEntrada]
mov eax, sys_exit
mov ebx, ret_exit
int sys_call        # ❌ Não funciona em 64-bit

# DEPOIS (64-bit + ABI x86-64)
lea rsi, [bufferEntrada]  # System V AMD64: 1º param em RDI/RSI
mov rax, sys_exit         # Número da syscall em RAX
mov rdi, ret_exit         # 1º argumento em RDI
syscall               # ✓ Instrução correta
```

**Convensões ABI System V AMD64 aplicadas:**
- Parâmetro 1: `RDI`
- Parâmetro 2: `RSI`
- Parâmetro 3: `RDX`
- Parâmetro 4: `RCX`
- Número da syscall: `RAX`
- Retorno: `RAX`

### 4.2 Arquivo: teste/teste.asm

**Problema:** Registradores em sintaxe incorreta

**Correção:**
```assembly
# ANTES
mov rdi, 1
lea rsi, [rel newline]
mov rdx, 1

# DEPOIS (comentários adicionados)
mov rdi, 1            ; stdout (1º parâmetro - RDI)
lea rsi, [rel newline] ; endereço (2º parâmetro - RSI)
mov rdx, 1            ; tamanho (3º parâmetro - RDX)
syscall
```

---

## 5. CORREÇÕES NA BIBLIOTECA (biblioteca.inc)

### 5.1 Nome da Função Errado
**Problema:** `sys__write` (dupla barra baixa)

**Correção:**
```assembly
# ANTES
sys__write  equ  0x1

# DEPOIS
sys_write   equ  0x1
```

### 5.2 Sintaxe de Instrução
**Problema:** `lea rsi [buffer]` falta vírgula e nome de variável errado

**Correção:**
```assembly
# ANTES
lea rsi [buffer]

# DEPOIS
lea rsi, [bufferEntrada]
```

### 5.3 Variável Não Definida em .bss
**Problema:** Função `into_to_string` usava `buffer` que não estava em `.bss`

**Correção:**
- Apenas `bufferEntrada` está definido em `.bss`
- Todas as referências alteradas para usar `bufferEntrada`

---

## 6. NORMAS APLICADAS - COMENTÁRIOS EM CÓDIGO

### 6.1 Estrutura de Comentários

#### Blocos de Documentação:
```assembly
; ======================================================
; FUNÇÃO: saidaResultado
; Descrição breve
; ======================================================
; Entrada:  RSI = endereço (conforme ABI x86-64)
; Saída:    sem valor de retorno
; Usa:      RAX, RDI, RSI, RDX
; ======================================================
```

#### Comentários Inline:
```assembly
mov rax, sys_write     ; RAX = 1 (SYS_WRITE)
mov rdi, std_out       ; RDI = 1 (stdout) - 1º parâmetro
mov rsi, bufferEntrada ; RSI = endereço - 2º parâmetro
mov rdx, tamanhoBuffer ; RDX = tamanho - 3º parâmetro
syscall                ; Executa a chamada do sistema
```

### 6.2 Convenções Aplicadas

| Aspecto | Norma |
|---------|-------|
| Idioma | Português (conforme codebase) |
| Registradores | Nomes 64-bit (RAX, RBX, etc.) |
| ABI | System V AMD64 (Linux x86-64) |
| Syscalls | Notação decimal (ex: 0x3c = 60) |
| Comentários de Erro | Prefixo "CORRIGIDO:" |
| Separadores | `====` de 54 caracteres |
| Parâmetros | Documentar conforme ABI x86-64 |

### 6.3 Exemplo Completo Comentado

```assembly
; ======================================================
; Teste de conversão com correções ABI x86-64
; ======================================================

; Entrada: RSI (string), RCX (tamanho)
; Saída:   RAX (valor inteiro)
string_to_int:
    xor rbx, rbx          ; RBX = 0 (acumulador)
    
.prox_digito:
    movzx rax, byte[rsi]  ; Carrega byte e zero-extend para 64-bit
    inc rsi                ; Próximo caractere
    sub al, "0"           ; Converte ASCII para 0-9
    imul rbx, 0xa         ; RBX *= 10 (base decimal)
    add rbx, rax          ; RBX += dígito
    loop .prox_digito     ; Continua se RCX > 0
    mov rax, rbx          ; Resultado em RAX
    ret
```

---

## 7. STATUS DE COMPILAÇÃO

Todos os projetos compilando com sucesso:

✅ arrays/
✅ basics-entrada/
✅ basics-saida/
✅ biblioteca/
✅ calculadora/
✅ comparar-valores/
✅ converter/
✅ registradores/
✅ teste/
✅ teste-resto/

---

## 8. COMMIT REALIZADO

```
commit: 6da8b4cd5972c71f1b9b5851ddbeb301da51f519
author: sandbox <ghostnether28@gmail.com>
date:   Wed Jan 21 20:36:35 2026 -0300

23 files changed:
- 283 insertions
+ 111 deletions
```

**Principais mudanças:**
- 6 makefiles alterados/criados
- 4 arquivos assembly corrigidos
- 1 arquivo include (biblioteca) melhorado
- Comentários normatizados em 5 arquivos

---

## 9. REFERÊNCIAS

### ABI System V AMD64 (x86-64 Linux)
- Parâmetros: RDI, RSI, RDX, RCX, R8, R9
- Retorno: RAX (inteiro), RDX:RAX (128-bit)
- Registradores preservados: RBX, RSP, RBP, R12-R15

### Syscalls x86-64
- RAX: número da syscall
- RDI, RSI, RDX, R10, R8, R9: argumentos
- Resultado: RAX

### NASM (Netwide Assembler)
- `-f elf64`: formato ELF 64-bit (padrão para Linux x86-64)
- `%include`: diretiva para incluir arquivo
- Extensão recomendada: `.inc` para includes

---

**FIM DO RELATÓRIO DE CORREÇÕES**
