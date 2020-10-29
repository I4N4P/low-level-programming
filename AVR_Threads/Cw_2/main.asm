;
; Cw_2.asm
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
                NOP
                RETI                          

                .DEF CurrentThread=R19
                

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
                SEI
                CLR CurrentThread
                
      ThreadA:   
                NOP
                NOP
                NOP
                NOP
                NOP
                RJMP ThreadA
                RETI