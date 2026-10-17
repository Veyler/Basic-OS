CC     = gcc
LD     = ld
NASM   = nasm
CFLAGS = -m32 -ffreestanding -fno-pie -fno-stack-protector -Wall -Wextra -MMD -MP

BOOT_SRC   = ../src/bootloader/main.asm
KERNEL_SRC = $(wildcard ../src/kernel/*.c)
KERNEL_OBJ = $(patsubst ../src/kernel/%.c,data/%.o,$(KERNEL_SRC))

all: data/os.img

data/os.img: data/main.bin data/kernel.bin
	cat $^ > $@
	truncate -s 1M $@

data/main.bin: $(BOOT_SRC) | data
	$(NASM) -f bin $< -o $@

data/kernel.bin: data/kernel.elf
	objcopy -O binary $< $@

data/kernel.elf: $(KERNEL_OBJ) linker.ld
	$(LD) -m elf_i386 -T linker.ld $(KERNEL_OBJ) -o $@

data/%.o: ../src/kernel/%.c | data
	$(CC) $(CFLAGS) -c $< -o $@

data:
	mkdir -p data

clean:
	rm -rf data

-include $(KERNEL_OBJ:.o=.d)
.PHONY: all clean