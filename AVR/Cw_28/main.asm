;
; Cw_28.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


; Replace with your application code

    .MACRO DELAY
        LDI R16,LOW(@0)   ;Liczba milisekund <1,255> LSB
        LDI R17,HIGH(@0)  ;Liczba milisekund <0,255> MSB
        RCALL DelayInMs
    .ENDMACRO

    LDI R21,15
    OUT DDRB,R21
    OUT PORTB,R21
MainLoop:
    OUT PORTB,R21
    DELAY 100
    OUT PORTB,R20
    DELAY 100
    rjmp MainLoop



DelayInMs:
    PUSH R17                ;Poœlij na STOSU     
    PUSH R16  
    RCALL DelayOneMs
    POP R16                 ;POBIERZ ZE STOSU
    POP R17            
    DEC R16
    BRBC 1,DelayInMs    ; skok jesli wiekszy od 0 pomija jesli r16=0
    RCALL CheckMSB
    PUSH R17
    PUSH R16
    RET                 ;powrót do RCALL DelayInMs 
  DelayOneMs:         
    LDI R22,4
    PUSH R22
    LDI R21,113
    PUSH R21   
  LOOP:NOP
    NOP
    POP R21
    DEC R21
    PUSH R21
    BRBC 1,LOOP        ; skok jesli wiekszy od 0 pomija jesli r21=0
    POP R21
    POP R22
    DEC R22  
    PUSH R22
    PUSH R21
    BRBC 1,LOOP         ; skok jesli wiekszy od 0 pomija jesli r22=0
    POP R21
    POP R22
    RET                 ;powrót do RCALL DelayOneMs
 CheckMSB: NOP
    INC R17             ;zapenia dobre dzia³anie w momencie kiedy r17=0
    DEC R17
    BRBS 1,MainLoop     ; skok jesli = 0 pomija jesli r17=!0
    LDI R16,255
    DEC R17
    PUSH R17
    PUSH R16
    RJMP DelayInMs
                     