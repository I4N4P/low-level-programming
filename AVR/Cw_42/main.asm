;
; Cw_42.asm
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
    Divide :   
               PUSH R25
               PUSH R24
               LDI XHH,HIGH(9)
               LDI XLL,LOW(9)
               LDI YLL,LOW(1)
               LDI YHH,HIGH(1) 
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

   