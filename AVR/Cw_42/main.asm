

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
Divide : NOP
   LDI QCtrL,1
   LDI QCtrH,0
   LDI  XH,HIGH(4)
   LDI  XL,LOW(4)
   LDI  YL,LOW(2)
   LDI  YH,HIGH(2)
   CLR RL
   CLR RH
   CLR QL
   CLR QH

    SUB XL,YL
    SBC XH,YH
    BRBS 1,Divide+20        // zwieksza  quotient i konczy dzia³anie
    ADD QL,QCtrL
    ADC QH,QCtrH
    CP XL,YL
    CPC XH,YH
    BRLO Divide+22         // konczy dzia³anie
    RJMP Divide+10
    ADD QL,QCtrL
    ADC QH,QCtrH
    MOV RL,XL
    MOV RH,XH
   RET

   