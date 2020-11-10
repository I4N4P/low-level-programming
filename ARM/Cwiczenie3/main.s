			AREA	MAIN_CODE, CODE, READONLY
	
			ENTRY
__main
__use_two_region_memory
			EXPORT			__main
			EXPORT			__use_two_region_memory

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

