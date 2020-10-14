;
; Cw_18.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code
    LDI R22,1
    LDI R30,137
    LDI R31,5
    LDI R27,0
    LDI R26 ,1
    CLR R28
    CLR R29
 LOOPMSB: NOP
 LOOPLSB:NOP
    NOP
    INC R28
    CP R30,R28
    BRNE LOOPLSB
    INC R29
    CP R31,R29
    BRNE LOOPMSB
    DEC R22
    BRBC 1,0
    