
echo "==== Make img ===="
if make; then
	echo "==== img built ===="
	echo "==== Lancement de l'OS ===="
	qemu-system-x86_64 -drive file=data/os.img,format=raw
	echo "==== Qemu terminé ===="
fi

