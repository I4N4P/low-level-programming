;
; Cw_20.asm
;
; Created: 09.10.2020 17:11:35
; Author : Dawid
;


; Replace with your application code

MainLoop:
    rcall DelayNCycles ;
    rcall additional
    rjmp MainLoop
DelayNCycles: ;zwyk³a etykieta
    nop
    nop
    nop
    ret ;powrót do miejsca wywo³ania 
Additional:
nop
nop
nop
ret