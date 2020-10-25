;
; Cw_35.asm
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

                .EQU Time=1
                .EQU Digits_P=PORTB     
                .EQU Segments_P=PORTD    
                .DEF Digit_0 = R2
                .DEF Digit_1 = R3
                .DEF Digit_2 = R4
                .DEF Digit_3 = R5

                LDI R16,0b00111111
                MOV Digit_0,R16
                LDI R16,0b00000110
                MOV Digit_1,R16
                LDI R16,0b01011011
                MOV Digit_2,R16
                LDI R16,0b01001111
                MOV Digit_3,R16
                LDI R16,0x7F             
                LDI R17,2
                CLR R20
                OUT DDRD,R16
                OUT Segments_P,R16
                OUT DDRB,R17
     MainLoop:                   
                OUT Digits_P,R20
                LDI R17,2
                OUT Segments_P,Digit_0
                OUT Digits_P,R17
                DELAY Time
                OUT Digits_P,R20
    
                LDI R17,4
                OUT Segments_P,Digit_1
                OUT Digits_P,R17
                DELAY Time
                OUT Digits_P,R20
    
                LDI R17,8
                OUT Segments_P,Digit_2
                OUT Digits_P,R17
                DELAY Time
                OUT Digits_P,R20
                
                LDI R17,16
                OUT Segments_P,Digit_3
                OUT Digits_P,R17
                DELAY Time
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

   
                     