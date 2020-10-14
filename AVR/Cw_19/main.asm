;
; Cw_19.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code
    LDI R22,10
    LDI R30,0
    LDI R31,0
    LDI R26,1
    LDI R27,0
    LDI R28,31
    LDI R29,3
 LOOP:NOP
    NOP
    SUB R28,R26
    ADC R19,R27
    SUB R29,R19
    CLR R19
    CP R28,R30
    CPC R29,R31 
    BRNE LOOP
    NOP
    NOP
    DEC R22
    BRBC 1,1
    NOP
    