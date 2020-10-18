;
; Cw_36.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


; Replace with your application code

 // Program odczytuje 4 bajty z tablicy sta³ych zdefiniowanej w pamiêci kodu do rejestrów R20..R23
 .MACRO CONVERT
    LDI R16,@0
    RCALL CONVERT_SUBROUTINE
 .ENDMACRO
LOOP:
CONVERT 1
RJMP LOOP
 
CONVERT_SUBROUTINE:
ldi R30, low(Table1<<1) // inicjalizacja rejestru Z
ldi R31, high(Table1<<1)
ADD R30,R16// inkrementacja Z
lpm R16, Z // odczyt 2 sta³ej    
RET
Table1: .db 0x00, 0x01, 0x04,0x09, 0x10, 0x19, 0x24, 0x31, 0x40, 0x51                   