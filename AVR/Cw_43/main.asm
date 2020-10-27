;
; Cw_43.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;
   


               .def XLL=R16 
               .def XHH=R17
               .def YLL=R18 
               .def YHH=R19

               .def RL=R16 
               .def RH=R17
               .def QL=R18 
               .def QH=R19

               .def QCtrL=R24
               .def QCtrH=R25
  
               .def Dig0=R26
               .def Dig1=R27
               .def Dig2=R28
               .def Dig3=R29
      MainLoop:
                LDI  XHH,HIGH(1001)
                LDI  XLL,LOW(1001)
                RCALL NumberToDigits
                RJMP MainLoop

               
 NumberToDigits:
                LDI  YHH,HIGH(1000)
                LDI  YLL,LOW(1000)
                RCALL Divide
                MOV  Dig0,QL
                LDI  YLL,LOW(100)
                LDI  YHH,HIGH(100)
                RCALL Divide
                MOV  Dig1,QL
                LDI  YLL,LOW(10)
                LDI  YHH,HIGH(10)
                RCALL Divide
                MOV  Dig2,QL
                LDI  YLL,LOW(1)
                LDI  YHH,HIGH(1)
                RCALL Divide
                MOV  Dig3,Ql
                RET


    Divide :   
               PUSH R25
               PUSH R24
    DivideLoop:
               CP XLL,YLL
               CPC XHH,YHH
               BRLO DivideEnd 
               ADIW QCtrH:QCtrL,1 
               SUB XLL,YLL
               SBC XHH,YHH
               BRBS 1,DivideEnd              
               RJMP DivideLoop
    DivideEnd: 
               MOV QL,QCtrL
               MOV QH,QCtrH
               MOV RL,XLL
               MOV RH,XHH
               POP R24
               POP R25
               RET

   
   