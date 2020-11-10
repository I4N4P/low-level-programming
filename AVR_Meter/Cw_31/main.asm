;
; Cw_31.asm
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


            .EQU Digits_P=PORTB      
            .EQU Segments_P=PORTD    

            LDI R16,0x3F             
            LDI R17,2
            CLR R20
            OUT DDRD,R16
            OUT DDRB,R17
            OUT Segments_P,R16    
  MainLoop:                   
            OUT Digits_P,R20
            LDI R17,2
            OUT Digits_P,R17
            DELAY 1000
            OUT Digits_P,R20
            LDI R17,4
            OUT Digits_P,R17
            DELAY 1000
            OUT Digits_P,R20
            LDI R17,8
            OUT Digits_P,R17
            DELAY 1000
            OUT Digits_P,R20
            LDI R17,16
            OUT Digits_P,R17
            DELAY 1000
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

   
                     