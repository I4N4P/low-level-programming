;
; Cw_36.asm
;
; Created: 09.10.2020 17:11:35
; Author : IAmTheProgramer
;


 
        LDI R30, LOW(Table<<1) 
        LDI R31, HIGH(Table<<1)
        LPM R20, Z 
        ADIW R30:R31,1 
        LPM R21, Z 
        ADIW R30:R31,1 
        LPM R22, Z 
        ADIW R30:R31,1 
        LPM R23, Z 
        NOP
        Table: .db 0x57, 0x58, 0x59, 0x5A 
                     