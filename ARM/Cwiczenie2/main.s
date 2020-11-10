			AREA	MAIN_CODE, CODE, READONLY		
		
			ENTRY
__main
__use_two_region_memory
			EXPORT			__main
			EXPORT			__use_two_region_memory
		
			LDR  R0,=1
			LDR  R4,=15000
			MUL  R4,R0,R4
loop
			SUBS R4,R4,#1	
			BNE	 loop			
	        
			END

