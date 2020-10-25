;
; Cw_28.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;

            .MACRO DELAY
                PUSH R16
                PUSH R17
                LDI R16,LOW(@0)   
                LDI R17,HIGH(@0)  
                RCALL DelayInMs
                POP R17
                POP R16
            .ENDMACRO

            LDI R16,15
            CLR R17
            OUT DDRB,R16
            OUT PORTB,R16
  MainLoop:
            OUT PORTB,R16
            DELAY 100
            OUT PORTB,R17
            DELAY 100
            rjmp MainLoop



DelayInMs: 
             PUSH R24
             PUSH R25
             MOV R24,R16
             MOV R25,R17 
             SBIW R24,0
             BRBS 1,DelayInMsEnd
   DelayInMsLoop:
             RCALL DelayOneMs
             SBIW R24,1
             BRBS 1,DelayInMsEnd
             RJMP DelayInMsLoop
   DelayInMsEnd:
             POP R25
             POP R24
             RET


  DelayOneMs:
             PUSH R24
             PUSH R25
             LDI R24,52
             LDI R25,5
  DelayOneMsLoop:
             NOP
             SBIW R24,1
             BRBS 1,DelayOneMsEnd
             RJMP DelayOneMsLoop
  DelayOneMsEnd:
             POP R25
             POP R24
             RET
                     