nome = calculadora

all: $(nome).o
	ld -s -o $(nome) $(nome).o

%.o: %.asm menu.inc
	nasm -f elf64 $< -o $@

