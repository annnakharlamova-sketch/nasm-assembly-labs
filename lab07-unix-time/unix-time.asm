section .bss
    buf resb 250 

section .text
global _start
_start:
gettime:

    mov eax, 13
    xor ebx, ebx

    int 0x80 ; получили текущее время в секундах
    mov edi, buf
    call dword_to_udec_str ; при выходе из процедуры в данном случае в edi находится адрес конца строки,
    ; из конца вычитаем начало - получаем длину
    sub edi, buf

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, edi

    int 0x80 ; вывели на экран

    ; Выход
    mov eax,1
    mov ebx,0
    int 80h

;Процедура преобразования двойного слова в строку в десятичном виде (без знака)
; EAX - двойное слово
; EDI - буфер для строки. Значение регистра не сохраняется.
dword_to_udec_str:
    xor ecx,ecx               ;Обнуление CX
    mov ebx,10       ;В EBX делитель (10 для десятичной системы)
 
wtuds_lp1:                  ;Цикл получения остатков от деления
    xor edx,edx         ;Обнуление старшей части двойного слова
    div ebx            ;Деление EAX=(EDX:EAX)/EBX, остаток в EDX
    add dl, '0'         ;Преобразование остатка в код символа
    push rdx                 ;Сохранение в стеке
    inc ecx                  ;Увеличение счетчика символов
    test eax,eax              ;Проверка EAX на 0
    jnz wtuds_lp1    ;Переход к началу цикла, если частное не 0.
 
wtuds_lp2:                  ;Цикл извлечения символов из стека
    pop rdx                  ;Восстановление символа из стека
    mov [edi],dl             ;Сохранение символа в буфере
    inc edi                  ;Инкремент адреса буфера
    loop wtuds_lp2          ;Команда цикла
    ret
