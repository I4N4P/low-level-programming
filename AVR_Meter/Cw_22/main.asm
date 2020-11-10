;
; Cw_22.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;



MainLoop:
         RCALL DelayInMs 
         RJMP MainLoop

  DelayInMs: 
            LDI R22,0
            CLR R16 
            CP R22,R16
            BREQ RETURN

            LDI R17,1
            LDI R19,118
            LDI R20,4
      LOOP:
            NOP
            SUB R19,R17
            SBC R20,R16
            CP R19,R16
            CPC R20,R16 
            BRNE LOOP
            DEC R22
            CP R22,R16
            BREQ RETURN
            RJMP LOOP-2
     RETURN:
  RET