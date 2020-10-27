;
; Cw_38.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;

 
             .MACRO DigitTo7segCode
                PUSH R16
                LDI R16,@0
                RCALL DigitTo7segCodeSub
                POP R16
             .ENDMACRO



MainLoop:
            DigitTo7segCode 1
            RJMP MainLoop
 

DigitTo7segCodeSub:
            LDI R30, LOW(SevenSegCodeData<<1) 
            LDI R31, HIGH(SevenSegCodeData<<1)
            ADD R30,R16
            LPM R16,Z     
            RET
            SevenSegCodeData: .db 0x3F, 0x06, 0x5B,0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F                   