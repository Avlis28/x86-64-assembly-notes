# NORMAS DE CÓDIGO ASSEMBLY x86-64 - GUIA DE ESTILO

## 1. CONVENÇÕES DE ARQUIVO

### 1.1 Extensões
- **Código assembly:** `.asm`
- **Includes/headers:** `.inc`
- **Objetos compilados:** `.o`
- **Executáveis:** sem extensão (ou `.exe` em Windows)

### 1.2 Estrutura de Projeto
```
projeto/
├── projeto.asm      # Código principal
├── projeto.inc      # Headers/defines (se necessário)
├── makefile         # Instruções de compilação
├── projeto          # Executável compilado
└── projeto.o        # Objeto compilado (intermediário)
```

---

## 2. MAKEFILES

### 2.1 Estrutura Básica
```makefile
nome = projeto_name

all: $(nome)

$(nome): $(nome).o
	ld -s -o $(nome) $(nome).o

%.o: %.asm 
	nasm -f elf64 $< -o $@
```

### 2.2 Padrões Obrigatórios
- ✅ Variável `nome` definida no início
- ✅ Alvo `all` aponta para executável (não .o)
- ✅ Usar `nasm -f elf64` (64-bit)
- ✅ Usar `ld -s` para linkagem (não cc)
- ✅ Preservar tab (não espaços) em comandos de recipe

### 2.3 Dependências com Includes
```makefile
%.o: %.asm biblioteca.inc
	nasm -f elf64 $< -o $@
```

---

## 3. INCLUDES

### 3.1 Sintaxe Correta
```assembly
%include "arquivo.inc"        ; Local (mesma pasta)
%include "../path/arquivo.inc" ; Relativo
```

### 3.2 Estrutura de Include
```assembly
; ======================================================
; Descrição breve do arquivo
; ======================================================

section .data
    constante1  equ  0x01
    constante2  equ  0x02

section .bss
    buffer      resb  10

section .text

    ; Funções/rotinas aqui
```

---

## 4. REGISTRADORES 64-BIT

### 4.1 Registradores Inteiros
```
64-bit   | 32-bit  | 16-bit | 8-bit (low) | Uso
---------|---------|--------|-------------|----------
RAX      | EAX     | AX     | AL          | Acumulator
RBX      | EBX     | BX     | BL          | Base
RCX      | ECX     | CX     | CL          | Counter
RDX      | EDX     | DX     | DL          | Data
RSI      | ESI     | SI     | SIL         | Source Index
RDI      | EDI     | DI     | DIL         | Dest Index
RBP      | EBP     | BP     | BPL         | Base Pointer
RSP      | ESP     | SP     | SPL         | Stack Pointer
R8-R15   | R8D-R15D| R8W... | R8B...     | Extras
```

### 4.2 Registradores Preservados
Funções DEVEM preservar: RBX, RBP, RSP, R12-R15

Podem ser destruídos: RAX, RCX, RDX, RSI, RDI, R8-R11

---

## 5. CONVENÇÃO DE CHAMADA (ABI x86-64)

### 5.1 Passagem de Parâmetros
```assembly
; 1º parâmetro: RDI
; 2º parâmetro: RSI
; 3º parâmetro: RDX
; 4º parâmetro: RCX
; 5º parâmetro: R8
; 6º parâmetro: R9
; Restante: stack (RSP)
```

### 5.2 Exemplo
```assembly
; Chamada: funcao(1, "abc", 3)
mov rdi, 1          ; 1º param
mov rsi, "abc"      ; 2º param (endereço)
mov rdx, 3          ; 3º param
call funcao

funcao:
    ; RDI = 1
    ; RSI = "abc"
    ; RDX = 3
    ret
```

---

## 6. SYSCALLS

### 6.1 Sintaxe x86-64 Linux
```assembly
mov rax, <numero_syscall>  ; Número (60 = exit, 1 = write, etc)
mov rdi, <arg1>            ; 1º argumento
mov rsi, <arg2>            ; 2º argumento
mov rdx, <arg3>            ; 3º argumento
mov r10, <arg4>            ; 4º argumento (não RCX!)
mov r8,  <arg5>            ; 5º argumento
mov r9,  <arg6>            ; 6º argumento
syscall                    ; Executa
```

### 6.2 Syscalls Comuns
```
RAX  | Nome    | Arg1      | Arg2     | Arg3   | Retorno
-----|---------|-----------|----------|--------|--------
0x00 | read    | fd        | buf      | count  | bytes
0x01 | write   | fd        | buf      | count  | bytes
0x3c | exit    | code      | -        | -      | -
0x3e | clone   | flags     | stack    | ...    | pid
0xe7 | exit_group | code   | -        | -      | -
```

### 6.3 Descritores de Arquivo
```
FD | Nome   | Descrição
---|--------|-------------------
0  | stdin  | Entrada padrão
1  | stdout | Saída padrão
2  | stderr | Erro padrão
```

---

## 7. COMENTÁRIOS

### 7.1 Blocos de Documentação
```assembly
; ======================================================
; FUNÇÃO: nome_da_funcao
; Descrição breve do que a função faz
; ======================================================
; Entrada:  RDI = descrição, RSI = descrição
; Saída:    RAX = descrição
; Usa:      RBX, RCX (registradores modificados)
; Preserva: RBP, RSP, R12-R15 (conforme ABI)
; ======================================================
```

### 7.2 Comentários Inline
```assembly
mov rax, 0x01         ; RAX = 1 (SYS_WRITE)
mov rdi, 1            ; RDI = stdout
mov rsi, msg          ; RSI = endereço da string
mov rdx, tam_msg      ; RDX = tamanho
syscall               ; Executa a chamada
```

### 7.3 Comentários de Correção
```assembly
; CORRIGIDO: Descrição da alteração
; ANTES: ...
; DEPOIS: ...
```

### 7.4 Separadores
Use linha de `=` com 54 caracteres:
```
; ======================================================
```

---

## 8. SEÇÕES DE CÓDIGO

### 8.1 Section .data
Para dados inicializados (constantes, strings)
```assembly
section .data
    msg db "Hello", 0x0a, 0x00
    num dd 42
    lista dq 1, 2, 3, 4, 5
```

### 8.2 Section .bss
Para dados não inicializados (buffers, variáveis)
```assembly
section .bss
    buffer   resb 256    ; 256 bytes
    array    resq 10     ; 10 quad-words (64-bit)
    var      resd 1      ; 1 double-word (32-bit)
```

### 8.3 Section .text
Para código executável
```assembly
section .text
    global _start
    
_start:
    ; Código
```

---

## 9. EXEMPLO COMPLETO NORMATIZADO

```assembly
; ======================================================
; Programa: Teste de Conversão Decimal
; Descrição: Converte inteiro em string decimal
; ======================================================

%include "biblioteca.inc"

section .data
    valor dd 42        ; Valor a converter

section .bss
    resultado resb 16  ; Buffer para resultado

section .text

global _start

; ======================================================
; FUNÇÃO: main
; Entrada principal do programa
; ======================================================
_start:
    mov rax, [valor]        ; Carrega valor em RAX
    call int_to_string      ; Converte para string
    
    ; Exibe resultado
    mov rdi, 1              ; stdout
    mov rsi, resultado      ; endereço da string
    mov rdx, 16             ; tamanho máximo
    mov rax, 1              ; SYS_WRITE
    syscall
    
    ; Encerra
    mov rax, 0x3c           ; SYS_EXIT
    mov rdi, 0              ; código de retorno
    syscall

; ======================================================
; FUNÇÃO: int_to_string
; Converte inteiro em string decimal (terminada em \0)
; ======================================================
; Entrada:  RAX = inteiro a converter
; Saída:    resultado = string
; Usa:      RBX, RCX, RDX, RSI
; ======================================================
int_to_string:
    mov rsi, resultado
    add rsi, 15             ; Posiciona no final
    mov byte [rsi], 0x00    ; Terminador nulo
    mov rbx, 10             ; Base decimal
    
.loop:
    xor rdx, rdx            ; Limpa RDX para divisão
    div rbx                 ; RAX = RAX / 10, RDX = resto
    add dl, '0'             ; Converte 0-9 para ASCII
    dec rsi                 ; Volta uma posição
    mov [rsi], dl           ; Escreve dígito
    cmp rax, 0              ; Verifica se acabou
    jne .loop               ; Continua se RAX != 0
    
    ret
```

---

## 10. CHECKLIST ANTES DE COMMIT

- [ ] Todos os `.o` e executáveis removidos
- [ ] Makefile compila sem erros
- [ ] Todas as funções têm bloco de documentação
- [ ] Comentários inline significativos adicionados
- [ ] Registradores 64-bit utilizados (não 32-bit)
- [ ] ABI x86-64 seguido (RDI, RSI, RDX para params)
- [ ] `syscall` utilizado (não `int`)
- [ ] Includes com extensão `.inc`
- [ ] Mensagem de commit descritiva
- [ ] Código testado e compilando

---

**Última atualização:** 21 de janeiro de 2026
