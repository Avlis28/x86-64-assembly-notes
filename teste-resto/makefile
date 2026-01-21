nome = par-impar

all: $(nome)

$(nome): $(nome).o
	ld -s -o $(nome) $(nome).o

%.o: %.asm 
	nasm -f elf64 $< -o $@
