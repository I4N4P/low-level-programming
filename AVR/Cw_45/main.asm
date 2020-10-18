;
; Cw_35.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


; Replace with your application code

    .MACRO DELAY
        PUSH r16             ;Poœlij na STOSU Rejestry które u¿ywane s¹ w delay
        PUSH R17                    
        LDI R16,LOW(@0)      ;Liczba milisekund <1,255> LSB
        LDI R17,HIGH(@0)     ;Liczba milisekund <0,255> MSB
        PUSH R17             ;Poœlij na STOSU zabezpieczenie rejestrów przed nadpisaniem    
        PUSH R16
        RCALL DelayInMs
        POP R17              ;Odkrycie STOSU     
        POP R16
        POP r17              ;odczytanie pierwotnych wartoœci w rejestrze
        POP R16                  
    .ENDMACRO

    .EQU Time=1
    .EQU Digits_P=PORTB      ;Zmiana nazwy PortB
    .EQU Segments_P=PORTD    ;zapalenie odpowiednich segmentów
    .DEF Digit_0 = R2
    .DEF Digit_1 = R3
    .DEF Digit_2 = R4
    .DEF Digit_3 = R5

    LDI R16,0b00111111
    MOV R2,R16
    LDI R16,0b00000110
    MOV R3,R16
    LDI R16,0b01011011
    MOV R4,R16
    LDI R16,0b01001111
    MOV R5,R16
    LDI R16,0x7F             
    LDI R17,2
    OUT DDRD,R16
    OUT Segments_P,R16
    OUT DDRB,R17
MainLoop:                   ; miganie diodami
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
    PUSH R17                ;Poœlij na STOSU     
    PUSH R16  
    RCALL DelayOneMs
    POP R16                 ;POBIERZ ZE STOSU
    POP R17            
    DEC R16
    BRBC 1,DelayInMs    ; skok jesli R16 wiekszy od 0 , pomija jesli r16=0
    INC R17             ;zapenia dobre dzia³anie w momencie kiedy r17=0
    DEC R17
    BRBS 1,Return   ; skok jesli R17 = 0 pomija jesli r17=!0
    LDI R16,255
    DEC R17
    RJMP DelayInMs
  Return:RET  
  DelayOneMs:         
    LDI R17,1
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

   
                     