all: entrada

entrada: entrada.o
	ld -s -o entrada entrada.o

%.o: %.asm 
	nasm -f elf64 $< -o $@