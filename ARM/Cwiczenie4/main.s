			AREA	MAIN_CODE, CODE, READONLY
			GET		LPC213x.s
		
		
			ENTRY
__main
__use_two_region_memory
			EXPORT	__main
			EXPORT	__use_two_region_memory
			
			LDR	 R1, =IO0DIR
			LDR	 R0, =0xF0000
			STR	 R0, [R1]
		
			LDR	 R1, =IO1DIR
			LDR	 R0, =0xFF0000
			STR	 R0, [R1]
			
main_loop			
			LDR  R0,=10
			BL   Delay_in_ms
			B    main_loop

Delay_in_ms			
			LDR  R2,=15000
			MUL  R2,R0,R2
Delay_in_ms_loop
			SUBS R2,R2,#1	
			BNE	 Delay_in_ms_loop			
			BX   LR
			
			END

