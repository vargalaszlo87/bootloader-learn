[BITS 16]
ORG 0x7C00

start:
	; stack setup
	mov bp, 0x9000
	mov sp, bp

	; print message
	call print_msg

	; while (true)
	jmp $

print_msg:
	mov si, msg

.print_char:
	lodsb
	or al, al
	jz .done
	mov ah, 0x0E
	int 0x10
	jmp .print_char
.done:
	ret

msg db 'Hello World!', 0

times 510-($-$$) db 0
dw 0xAA55
