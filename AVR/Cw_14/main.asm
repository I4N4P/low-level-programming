;
; Cw_14.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code

    LDI R17,2
    LDI R16,250
 LOOP:NOP
    NOP
    INC R18
    DEC R16
    BRBC 1,LOOP 
    DEC R17
    BRBC 1,1
    RJMP 0
    