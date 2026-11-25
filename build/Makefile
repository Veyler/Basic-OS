CC     = gcc
LD     = ld
NASM   = nasm
CFLAGS = -m32 -ffreestanding -fno-pie -fno-stack-protector -Wall -Wextra -MMD -MP
CPPFLAGS = -I ../src/kernel

BOOT_SRC   = ../src/bootloader/main.asm
KERNEL_SRC = $(shell find ../src/kernel -name '*.c') 			  # Automatically extract all .c files in kernel/
KERNEL_OBJ = $(patsubst ../src/kernel/%.c,data/%.o,$(KERNEL_SRC)) # $(patsubst pattern, replacement, text)

all: data/os.img # Entry point of Make 

data/os.img: data/main.bin data/kernel.bin					# Make the image
	cat $^ > $@
	truncate -s 1M $@

data/main.bin: $(BOOT_SRC) | data							# Compile the bootloader
	$(NASM) -f bin $< -o $@

data/kernel.bin: data/kernel.elf							# Convert the kernel.elf to kernel.bin
	objcopy -O binary $< $@

data/kernel.elf: $(KERNEL_OBJ) linker.ld
	$(LD) -m elf_i386 -T linker.ld $(KERNEL_OBJ) -o $@

data/%.o: ../src/kernel/%.c									# Compile every .c with GCC in kernel/
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

data:
	mkdir -p data

clean:
	rm -rf data

-include $(KERNEL_OBJ:.o=.d)
.PHONY: all clean