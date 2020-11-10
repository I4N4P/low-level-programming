;
; Cw_18.asm
;
; Created: 09.10.2020 17:11:35
; Author :IAmTheProgramer
;

        LDI R22,10
        CLR R19 
        CP R22,R19
        BREQ 0

        LDI R16,117
        LDI R17,4
        LDI R18,1  
        CLR R20
        CLR R21
  LOOP:
        NOP
        ADD R20,R18
        ADC R21,R19
        CP  R16,R20
        CPC R17,R21 
        BRNE LOOP
        DEC R22
        NOP
        NOP
        CP R22,R19
        BREQ 0
        RJMP LOOP-2

    