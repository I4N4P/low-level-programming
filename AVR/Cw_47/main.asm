;
; Cw_47.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


; Replace with your application code

    .cseg                         ; segment pamiêci kodu programu

    .org 0 rjmp _main             ; skok po resecie (do programu g³ównego)
    .org 0x0004 rjmp _timer_isr ; skok do obs³ugi przerwania timera
 
  _timer_isr:                   ; procedura obs³ugi przerwania timera
    INC PulseEdgeCtrL
    CP PulseEdgeCtrL,QCtrL
    CPC PulseEdgeCtrH,QCtrH
    BREQ CLEAR
    MOV XH,PulseEdgeCtrH
    MOV XL,PulseEdgeCtrL
    RCALL NumberToDigits
  reti                           ; powrót z procedury obs³ugi przerwania (reti zamiast ret) 

   _main: 
    ldi r16,0b0001100
    out TCCR1B,r16
    ldi r16,high(31250)
    out OCR1AH,r16
    ldi r16,low(31250)
    out OCR1AL,r16
    ldi r16,0
    out TCNT1L,r16
    out TCNT1H,r16
    ldi r16,0b01000000
    out TIMSK,r16
    sei

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
    .DEF PulseEdgeCtrL=R0
    .DEF PulseEdgeCtrH=R1
    
; outputs
    .def RL=R20 ; remainder
    .def RH=R21
    .def QL=R22 ; quotient
    .def QH=R23
; internal
    .def QCtrL=R24
    .def QCtrH=R25

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
    LDI QCtrL,255
    LDI QCtrH,0
    LDI  XH,HIGH(0000)
    LDI  XL,LOW(0000)
    MOV PulseEdgeCtrH,XH
   mov PulseEdgeCtrL,XL

  MainLoop: 
    LDI QCtrL,LOW(9999)
    LDI QCtrH,HIGH(9999)
    
    RCALL SetDigit
    
    LDI QCtrL,255
    CPSE PulseEdgeCtrL,QCtrL
    RJMP MainLoop
    INC PulseEdgeCtrH
    RJMP MainLoop
    CLEAR:
    CLR PulseEdgeCtrL
    CLR PulseEdgeCtrH
    RJMP MainLoop
    reti
  NumberToDigits:
    LDI  YH,HIGH(1000)
    LDI  YL,LOW(1000)
    RCALL Divide
    mov  Digit_0,Ql
    mov  XH,RH
    mov  XL,RL
    LDI  YL,LOW(100)
    LDI  YH,HIGH(100)
    RCALL Divide
    mov  Digit_1,QL
    mov  XH,RH
    mov  XL,RL
    LDI  YL,LOW(10)
    LDI  YH,HIGH(10)
    RCALL Divide
    mov  Digit_2,QL
    mov  XH,RH
    mov  XL,RL
    LDI  YL,LOW(1)
    LDI  YH,HIGH(1)
    RCALL Divide
    mov  Digit_3,Ql
  ret


  Divide : NOP
   LDI QCtrL,1
   LDI QCtrH,0
   
   CLR RL
   CLR RH
   CLR QL
   CLR QH
    CP XL,YL
    CPC XH,YH
    BRLO DIV_RETURN1 
DIV_LOOP:NOP
    SUB XL,YL
    SBC XH,YH
    BRBS 1,DIV_RETURN1-2       // zwieksza  quotient i konczy dzia³anie
    ADD QL,QCtrL
    ADC QH,QCtrH
    CP XL,YL
    CPC XH,YH
    BRLO DIV_RETURN1         // konczy dzia³anie
    RJMP DIV_LOOP
    ADD QL,QCtrL
    ADC QH,QCtrH
DIV_RETURN1: NOP
    MOV RL,XL
    MOV RH,XH
DIV_RETURN: NOP
   RET
 SetDigit: NOP
    SET_DIGIT 3     //ZAPALENIE WYSWIETLACZA 0 I CYFRY DO NIEGO PRZYPISANEJ
    DELAY 1       
    SET_DIGIT 2    //ZAPALENIE WYSWIETLACZA 1 I CYFRY DO NIEGO PRZYPISANEJ
    DELAY 1
    SET_DIGIT 1    //ZAPALENIE WYSWIETLACZA 2 I CYFRY DO NIEGO PRZYPISANEJ              
    DELAY 1     
    SET_DIGIT 0         //ZAPALENIE WYSWIETLACZA 3 I CYFRY DO NIEGO PRZYPISANEJ
    DELAY 1
    
 ret

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

   
                     