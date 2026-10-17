
set -e
mkdir -p data

nasm -f bin ../src/bootloader/main.asm -o data/main.bin

gcc -m32 -ffreestanding -fno-pie -fno-stack-protector -c ../src/kernel/kernel.c -o data/kernel.o
ld -m elf_i386 -T linker.ld data/kernel.o -o data/kernel.bin

cat data/main.bin data/kernel.bin > data/os.img
truncate -s 1M data/os.img