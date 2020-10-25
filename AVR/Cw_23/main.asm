;
; Cw_23.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;



MainLoop:
         RCALL DelayInMs 
         RJMP MainLoop

  DelayInMs: 
            LDI R22,1
            CPI R22,0
            BREQ DelayInMsEnd
            RCALL DelayOneMs
            DEC R22
            RJMP DelayInMs+1
  DelayInMsEnd:
            RET


  DelayOneMs:
             LDI R24,52
             LDI R25,5
       LOOP:
             NOP
             SBIW R24,1
             BRBS 1,DelayOneMsEnd
             RJMP LOOP
  DelayOneMsEnd:
             RET