;
; Cw_36.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;

         .MACRO EXPONENT
            PUSH R16
            LDI R16,@0
            RCALL EXPONENT_SUBROUTINE
            POP R16
         .ENDMACRO


  MainLoop:
            EXPONENT 11
            RJMP MainLoop
 
            EXPONENT_SUBROUTINE:
            LDI R30, LOW(ExponentData<<1) 
            LDI R31, HIGH(ExponentData<<1)
            ADD R30,R16
            LPM R16, Z    
            RET
            ExponentData: .db 0x00, 0x01, 0x04,0x09, 0x10, 0x19, 0x24, 0x31, 0x40, 0x51               