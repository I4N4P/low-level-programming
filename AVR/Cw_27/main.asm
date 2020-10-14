;
; Cw_27.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code

MainLoop:
    LDI R16,1           ;Liczba milisekund <1,255> LSB
    LDI R17,1             ;Liczba milisekund <0,255> MSB     
    rcall DelayInMs 
    RETURN:
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
    PUSH R16                ;powrót do RCALL DelayInMs 
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
    BRBS 1,RETURN     ; skok jesli = 0 pomija jesli r17=!0
    LDI R16,255
    DEC R17
    PUSH R17
    PUSH R16
    RJMP DelayInMs
                     