section .data
    msg db 'Hello, world!', 0x0a, 0x00 ; Сообщение, которое будет выводиться
    msg_len equ $ - msg ; Длина сообщения

section .text
    global _start

_start:
    ; Системный вызов для записи
    mov eax, 0x4 ; Номер системного вызова (sys_write)
    mov ebx, 0x1 ; Дескриптор stdout
    mov ecx, msg ; Адрес сообщения
    mov edx, msg_len ; Длина сообщения
    int 0x80 ; Вызов системного прерывания

    ; Системный вызов для выхода
    mov eax, 0x1 ; Номер системного вызова (sys_exit)
    xor ebx, ebx ; Код выхода 0
    int 0x80 ; Вызов системного прерывания