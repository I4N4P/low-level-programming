

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
; input
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
   LDI  XH,HIGH(1001)
   LDI  XL,LOW(1001)
   LDI  YL,LOW(1000)
   LDI  YH,HIGH(1000)
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

   