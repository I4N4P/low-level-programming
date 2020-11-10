;
; Cw_6asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


    LDI R20,LOW(300)
    LDI R21,HIGH(300)
    LDI R22,LOW(400)
    LDI R23,HIGH(400)
    ADD R20,R22
    ADC R21,R23
