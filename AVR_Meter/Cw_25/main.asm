;
; Cw_25.asm
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
             STS 0x60,R24
             STS 0x61,R25
             LDI R24,52
             LDI R25,5
       LOOP:
             NOP
             SBIW R24,1
             BRBS 1,DelayOneMsEnd
             RJMP LOOP
  DelayOneMsEnd:
             LDS R24,0x60
             LDS R25,0x61
             RET