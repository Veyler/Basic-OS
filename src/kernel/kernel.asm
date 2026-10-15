org 0x7E00
bits 16

start:
    mov si, mssg

l1:
    mov ah, 0x0E
.next:
    lodsb
    test al, al
    jz .done
    int 0x10
    jmp .next
.done:
    cli
    hlt

mssg: db "Hello world from the kernel !", 0
times 512 - ($-$$) db 0