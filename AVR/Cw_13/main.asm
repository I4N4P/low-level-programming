;
; Cw_13.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code

    LDI R20,6
    NOP
    NOP
    NOP
    NOP
    NOP
 LOOP:NOP
    DEC R20
    NOP
    BRBC 1,LOOP ;R20*5+5
    RJMP 0