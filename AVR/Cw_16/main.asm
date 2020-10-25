;
; Cw_16.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


        LDI R17,12
        LDI R16,166
  LOOP:
        NOP
        INC R18
        DEC R16
        BRBC 1,LOOP 
        DEC R17
        BRBC 1,1
        NOP
        NOP
        RJMP 0
    