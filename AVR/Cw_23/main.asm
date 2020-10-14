;
; Cw_23.asm
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
    RCALL DelayOneMs
    DEC R22
    BRBC 1,DelayInMs
    RET
  DelayOneMs: 
    LDI R26,1 
    LDI R28,30
    LDI R29,3
    CLR R27
    CLR R30
    CLR R31
 LOOP:NOP
    NOP
    SUB R28,R26
    ADC R19,R27
    SUB R29,R19
    CLR R19
    CP R28,R30
    CPC R29,R31 
    BRNE LOOP
    NOP
    NOP
    NOP
    NOP
    RET ;powrót do miejsca wywo³ania