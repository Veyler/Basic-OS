

org 0x7C00 ; Directive : Tells the assembler where we espect our code to be loaded
bits 16    ; Directive : Tells assembler to emit 16-bit code

main:
	mov [boot_drive], dl ; save the boot drive given by the bios
	mov si, mssg

	mov ax, 0x0000
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov sp, 0x7C00  ; Pile under the bootloader

	CALL l1		  ; call the l1 function


l1:
	mov ah, 0x0E
.next:
	lodsb		  ; Load AL value and si + 1
	test al, al	  ; AL = 0 ?
	jz .done	  ; Yes -> .done
	int 0x10	  ; No -> bios video interrupt
	jmp .next     ; Next char
.done:
	jmp load_kernel

load_kernel:

	mov bx, 0x7E00	; Load adress of the kernel

	mov ah, 0x02    ; Bios function : read sectors
	mov al, 2		; Number of sectors to read 
	mov ch, 0		; Cylinder
	mov cl, 2		; Sector 2
	mov dh, 0		; Head
	mov dl, [boot_drive]
	int 0x13		; Bios interrupt

	jmp 0x0000:0x7E00	; Jump to the loaded kernel

mssg:
	db "Hello World from the bootloader !", 0

boot_drive: db 0

times 510 - ($-$$) db 0 ; times = repeat, fill the program with 0 to have a 512 octets program
						; $-$$ = size of our program so far
						; Directive : db = define byte(s) = write given byte(s) to the binary file

dw 0xAA55 				; Directive : dw = define word(s) = write given world(s) to the binary file



