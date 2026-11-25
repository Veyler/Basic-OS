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
- `build/`: build scripts (`build.ps1` for PowerShell, `Makefile` for WSL/Linux) and linker script
- `build/data/`: build output (ignored by git)

## Requirements

- Windows with PowerShell and WSL
- Inside WSL: `gcc`, `binutils`, `nasm`, `make` (install with your distro's package manager, e.g. `sudo apt install gcc binutils nasm make` on Ubuntu)
- QEMU for Windows, available in your `PATH`

## Build and run

```bash
source ./build.sh && build
source ./build.sh && run
```

## To add

- function to display integers and hexadecimal values
- manage the keyboard

---

Tips and suggestions are welcome!
