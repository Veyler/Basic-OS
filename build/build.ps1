
function build{
	wsl bash build.sh
	qemu-system-i386 -drive format=raw,file=data\os.img
}