;
; Cw_17.asm
;
; Created: 09.10.2020 17:11:35
; Author :IAmTheProgramer
;
        LDI R22,0
        CLR R18
        CP R22,R18
        BREQ 0
 LOOP_1:   
        LDI R17,8
        LDI R16,249
  LOOP:
        NOP
        DEC R16
        BRBC 1,LOOP 
        DEC R17
        BRBC 1,LOOP-1
        DEC R22
        BRBC 1,LOOP_1
        NOP
        NOP
        NOP
        NOP
        NOP
        RJMP 0
    