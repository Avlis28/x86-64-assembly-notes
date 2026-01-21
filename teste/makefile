nome = teste

all: $(nome)

$(nome): $(nome).o
	ld -s -o $(nome) $(nome).o

%.o: %.asm bibliotecaE.inc
	nasm -f elf64 $< -o $@

