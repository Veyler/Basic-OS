
function build{
	nasm -f bin ../src/bootloader/main.asm -o main.bin
	nasm -f bin ../src/kernel/kernel.asm -o kernel.bin
	# Fusionner le bootloader et le kernel dans l'image finale
	Get-Content -Path "main.bin", "kernel.bin" -Encoding Byte -ReadCount 0 | Set-Content -Path "os.img" -Encoding Byte

	qemu-system-x86_64 -drive "format=raw,file=os.img"
}

