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
                PUSH R20
                IN   R20,SREG
                INC CurrentThread
                ANDI CurrentThread,1
                CPI CurrentThread,1
                BREQ _Thread_B
     _Thread_A:
                STS  0x60,R24
                STS  0x61,R25
                STS  0x62,R26
                STS  0x63,R27
                LDS  R24,0x64
                LDS  R25,0x65
                LDS  R26,0x66
                LDS  R27,0x67
                MOV  ThreadB_SREG_COPY,R20
                POP  R20
                OUT  SREG,ThreadA_SREG_COPY
                POP  ThreadB_MSB
                POP  ThreadB_LSB
                POP  ThreadBDelayAdress_MSB
                POP  ThreadBDelayAdress_LSB 
                PUSH ThreadADelayAdress_LSB
                PUSH ThreadADelayAdress_MSB
                PUSH ThreadA_LSB
                PUSH ThreadA_MSB
                RETI
     _Thread_B:
                STS  0x64,R24
                STS  0x65,R25
                STS  0x66,R26
                STS  0x67,R27
                LDS  R24,0x60
                LDS  R25,0x61
                LDS  R26,0x62
                LDS  R27,0x63
                MOV  ThreadA_SREG_COPY,R20
                POP  R20
                OUT  SREG,ThreadB_SREG_COPY
                POP  ThreadA_MSB
                POP  ThreadA_LSB
                POP  ThreadADelayAdress_MSB
                POP  ThreadADelayAdress_LSB 
                PUSH ThreadBDelayAdress_LSB
                PUSH ThreadBDelayAdress_MSB
                PUSH ThreadB_LSB
                PUSH ThreadB_MSB
                RETI                          

                .MACRO DELAY
                    LDI R26 ,LOW(@0)
                    LDI R27 ,HIGH(@0)
                    RCALL DelayLoop
                .ENDMACRO

                .EQU Digits_P=PORTB     
                .EQU Segments_P=PORTD    
                
                .DEF ThreadA_LSB=R0
                .DEF ThreadA_MSB=R1
                .DEF ThreadB_LSB=R2
                .DEF ThreadB_MSB=R3
                .DEF ThreadA_SREG_COPY=R4
                .DEF ThreadB_SREG_COPY=R5
                .DEF ThreadADelayAdress_LSB=R6
                .DEF ThreadADelayAdress_MSB=R7
                .DEF ThreadBDelayAdress_LSB=R8
                .DEF ThreadBDelayAdress_MSB=R9
                .DEF CurrentThread=R18
                

          _main:
                 
                LDI R16,9
                OUT TCCR1B,R16
                LDI R16,high(100)
                OUT OCR1AH,R16
                LDI R16,LOW(100)
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
                CLR R16
                CLR R17
                SEI
    ThreadA:   
    TogglePinA:      
               IN R24,Digits_P
               IN R25,Digits_P
               ANDI R24,8
               LDI R26,16
               ADD R25,R26
               ANDI R25,16
               ADD R24,R25
               OUT Digits_P,R24
               DELAY 25
               RJMP ThreadA
 
    
     ThreadB:  
     TogglePinB:                        
               IN R24,Digits_P
               IN R25,Digits_P
               ANDI R24,16
               LDI R26,8
               ADD R25,R26
               ANDI R25,8
               ADD R24,R25
               OUT Digits_P,R24
               DELAY 500
               RJMP ThreadB
               RETI


   DelayLoop: 
               LDI R24,52
               LDI R25,5
  DelayOneMsLoop:
               NOP
               SBIW R24,1
               BRBS 1,DelayOneMsEnd
               RJMP DelayOneMsLoop
  DelayOneMsEnd:
               SBIW R26,1
               BREQ END
               RJMP DelayLoop  
         END:
               RET     