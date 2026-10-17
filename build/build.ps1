
function launch{
	qemu-system-i386 -drive format=raw,file=data\os.img
}
function build{
    wsl make
    if ($LASTEXITCODE -eq 0) {
        qemu-system-i386 -drive format=raw,file=data\os.img
    }
}