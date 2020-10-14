;
; Cw_29.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


; Replace with your application code

    .MACRO DELAY
        STS 0x60,R17                ;Poœlij na STOSU     
        STS 0x61,R16
        LDI R16,LOW(@0)   ;Liczba milisekund <1,255> LSB
        LDI R17,HIGH(@0)  ;Liczba milisekund <0,255> MSB
        PUSH R17                ;Poœlij na STOSU     
        PUSH R16
        RCALL DelayInMs
        LDS R17,0x60               ;Poœlij na STOSU     
        LDS R16,0x61
    .ENDMACRO

    LDI R16,6
    LDI R17,2
    OUT DDRD,R16
    OUT PORTD,R16
    OUT DDRB,R17
MainLoop:
    OUT PORTB,R17
    DELAY 2
    OUT PORTB,R20
    DELAY 2
    rjmp MainLoop



DelayInMs:
    
    PUSH R17                ;Poœlij na STOSU     
    PUSH R16  
    RCALL DelayOneMs
    POP R16                 ;POBIERZ ZE STOSU
    POP R17            
    DEC R16
    BRBC 1,DelayInMs    ; skok jesli wiekszy od 0 pomija jesli r16=0
    RJMP CheckMSB
    Return:RET  
  DelayOneMs:         
    LDI R17,4
    PUSH R17
    LDI R16,113
    PUSH R16   
  LOOP:NOP
    NOP
    POP R16
    DEC R16
    PUSH R16
    BRBC 1,LOOP        ; skok jesli wiekszy od 0 pomija jesli r21=0
    POP R16
    POP R17
    DEC R17  
    PUSH R17
    PUSH R16
    BRBC 1,LOOP         ; skok jesli wiekszy od 0 pomija jesli r22=0
    POP R16
    POP R17
    RET                 ;powrót do RCALL DelayOneMs
 CheckMSB: NOP
    INC R17             ;zapenia dobre dzia³anie w momencie kiedy r17=0
    DEC R17
    BRBS 1,Return   ; skok jesli = 0 pomija jesli r17=!0
    LDI R16,255
    DEC R17
    RJMP DelayInMs
   
                     