[org 0x8000]

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7000
    
    mov ah, 0x06
    xor al, al
    mov bh, 0x07
    xor cx, cx
    mov dx, 0x184f
    int 0x10

    xor ax, ax
    int 0x16

    mov si, os_name
    call print_string

    mov si, prompt
    call print_string

shell:
    mov ah, 0
    int 0x16
    mov ah, 0x0e
    cmp al, 0x0D 
    je enter_pressed
    int 0x10
    jmp shell

enter_pressed:
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10
    mov si, prompt
    call print_string
    jmp shell


not_enter:
    mov ah, 0x0e
    int 0x10
    jmp shell

print_string:
    lodsb
    cmp al, 0
    je done_print
    mov ah, 0x0e
    mov bh, 0x00
    mov bl, 0x07
    int 0x10
    jmp print_string

done_print:
    ret

os_name db "epicOS v1", 0
prompt db "> ", 0

times 512-($-$$) db 0
