;
; Cw_25.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code

MainLoop:
    LDI R22,10 
    rcall DelayInMs ;
    rjmp MainLoop
DelayInMs: ;zwyk³a etykieta  
    STS 0x60,R22   
    RCALL DelayOneMs
    LDS R22,0x60
    DEC R22
    BRBC 1,DelayInMs
    RET
  DelayOneMs:  
    LDI R21,143
    LDI R22,47
  LOOP:NOP
    NOP
    DEC R21
    BRBC 1,LOOP
    LDI R21,31
    DEC R22
    BRBC 1,LOOP
    RET ;powrót do miejsca wywo³ania