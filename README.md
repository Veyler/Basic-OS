# Basic OS

A tiny x86 operating system: an assembly bootloader that switches the CPU to
32-bit protected mode and loads a minimal C kernel, which prints a message on
screen to confirm it was loaded.

## How it works

1. The BIOS loads the boot sector at `0x7C00`.
2. The bootloader reads the kernel from disk (`int 0x13`) to `0x10000`.
3. It sets up a GDT and enters protected mode.
4. It jumps to `kernel_main`, written in C, which writes to VGA text memory.

## Project layout

- `src/bootloader/`: bootloader (NASM)
- `src/kernel/`: kernel (C)
- `build/`: build scripts and linker script

## Requirements

- Windows with PowerShell and WSL (Fedora)
- Inside WSL: `sudo dnf install gcc binutils nasm make`
- QEMU for Windows, available in your `PATH`

Using another distribution? Edit `build/build.sh` accordingly.

## Build and run

```powershell
git clone https://github.com/Veyler/Basic-OS
cd Basic-OS/build
. ./build.ps1   # loads the build function into your session
build
```

On Linux, from the project root:

```bash
bash build/build.sh
qemu-system-i386 -drive format=raw,file=data/os.img
```

Tips and suggestions are welcome!