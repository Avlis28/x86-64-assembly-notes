all: hello

hello: saida-hello.o
	ld -s -o hello saida-hello.o

%.o: %.asm 
	nasm -f elf64 $< -o $@
