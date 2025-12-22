# 🧠 Hello World — Assembly x86-64 (Linux)
-----------------------------------------

    Assembly x86-64 • Linux • NASM • Syscalls Diretas

---

![assembly](https://img.shields.io/badge/Assembly-x86--64-black)
![linux](https://img.shields.io/badge/Linux-AMD64-yellow)
![nasm](https://img.shields.io/badge/NASM-assembler-blue)
![syscall](https://img.shields.io/badge/Syscall-direct-red)
![status](https://img.shields.io/badge/status-estável-brightgreen)

---

## 📌 Descrição

Este repositório contém um **Hello World mínimo e funcional** escrito em **Assembly x86-64**, utilizando **Linux** e **chamadas de sistema diretas** (`syscall`).

Sem libc.  
Sem `main`.  
Sem abstrações.

Apenas **CPU → Kernel → Terminal**.

---

## 🧩 Arquitetura

- **CPU:** x86-64 (AMD64)
- **Sistema Operacional:** Linux
- **Assembler:** NASM
- **Linker:** GNU ld
- **Modelo:** ELF64
- **Paradigma:** Syscalls diretas

---

## 📂 Estrutura

```text
.
├── hello.asm   # Código Assembly
└── README.md   # Documentação