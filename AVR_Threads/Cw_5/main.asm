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

               LDI R18 ,5
         LOOP7:
               LDI R26,52
               LDI R27,250
      DelayOneMsLoop7:
               NOP
               SBIW R26,1
               BRBS 1,DelayOneMsEnd7
               RJMP DelayOneMsLoop7
      DelayOneMsEnd7:
               DEC R18
               CPSE R18,R26
               RJMP LOOP7         
  
               SBI Digits_P,4

               LDI R18 ,5
        LOOP6:
               LDI R26,52
               LDI R27,250
      DelayOneMsLoop6:
               NOP
               SBIW R26,1
               BRBS 1,DelayOneMsEnd6
               RJMP DelayOneMsLoop6
      DelayOneMsEnd6:
               DEC R18
               CPSE R18,R26
               RJMP LOOP6
             
               RJMP ThreadA

      ThreadB:                          //KKKKK
                
                CBI Digits_P,3

               LDI R17 ,30
        LOOP5: 
               LDI R24,52
               LDI R25,250
      DelayOneMsLoop5:
               NOP
               SBIW R24,1
               BRBS 1,DelayOneMsEnd5
               RJMP DelayOneMsLoop5
      DelayOneMsEnd5:
               DEC R17
               CPSE R17,R24
               RJMP LOOP5
             

               SBI Digits_P,3

               LDI R17 ,30
         LOOP4: 
               LDI R24,52
               LDI R25,250
      DelayOneMsLoop4:
               NOP
               SBIW R24,1
               BRBS 1,DelayOneMsEnd4
               RJMP DelayOneMsLoop4
      DelayOneMsEnd4:
               DEC R17
               CPSE R17,R24
               RJMP LOOP4
             
               RJMP ThreadB
               RETI
