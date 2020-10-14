;
; Cw_18.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code
    LDI R22,1
    LDI R30,231
    LDI R31,3
    LDI R26,1
    LDI R27,0
    CLR R28
    CLR R29
 LOOP:NOP
    NOP
    ADD R28,R26
    ADC R29,R27
    CP R28,R30
    CPC R29,R31 
    BRNE LOOP
    NOP
    NOP
    DEC R22
    BRBS 1,1

    