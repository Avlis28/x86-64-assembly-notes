nome = converter

all: $(nome).o
	ld -m elf_i386 -s -o $(nome) $(nome).o
	rm -rf *.o

%.o: %.asm
	nasm -f elf32 $< -o $@
