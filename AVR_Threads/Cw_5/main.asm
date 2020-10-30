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
                STS  0x60,R23
                STS  0x61,R24
                STS  0x62,R25
                LDS  R23, 0x63
                LDS  R24, 0x64
                LDS  R25,0x65
                MOV   ThreadB_SREG_COPY,R20
                POP R20
                OUT  SREG,ThreadA_SREG_COPY
                POP  ThreadB_MSB
                POP  ThreadB_LSB
                PUSH ThreadA_LSB
                PUSH ThreadA_MSB
                RETI
     _Thread_B:
                STS  0x63,R23
                STS  0x64,R24
                STS  0x65,R25
                LDS  R23, 0x60
                LDS R24, 0x61
                LDS  R25,0x62
                MOV  ThreadA_SREG_COPY,R20
                POP  R20
                OUT  SREG,ThreadB_SREG_COPY
                POP  ThreadA_MSB
                POP  ThreadA_LSB
                PUSH ThreadB_LSB
                PUSH ThreadB_MSB
                RETI                          

                .EQU Digits_P=PORTB     
                .EQU Segments_P=PORTD    
                
                .DEF ThreadA_LSB=R0
                .DEF ThreadA_MSB=R1
                .DEF ThreadB_LSB=R2
                .DEF ThreadB_MSB=R3
                .DEF ThreadA_SREG_COPY=R4
                .DEF ThreadB_SREG_COPY=R5

                .DEF CurrentThread=R21
                

          _main:
           SEI 
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
                
      ThreadA:   
               
               IN R24,Digits_P
               IN R25,Digits_P
               ANDI R24,8
               ldi R23,16
               add R25,R23
               ANDI R25,16
               add R24,R25
               OUT Digits_P,R24
               
              LDI R23 ,1
  ThreadALoop: 
               LDI R24,52
               LDI R25,250
  ThreadADelayOneMsLoop:
               NOP
               SBIW R24,1
               BRBS 1,ThreadADelayOneMsEnd
               RJMP ThreadADelayOneMsLoop
  ThreadADelayOneMsEnd:
               DEC R23
               CPSE R23,R24
               RJMP ThreadALoop 
                      
               RJMP ThreadA

      ThreadB:                          
               IN R24,Digits_P
               IN R25,Digits_P
               ANDI R24,16
               ldi R23,8
               add R25,R23
               ANDI R25,8
               add R24,R25
               OUT Digits_P,R24

               LDI R23 ,2
    ThreadBLoop: 
               LDI R24,52
               LDI R25,250
    ThreadBDelayOneMsLoop:
               NOP
               SBIW R24,1
               BRBS 1,ThreadBDelayOneMsEnd
               RJMP ThreadBDelayOneMsLoop
    ThreadBDelayOneMsEnd:
               DEC R23
               CPSE R23,R24
               RJMP ThreadBLoop
             
               RJMP ThreadB
               RETI
