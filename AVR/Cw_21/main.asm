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
DelayNCycles: ;zwyk�a etykieta
    nop
    nop
    nop
    ret ;powr�t do miejsca wywo�ania 
Additional:
nop
nop
nop
ret