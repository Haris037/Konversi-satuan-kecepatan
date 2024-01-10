include 'emu8086.inc'

ORG    100h

jmp start
msg       db 13,10, '====konversi satuan kecepatan===='
          db 13,10, '1.km/h ke mph'
          db 13,10, '2.mph  ke kmh/h '
          db 13,10, '3.km/h ke m/s '
          db 13,10, '4.mph ke m/s '
          db 13,10, '5.exit $'
pilih     db 13,10, 'pilih konversi :$'
barrier   db 13,10, '=================================$'
invalid   db 13,10, 'MASUKKAN INPUT YANG VALID!!!$'

start:

main proc
    
    mov ax,@data
    mov ds, ax
    
    lea dx,msg
    mov ah,09h
    int 21h


pilihan:
    
    lea dx,barrier
    mov ah,09h
    int 21h
    
    lea dx,pilih
    mov ah,09h
    int 21h
    
    mov ah,01h
    int 21h
    
    cmp al,'1'
    je  kmh
    
    cmp al,'2'
    je  mph
    
    cmp al,'3'
    je  kmhtoms
    
    cmp al,'4'
    je  mphtoms
    
    cmp al,'5'
    je  keluar
    
    jmp salah

    
    
kmh:

    lea  si, km             ; mengambil nomer dari 'km'
    call print_string       
    call scan_num           ; mengambil nomer ke CX.

    mov  ax,cx              ; menyalin nomer ke AX.
                            ; mengkonversi km/h ke miles/h
                            
    mov  bx,621             ; faktor dikalikan untuk konversi
    imul bx                 ; AX dikalikan dengan BX (dari 621/1000 ke 0.621)
    mov  bx,1000            ; Penyebut 0.621
    idiv bx                 ; dibagi 1000

    
    call pthis
         db 13,10, 'Hasil miles/h                 : ', 0     ;mengoutput hasil

    call print_num          ; mencetak nomer dalam AX.

    jmp  looping            ; memanggil 'looping'.

    km   db 13,10, 'Masukkan kecepatan dalam km/h : ', 0     ;cout untuk input


mph:

    lea  si, miles          ; mengambil nomer dari 'mph'
    call print_string       
    call scan_num           ; mengambil nomer ke CX.

    mov  ax,cx              ; menyalin nomer ke AX.
                            ; mengkonversi km/h ke miles/h
                            
    mov  bx,1609            ; faktor dikalikan untuk konversi
    imul bx                 ; AX dikalikan dengan BX (dari 1609/1000 ke 0.621)
    mov  bx,1000            ; Penyebut 0.621
    idiv bx                 ; dibagi 1000


    call pthis
          db 13,10, 'Hasil km/h                       : ', 0    ;mengoutput hasil

    call print_num          ; mencetak nomer dalam AX.

    jmp  looping            ; memanggil 'looping'.

    miles db 13,10, 'Masukkan kecepatan dalam miles/h : ', 0    ;cout untuk input

kmhtoms:

    lea  si, kmh_ms         ; ask for the number
    call print_string       ;
    call scan_num           ; get number in CX.

    mov  ax,cx              ; copy the number to AX.
                            ; Convert km/h to m/s
    mov  bx,277             ; Multiplying factor for conversion
    imul bx                 ; Multiply AX by BX (277/1000 to get 0.277)
    mov  bx,1000            ; Denominator for 0.277
    idiv bx                 ; Divide by 1000

    ; print the converted value:
    call pthis
           db 13,10, 'Hasil m/s                      : ', 0

    call print_num          ; print number in AX.

    jmp  looping            ; return to operating system.

    kmh_ms db 13,10, 'Masukkan kecepatan dalam km/h  : ', 0

mphtoms: 

    lea  si, mph_ms         ; ask for the number
    call print_string       ;
    call scan_num           ; get number in CX.

    mov  ax,cx              ; copy the number to AX.
                            ; Convert mph to m/s
    mov  bx,447             ; Multiplying factor for conversion
    imul bx                 ; Multiply AX by BX (447/1000 to get 0.447)
    mov  bx,1000            ; Denominator for 0.447
    idiv bx                 ; Divide by 1000

    ; print the converted value:
    call pthis
           db 13,10, 'Hasil m/s                      : ', 0

    call print_num          ; print number in AX.

    jmp  looping            ; return to operating system.

    mph_ms db 13,10, 'Masukkan kecepatan dalam mp/h  : ', 0
    
    
salah:

    lea dx,invalid
    mov ah,09h
    int 21h
    
looping:

    jmp pilihan

keluar:

    int 20h
    
 
DEFINE_SCAN_NUM
DEFINE_PRINT_STRING
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS        ; dibutuhkan untuk print_num.
DEFINE_PTHIS