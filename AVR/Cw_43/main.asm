;*** NumberToDigits ***
;input : Number: R16-17
;output: Digits: R16-19
;internals: X_R,Y_R,Q_R,R_R - see _Divide
; internals ; 

; outputs

; internal
.def QCtrL=R24
.def QCtrH=R25
.def Dig0=R26 ; Digits temps
.def Dig1=R27 ;
.def Dig2=R28 ;
.def Dig3=R29
NumberToDigits:
   LDI  XH,HIGH(1234)
   LDI  XL,LOW(1234)
   LDI  YL,LOW(1000)
   LDI  YH,HIGH(1000)
   RCALL Divide
   MOV  Dig0,R21
   LDI  R17,HIGH(R21)
   LDI  XL,LOW(R20)
   LDI  YL,LOW(100)
   LDI  YH,HIGH(100)
   RCALL Divide
   MOV  Dig1,RL
   LDI  XH,HIGH(RH)
   LDI  XL,LOW(RL)
   LDI  YL,LOW(10)
   LDI  YH,HIGH(10)
   RCALL Divide
   MOV  Dig2,RL
   LDI  XH,HIGH(RH)
   LDI  XL,LOW(RL)
   LDI  YL,LOW(1)
   LDI  YH,HIGH(1)
   RCALL Divide
   MOV  Dig3,RL



   RET

Divide : NOP
   LDI QCtrL,1
   LDI QCtrH,0
   
   CLR R20
   CLR R21
   CLR R22
   CLR R23

    SUB R16,R18
    SBC R17,R19
    BRBS 1,Divide+16        // zwieksza  quotient i konczy dzia³anie
    ADD R22,QCtrL
    ADC R23,QCtrH
    CP R16,R18
    CPC R17,R18
    BRLO Divide+18       // konczy dzia³anie
    RJMP Divide+10
    ADD R22,QCtrL
    ADC R23,QCtrH
    MOV R20,R16
    MOV R21,R17
   RET

   