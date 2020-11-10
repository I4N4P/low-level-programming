/*
 *   Cw_2.asm
 *
 *   Created: 10/7/2020 1:28:51 PM
 *   Author: IAmTheProgramer
 */ 


      LDI R16, 3
      MOV R0, R16
LOOP: NOP
      DEC R0
      RJMP LOOP
