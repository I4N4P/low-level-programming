			AREA	MAIN_CODE, CODE, READONLY
			GET		LPC213x.s
DIGIT_0	    RN	8
DIGIT_1	    RN	9
DIGIT_2	    RN	10
DIGIT_3	    RN	11

CURR_DIG    RN  12
			
			ENTRY
__main
__use_two_region_memory
			EXPORT	__main
			EXPORT	__use_two_region_memory
			
			LDR	  R1, =IO0DIR
			LDR	  R0, =0xF0000
			STR	  R0, [R1]
		
			LDR	  R1, =IO1DIR
			LDR	  R0, =0xFF0000
			STR	  R0, [R1]
			
			LDR	  DIGIT_0, =3
			LDR	  DIGIT_1, =2
			LDR	  DIGIT_2, =1
			LDR	  DIGIT_3, =0
			
			eor CURR_DIG,CURR_DIG
main_loop	
			
			LDR   R5, =IO0CLR
			LDR	  R4, =0xF0000
			STR	  R4, [R5]
		
			LDR	  R5, =IO0SET
			LDR	  R4, =0x80000
			MOV   R4,R4,LSR CURR_DIG
			STR	  R4, [R5]

			CMP   CURR_DIG,#0
			MOVEQ R6,DIGIT_0
			CMP   CURR_DIG,#1
			MOVEQ R6,DIGIT_1
			CMP   CURR_DIG,#2
			MOVEQ R6,DIGIT_2
			CMP   CURR_DIG,#3
			MOVEQ R6,DIGIT_3
			
			ADR	  R4, SevenSegCodes
			ADD   R4,R4,R6		
			LDRB  R6, [R4]
			
			LDR	  R5, =IO1CLR
			LDR	  R4, =0xFF0000
			STR	  R4, [R5]

			MOV   R6, R6, LSL #16
			LDR	  R5, =IO1SET
			STR	  R6, [R5]
			
			ADD   CURR_DIG,CURR_DIG,#1
			CMP   CURR_DIG,#4
			EOREQ CURR_DIG,CURR_DIG
			
			LDR   R0,=10
			BL    Delay_in_ms
			B     main_loop

Delay_in_ms			
			LDR   R2,=15000
			MUL   R2,R0,R2
Delay_in_ms_loop
			SUBS  R2,R2,#1	
			BNE	  Delay_in_ms_loop			
			BX    LR
			
SevenSegCodes
			DCB   0x3f,0x06,0x5B,0x4F,0x66,0x6d,0x7D,0x07,0x7f,0x6f			
			
			
			END

