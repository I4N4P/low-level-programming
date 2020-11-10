;
; Cw_7.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;

    LDI R20,LOW(300)
    LDI R21,HIGH(300)
    LDI R22,200
    SUB R20,R22
    CLR R22
    SBC R21,R22