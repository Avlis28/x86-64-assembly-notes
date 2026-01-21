nome = calculadora

all: $(nome).o
	ld -s -o $(nome) $(nome).o

%.o: %.asm calculadora.inc
	nasm -f elf64 $< -o $@

