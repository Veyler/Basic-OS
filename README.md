# Basic OS

A tiny x86 operating system: an assembly bootloader that switches the CPU to
32-bit protected mode and loads a minimal C kernel, which has a basic screen
management system (it displays messages in different colors using a function,
and automatically scrolls if the text goes off the screen).

---

## How it works

1. The BIOS loads the boot sector at `0x7C00`.
2. The bootloader reads the kernel from disk (`int 0x13`) to `0x10000`.
3. It sets up a GDT and enters protected mode.
4. It jumps to `kernel_main`, written in C, which writes to VGA text memory.

## Project layout

- `src/bootloader/`: bootloader (NASM)
- `src/kernel/`: kernel (C)
- `build/`: build scripts (`build.sh`, `Makefile`) and linker script
- `build/data/`: build output (ignored by git)

## Requirements

- If you are on Windows, WSL
- Inside WSL / Linux : `gcc`, `binutils`, `nasm`, `make`
- QEMU

## Contribute

```bash
git clone https://github.com/Veyler/Basic-OS
```

## Build and run

```bash
cd build
./build.sh
```

## To add

- function to display integers values
- a keyboard driver

---

Tips and suggestions are welcome!
