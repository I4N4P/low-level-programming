;
; Cw_5.asm
;
; Created: 29.10.2020 11:35:27
; Author : IAmTheProgramer
;



                .CSEG
                .ORG 0 RJMP _main 
                .ORG OC1Aaddr RJMP _timer_isr 
       
     _timer_isr: 
                IN   R20,SREG
                INC CurrentThread
                ANDI CurrentThread,1
                CPI CurrentThread,1
                BREQ _Thread_B
     _Thread_A:
                MOV   R21,R20
                OUT  SREG,R22
                POP  ThreadB_MSB
                POP  ThreadB_LSB
                PUSH ThreadA_LSB
                PUSH ThreadA_MSB
                RETI
     _Thread_B:
                MOV  R22,R20
                OUT  SREG,R21
                POP  ThreadA_MSB
                POP  ThreadA_LSB
                PUSH ThreadB_LSB
                PUSH ThreadB_MSB
                RETI                          



                .MACRO ThreadB_DELAY
                  LDI R16,LOW(@0)   
                  LDI R17,HIGH(@0)  
                  RCALL ThreadB_DelayInMs 
                  .ENDMACRO
                .MACRO ThreadA_DELAY
                  LDI R18,LOW(@0)   
                  LDI R19,HIGH(@0)  
                  RCALL ThreadA_DelayInMs

               .ENDMACRO


                .EQU Digits_P=PORTB     
                .EQU Segments_P=PORTD    
                
                .DEF ThreadA_LSB=R0
                .DEF ThreadA_MSB=R1
                .DEF ThreadB_LSB=R2
                .DEF ThreadB_MSB=R3
                .DEF CurrentThread=R23
                

          _main:
           SEI 
                LDI R16,9
                OUT TCCR1B,R16
                LDI R16,high(200)
                OUT OCR1AH,R16
                LDI R16,LOW(200)
                OUT OCR1AL,R16
                LDI R16,64
                OUT TIMSK,R16
                CLR R16
                OUT TCNT1L,R16
                OUT TCNT1H,R16
                CLR CurrentThread

                LDI R16,LOW(ThreadA)
                MOV ThreadA_LSB,R16
                LDI R16,HIGH(ThreadA)
                MOV ThreadA_LSB,R16
                LDI R16,LOW(ThreadB)
                MOV ThreadB_LSB,R16
                LDI R16,HIGH(ThreadB)
                MOV ThreadB_MSB,R16
               
                LDI R16,0x7F                        
                LDI R17,24 
                OUT Digits_P,R17
                OUT DDRD,R16
                OUT DDRB,R17
                LDI R16,0x3F
                OUT Segments_P,R16
                
      ThreadA:   

               CBI Digits_P,4        
  ThreadA_DELAY 100
               SBI Digits_P,4
               ThreadA_DELAY 100
             
               RJMP ThreadA

      ThreadB:                          //KKKKK
                
               CBI Digits_P,3
               ThreadB_DELAY 100

               SBI Digits_P,3
                ThreadB_DELAY 100
               RJMP ThreadB
               RETI


               ThreadB_DelayInMs: 
               POP R24
               sts 0x60,R24
               MOV R24,R16
               MOV R25,R17 
               SBIW R24,0
               BRBS 1,ThreadB_DelayInMsEnd
      ThreadB_DelayInMsLoop:
               RCALL ThreadB_DelayOneMs
               SBIW R24,1
               BRBS 1,ThreadB_DelayInMsEnd
               RJMP ThreadB_DelayInMsLoop
      ThreadB_DelayInMsEnd:
               LDS R24,0X60
               PUSH R24
               RET

      ThreadB_DelayOneMs:
               POP R26
               sts 0x61,R26

               sts 0x62,R24
               sts 0x63,R25
               LDI R24,52
               LDI R25,5
      ThreadB_DelayOneMsLoop:
               NOP
               SBIW R24,1
               BRBS 1,ThreadB_DelayOneMsEnd
               RJMP ThreadB_DelayOneMsLoop
      ThreadB_DelayOneMsEnd:
               
               LDS R24,0x62
               LDS R25,0X63
               LDS R26,0X61
               PUSH R26
              
               RET

      ThreadA_DelayInMs: 
               POP R28
               sts 0x64,R28
               MOV R28,R18
               MOV R29,R19 
               SBIW R28,0
               BRBS 1,ThreadA_DelayInMsEnd
      ThreadA_DelayInMsLoop:
               RCALL ThreadA_DelayOneMs
               SBIW R28,1
               BRBS 1,ThreadA_DelayInMsEnd
               RJMP ThreadB_DelayInMsLoop
      ThreadA_DelayInMsEnd:
               LDS R28,0X64
               PUSH R28
               RET

      ThreadA_DelayOneMs:
               POP R30
               sts 0x65,R30

               sts 0x66,R28
               sts 0x67,R29
               LDI R28,52
               LDI R29,5
      ThreadA_DelayOneMsLoop:
               NOP
               SBIW R28,1
               BRBS 1,ThreadA_DelayOneMsEnd
               RJMP ThreadA_DelayOneMsLoop
      ThreadA_DelayOneMsEnd:
               
               LDS R28,0x66
               LDS R29,0X67
               LDS R30,0X65
               PUSH R30
              
               RET