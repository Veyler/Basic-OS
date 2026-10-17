org 0x7C00 ; Directive : Tells the assembler where we espect our code to be loaded
[BITS 16]  ; Directive : Tells assembler to emit 16-bit code

KERNEL_SEG equ 0x1000
KERNEL_ADDR equ 0x10000

main:
    
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

    mov [boot_drive], dl

    ; Load kernel
    mov ax, KERNEL_SEG
    mov es, ax
    xor bx, bx
    mov ah, 0x02        ; Bios function : read sectors
    mov al, 8           ; Number of sector to read
    mov ch, 0           ; Cylinder
    mov dh, 0           ; Head
    mov cl, 0x02        ; Second sector, our bootloader is in 0x01
    int 0x13
    jc disk_error
    
    ; Protected mode
    cli                 ; Disable BIOS interruption
    lgdt [gdt_desc]     ; Load GDT
    mov eax, cr0
    or eax, 1       
    mov cr0, eax
    jmp 08h:clear

disk_error:
    mov ax, 0xB800
    mov gs, ax
    mov word [gs:0], 0x0C45 ; 'E' en rouge
    jmp hang

boot_drive: db 0

gdt:
.gdt_null: ; Null segment
    dq 0
.gdt_code:
    dw 0FFFFh   ; 4gb limit
    dw 0        ; Start of the memory
    db 0
    db 0x9a     ; Access byte
    db 0b11001111
    db 0
.gdt_data:
    dw 0FFFFh   ; 4gb limit
    dw 0        ; Start of the memory
    db 0
    db 0x92     ; Access byte
    db 0b11001111
    db 0

gdt_end:

gdt_desc:
    dw gdt_end - gdt - 1
    dd gdt

[BITS 32]
clear:
    mov ax, 10h
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov esp, 090000h
    
    ; Print P on the top-left of the screen
    mov byte [0xB8000], 'P'
    mov byte [0xB8001], 1Bh

    call KERNEL_ADDR

; Infinite boucle
hang:
    jmp hang


times 510 - ($-$$) db 0 ; times = repeat, fill the program with 0 to have a 512 octets program
						; $-$$ = size of our program so far
						; Directive : db = define byte(s) = write given byte(s) to the binary file

dw 0xAA55 				; Directive : dw = define word(s) = write given world(s) to the binary file