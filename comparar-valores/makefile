nome = valores

all: $(nome).o	
	ld -s -o $(nome)  $(nome).o
	rm -rf *.o;

%.o: %.asm 
	nasm -f elf64 $< -o $@
