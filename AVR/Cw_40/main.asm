;
; Cw_40.asm
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

    .MACRO SET_DIGIT
        PUSH R16
        PUSH R17
        PUSH R18
        PUSH R30
        PUSH R31
        LDI R17,@0
        STS 0x60,R17 
        RCALL SET_DIGIT_SUBROUTINE 
        OUT Digits_P,R17
        OUT Segments_P,R16
        POP R16
        POP R17
        POP R18
        POP R30
        POP R31
    .ENDMACRO

    .EQU Time=1
    .EQU Digits_P=PORTB      ;Zmiana nazwy PortB
    .EQU Segments_P=PORTD    ;zapalenie odpowiednich segmentów
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
    OUT DDRD,R16
    OUT Segments_P,R16
    OUT DDRB,R17
    OUT Digits_P,R20
    LDI R16,10
  MainLoop:  
    INC Digit_3
    CP R16,Digit_3
    BRNE SetDigit
    CLR Digit_3
  RJMP MainLoop
 SetDigit: NOP
    SET_DIGIT 3     //ZAPALENIE WYSWIETLACZA 0 I CYFRY DO NIEGO PRZYPISANEJ
    DELAY 1000       
    SET_DIGIT 2    //ZAPALENIE WYSWIETLACZA 1 I CYFRY DO NIEGO PRZYPISANEJ
    DELAY 1
    SET_DIGIT 1    //ZAPALENIE WYSWIETLACZA 2 I CYFRY DO NIEGO PRZYPISANEJ              
    DELAY 1     
    SET_DIGIT 0         //ZAPALENIE WYSWIETLACZA 3 I CYFRY DO NIEGO PRZYPISANEJ
    DELAY 1
    
 RJMP MainLoop

  TurnOnDigit0:
    MOV R16,Digit_0
    STS 0x61,R16
    RJMP LOOP1
  TurnOnDigit1:
    MOV R16,Digit_1
    STS 0x61,R16
    RJMP LOOP1
  TurnOnDigit2:
    MOV R16,Digit_2
    STS 0x61,R16
    RJMP LOOP1
  TurnOnDigit3:
    MOV R16,Digit_3
    STS 0x61,R16
    RJMP LOOP1

  SET_DIGIT_SUBROUTINE:
    LDI R18,0
    LDS R17,0x60
    CP R17,R18
    BREQ TurnOnDigit0
    INC R18
    CP R17,R18
    BREQ TurnOnDigit1
    INC R18
    CP R17,R18
    BREQ TurnOnDigit2
    INC R18
    CP R17,R18
    BREQ TurnOnDigit3
    LOOP1: NOP
    RCALL DigitTo7segCode 
    ldi R30, low(DIGITNUMBER<<1) // inicjalizacja rejestru Z
    ldi R31, high(DIGITNUMBER<<1)
    LDS R17,0x60
    ADD R30,R17                 // inkrementacja Z
    lpm R17, Z                  // odczyt ODPOWIEDNIEJ sta³ej  
    DIGITNUMBER: .db 2,4,8,16   //NUMER WYSWITLACZA
  RET
        

  DigitTo7segCode:
    ldi R30, low(SegCode<<1) // inicjalizacja rejestru Z
    ldi R31, high(SegCode<<1)
    LDS R16,0x61
    ADD R30,R16// inkrementacja Z
    lpm R16, Z // odczyt 2 sta³ej  
    SegCode: .db 0x3F, 0x06, 0x5B,0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F //0,1,2,3,4,5,6,7,8,9 <- 7-SEG 
  RET
        



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
    LDI R17,4
    PUSH R17
    LDI R16,118
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

   
                     