;
; Cw_13.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;

        LDI R20,4
        NOP
        NOP
        NOP
        NOP
        NOP
  LOOP: NOP
        DEC R20
        NOP
        BRBC 1,LOOP 
        RJMP 0