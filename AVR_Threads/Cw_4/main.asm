;
; Cw_3.asm
;
; Created: 29.10.2020 11:35:27
; Author : IAmTheProgramer
;



                .CSEG
                .ORG 0 RJMP _main 
                .ORG OC1Aaddr RJMP _timer_isr 
       
     _timer_isr: 
                
                INC CurrentThread
                ANDI CurrentThread,1
                CPI CurrentThread,1
                BREQ _Thread_B
     _Thread_A:
                INC CtrA
                POP ThreadB_MSB
                POP ThreadB_LSB
                PUSH ThreadA_LSB
                PUSH ThreadA_MSB
                RETI
     _Thread_B:
                INC CtrB
                POP ThreadA_MSB
                POP ThreadA_LSB
                PUSH ThreadB_LSB
                PUSH ThreadB_MSB
                RETI                          

                .DEF CurrentThread=R19
                .DEF ThreadA_LSB=R20
                .DEF ThreadA_MSB=R21
                .DEF ThreadB_LSB=R22
                .DEF ThreadB_MSB=R23
                .DEF CtrA=R24
                .DEF CtrB=R25

          _main:
                LDI R16,9
                OUT TCCR1B,R16
                LDI R16,high(99)
                OUT OCR1AH,R16
                LDI R16,LOW(99)
                OUT OCR1AL,R16
                LDI R16,64
                OUT TIMSK,R16
                CLR R16
                OUT TCNT1L,R16
                OUT TCNT1H,R16
                CLR CurrentThread
                LDI ThreadA_LSB,LOW(ThreadA)
                LDI ThreadA_MSB,HIGH(ThreadA)
                LDI ThreadB_LSB,LOW(ThreadB)
                LDI ThreadB_MSB,HIGH(ThreadB)
                SEI
      ThreadA:   
                NOP
                NOP
                NOP
                NOP
                NOP
                RJMP ThreadA

      ThreadB:
                NOP
                NOP
                NOP
                NOP
                NOP
                RJMP ThreadB
                RETI
