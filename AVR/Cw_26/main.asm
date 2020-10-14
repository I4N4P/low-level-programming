;
; Cw_26.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code

MainLoop:
    LDI R22,10 
    STS 0x60,R22
    rcall DelayInMs 
    rjmp MainLoop
DelayInMs: ;zwyk³a etykieta  
    STS 0x62,R22   
    RCALL DelayOneMs
    LDS R22,0x62
    DEC R22
    BRBC 1,DelayInMs
    RET
  DelayOneMs:     
    LDI R21,116
    STS 0x61,R21
    LDI R22,4
    STS 0x60,R22
  LOOP:NOP
    NOP
    LDS R21,0x61
    DEC R21
    STS 0x61,R21
    BRBC 1,LOOP
    LDS R22,0x60
    DEC R22  
    STS 0x60,R22
    BRBC 1,LOOP
    RET ;powrót do miejsca wywo³ania