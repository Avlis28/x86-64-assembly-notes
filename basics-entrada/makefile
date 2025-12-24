nome = entrada 

all: $(nome).o	
	ld -s -o $(nome)  $(nome).o
	rm -rf *.0;

%.o: %.asm 
	nasm -f elf64 $<   
