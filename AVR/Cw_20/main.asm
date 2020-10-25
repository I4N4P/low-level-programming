;
; Cw_20.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;



MainLoop:
         RCALL DelayNCycles 
         RJMP MainLoop
DelayNCycles: 
             NOP
             NOP
             NOP
             RET 