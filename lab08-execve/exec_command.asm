section .data
    command     db      '/bin/echo', 0     ; Команда для выполнения
    arg1        db      'Hello, World!', 0 ; Аргумент команды
    
    ; Массив указателей для execve
    args:
        dd      command             ; argv[0] - имя программы
        dd      arg1                ; argv[1] - первый аргумент
        dd      0                   ; argv[2] - NULL терминатор
    
    envp        dd      0           ; Пустое окружение для execve

section .text
global main

main:
    ; Подготовка системного вызова execve
    mov     eax, 11          ; Системный вызов execve
    mov     ebx, command     ; Первый аргумент - путь к исполняемому файлу
    mov     ecx, args        ; Второй аргумент - массив аргументов
    mov     edx, envp       ; Третий аргумент - окружение
    int     0x80             ; Выполнение системного вызова
    
    ; Выход из программы
    mov     eax, 1           ; Системный вызов exit
    xor     ebx, ebx         ; Код возврата 0
    int     0x80             ; Выполнение системного вызова