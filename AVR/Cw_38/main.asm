;
; Cw_38.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


; Replace with your application code

 // Program odczytuje 4 bajty z tablicy sta³ych zdefiniowanej w pamiêci kodu do rejestrów R20..R23
 .MACRO DigitTo7segCode
    LDI R16,@0
    PUSH R16
    RCALL DigitTo7segCode_SUBROUTINE
    POP R16
 .ENDMACRO



LOOP:
DigitTo7segCode 1
RJMP LOOP
 

DigitTo7segCode_SUBROUTINE:
ldi R30, low(Table1<<1) // inicjalizacja rejestru Z
ldi R31, high(Table1<<1)
POP R16
ADD R30,R16// inkrementacja Z
lpm R16, Z // odczyt 2 sta³ej
PUSH R16    
RET
Table1: .db 0x3F, 0x06, 0x5B,0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F                   