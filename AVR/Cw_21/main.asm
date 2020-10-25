;
; Cw_21.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;



MainLoop:
         RCALL DelayNCycles 
         RCALL ANOTHER
         RJMP MainLoop
DelayNCycles: 
             NOP
             NOP
             NOP
             RET 
ANOTHER:
        NOP
        RET