;
; Cw_14.asm
;
; Created: 09.10.2020 17:11:35
; Author :IAmTheProgramer
;


       LDI R17,HIGH(500)
       LDI R16,LOW(500)
 LOOP: 
       NOP
       DEC R16
       BRBC 1,LOOP 
       DEC R17
       BRBC 1,LOOP
    