section .data
    filename db 'readme.txt', 0   ; Имя файла для создания

section .text
    global main                   ; Точка входа для Windows

extern CreateFileA, CloseHandle   ; Экспортируем функции CreateFileA и CloseHandle из kernel32.dll

main:
    ; Вызов CreateFileA для создания файла
    push 0                    ; Атрибуты файла (обычный файл)
    push 0                    ; Флаги доступа (только на чтение/запись)
    push 0                    ; Режим доступа
    push 0                    ; Атрибуты безопасности
    push 0                    ; Указатель на шаблон
    push filename             ; Имя файла
    call CreateFileA          ; Создать файл, результат — дескриптор

    ; Проверка на ошибку
    test eax, eax
    js error                  ; Если дескриптор < 0, переходим к обработке ошибки

    ; Закрытие файла
    push eax                   ; Дескриптор файла
    call CloseHandle           ; Закрыть файл

    ; Завершение программы
    mov eax, 0
    ret

error:
    ; Ошибка при создании файла
    mov eax, 1                 ; Код завершения ошибки
    ret
