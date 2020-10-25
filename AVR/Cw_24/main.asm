;
; Cw_24.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;



MainLoop:
         RCALL DelayInMs 
         RJMP MainLoop

  DelayInMs: 
            LDI R24,1 
            CPI R24,0
            BREQ DelayInMsEnd
            RCALL DelayOneMs
            DEC R24
            RJMP DelayInMs+1
  DelayInMsEnd:
            RET


  DelayOneMs:
             LDI R24,118
             LDI R25,4
       LOOP:
             NOP
             SBIW R24,1
             BRBS 1,DelayOneMsEnd
             RJMP LOOP
  DelayOneMsEnd:
             RET