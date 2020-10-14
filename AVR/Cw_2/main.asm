/*
 * Cw_2.asm
 *
 *  Created: 10/7/2020 1:28:51 PM
 *   Author: student
 */ 


    ldi R20, 3
    mov R0, R20
LOOP: nop
    dec R0
    rjmp LOOP
