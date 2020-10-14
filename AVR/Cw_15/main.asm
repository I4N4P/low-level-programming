;
; Cw_15.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code

    LDI R17,10
    LDI R16,166
 LOOP:NOP
    NOP
    INC R18
    DEC R16
    BRBC 1,LOOP 
    DEC R17
    BRBC 1,1
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    NOP
    RJMP 0
    