;
; Cw_40.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;
                  .MACRO SET_DIGIT
                    PUSH R16
                    PUSH R17
                    LDI R17,@0 
                    RCALL SegNumber
                    SBRC R17,1
                    MOV R16,Digit_0
                    SBRC R17,2
                    MOV R16,Digit_1
                    SBRC R17,3
                    MOV R16,Digit_2
                    SBRC R17,4
                    MOV R16,Digit_3
                    RCALL DigitTo7segCode 
                    OUT Segments_P,R16
                    OUT Digits_P,R17
                    POP R17
                    POP R16
                  .ENDMACRO

                 .MACRO DELAY
                    PUSH R16
                    PUSH R17
                    LDI R16,LOW(@0)   
                    LDI R17,HIGH(@0)  
                    RCALL DelayInMs
                    POP R17
                    POP R16
                .ENDMACRO
              
                .EQU Time=250
                .EQU Digits_P=PORTB     
                .EQU Segments_P=PORTD    
                .DEF Digit_0 = R2
                .DEF Digit_1 = R3
                .DEF Digit_2 = R4
                .DEF Digit_3 = R5

                LDI R16,0
                MOV Digit_0,R16
                LDI R16,0
                MOV Digit_1,R16
                LDI R16,0
                MOV Digit_2,R16
                LDI R16,0
                MOV Digit_3,R16
                LDI R16,0x7F             
                LDI R17,2
                CLR R20
                OUT DDRD,R16
                OUT Segments_P,R16
                OUT DDRB,R17
                
      MainLoop:   
                CLR Digit_3   
                LDI R16,10             
                CP Digit_3,R16
                BRNE MainLoop+5
                rjmp MainLoop
                SET_DIGIT 0
                DELAY 200 
                SET_DIGIT 1  
                DELAY 200
                SET_DIGIT 2  
                DELAY  200
                SET_DIGIT 3 
                DELAY 400 
                INC Digit_3   
                rjmp MainLoop+1
               

      SegNumber:
                LDI R30, LOW(SegNumberData<<1) 
                LDI R31, HIGH(SegNumberData<<1)
                ADD R30,R17
                LPM R17,Z     
                RET
                SegNumberData: .db 2, 4, 8, 16


      DigitTo7segCode:
                LDI R30, LOW(SevenSegCodeData<<1) 
                LDI R31, HIGH(SevenSegCodeData<<1)
                ADD R30,R16
                LPM R16,Z     
                RET
                SevenSegCodeData: .db 0x3F, 0x06, 0x5B,0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F     


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

   
                     

  