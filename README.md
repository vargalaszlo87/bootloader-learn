# bootloader-learn
Simplest ways to make bootloader.

## 1st case

In this case we make a BIN file from ASM and run the bootloader in raw mode.

### 1) make an bootloader in Assembly

```asm

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
```

### 2) compile this file with NASM (*.asm -> *.bin)

```
nasm -f bin boot-01.asm -b boot-01.bin
```

### 3) run this *.bin file in QEMY with raw mode

```
qemu-system-i368 -drive format=raw,file=boot-01.bin
```

You can see it in action in this picture:

![kép](https://github.com/user-attachments/assets/ad091682-fd7d-4c2c-ab9e-66ad8dd414af)

## 2nd case

In this case we make an IMG file from BIN and run the bootloader in floopy mode (-fda)

### 1) Same as before.

### 2) Same as before.

### 3) make the IMG file from BIN (*.bin -> *.img)

```
dd if=boot-01.bin of=boot-01.img bs=512 count=1
```

### 4) run this *.img file in QEMY in "floppy" mode

```
qemu-system-i368 -fda boot-01.img
```

The output picture is same as before.



