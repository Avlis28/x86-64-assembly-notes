all: registradores

registradores: registradores.o
	ld -s -o registradores registradores.o

%.o: %.asm 
	nasm -f elf64 $< -o $@
