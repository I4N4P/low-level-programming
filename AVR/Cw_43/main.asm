
   

//
//Quotient=0
//while (Divident>=Divisor) { // for “>” use cp and cpc instructions
//vident = Divident - Divisor;
//Quotient++; // use adiw instruction
//}
//Remainder = Divident
//--------------------------------------------------------------------------------------------------------
;*** Divide ***
; X/Y -> Quotient,Remainder
; Input/Output: R16-19, Internal R24-25
; inputs
.def XL=R16 ; divident
.def XH=R17
.def YL=R18 ; divisor
.def YH=R19
; outputs
.def RL=R20 ; remainder
.def RH=R21
.def QL=R22 ; quotient
.def QH=R23
; internal
.def QCtrL=R24
.def QCtrH=R25
.def Dig0=R26
.def Dig1=R27
.def Dig2=R28
.def Dig3=R29
mainloop:
rjmp mainloop

LDI  XH,HIGH(1001)
LDI  XL,LOW(1001)
NumberToDigits:
LDI  YH,HIGH(1000)
LDI  YL,LOW(1000)
RCALL Divide
mov  Dig0,Ql
mov  XH,RH
mov  XL,RL
LDI  YL,LOW(100)
LDI  YH,HIGH(100)
RCALL Divide
mov  Dig1,QL
mov  XH,RH
mov  XL,RL
LDI  YL,LOW(10)
LDI  YH,HIGH(10)
RCALL Divide
mov  Dig2,QL
mov  XH,RH
mov  XL,RL
LDI  YL,LOW(1)
LDI  YH,HIGH(1)
RCALL Divide
mov  Dig3,Ql
ret


Divide : NOP
   LDI QCtrL,1
   LDI QCtrH,0
   
   CLR RL
   CLR RH
   CLR QL
   CLR QH
    SUB XL,YL
    SBC XH,YH
    BRBS 1,Divide+16        // zwieksza  quotient i konczy dzia³anie
    ADD QL,QCtrL
    ADC QH,QCtrH
    CP XL,YL
    CPC XH,YH
    BRLO Divide+18         // konczy dzia³anie
    RJMP Divide+6
    ADD QL,QCtrL
    ADC QH,QCtrH
    MOV RL,XL
    MOV RH,XH
   RET

   
   