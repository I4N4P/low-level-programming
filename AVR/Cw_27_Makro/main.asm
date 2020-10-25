;
; Cw_27_B.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;





         .MACRO LOAD_CONST 
            PUSH R16
            PUSH R17
            LDI @0,LOW(@2)   
            LDI @1,HIGH(@2) 
            RCALL DelayInMs 
            POP R17
            POP R16
        .ENDMACRO

MainLoop:
         LOAD_CONST R16,R17,1 
         RJMP MainLoop

   DelayInMs: 
             PUSH R24
             PUSH R25
             MOV R24,R16
             MOV R25,R17 
             SBIW R24,0
             BRBS 1,DelayInMsEnd
   DelayInMsLoop:
             RCALL DelayOneMs
             SBIW R24,1
             BRBS 1,DelayInMsEnd
             RJMP DelayInMsLoop
   DelayInMsEnd:
             POP R25
             POP R24
             RET


  DelayOneMs:
             PUSH R24
             PUSH R25
             LDI R24,52
             LDI R25,5
  DelayOneMsLoop:
             NOP
             SBIW R24,1
             BRBS 1,DelayOneMsEnd
             RJMP DelayOneMsLoop
  DelayOneMsEnd:
             POP R25
             POP R24
             RET