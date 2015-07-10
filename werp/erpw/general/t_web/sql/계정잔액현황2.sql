  	   			SELECT    
 	  				A.ACC_CODE,   
 	  				A.COMP_CODE,   
 	  				A.DEPT_CODE,   
 	  				A.CUST_SEQ,   
 	   				A.SLIP_ID ,     
 	   				A.SLIP_IDSEQ,   
 	  				D.ACC_REMAIN_POSITION,   
 	   				-- 설정    
 	 				DECODE(D.ACC_REMAIN_POSITION, 'D', 1, 0)*NVL(A.DB_AMT,0)  
 	 				+  
 	 				DECODE(D.ACC_REMAIN_POSITION, 'C', 1, 0)*NVL(A.CR_AMT,0) SET_AMT,  
 	 				-- 반제확정  
 	 				DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B1.DB_AMT,0)  
 	 				+  
 	 				DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B1.CR_AMT,0) RESET_AMT,   
 	 				-- 반제미확정  
 	 				DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B2.DB_AMT,0)  
 	 				+  
 	 				DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B2.CR_AMT,0) NOT_RESET_AMT    
 	   			FROM    
 	   				(
		 	   			SELECT    
		 	  				A.ACC_CODE,   
		 	  				A.COMP_CODE,   
		 	  				A.DEPT_CODE,   
		 	  				A.CUST_SEQ,   
		 	   				A.SLIP_ID ,     
		 	   				A.SLIP_IDSEQ,
							A.DB_AMT,
							A.CR_AMT,
							ROWNUM rn1
		 	   			FROM    
		 	   				T_ACC_SLIP_REMAIN A,     
		 	   				T_CUST_CODE C,
		 	  				T_ACC_CODE_CHILD2 E   
		 	   			WHERE    
		 	   				A.SLIP_ID = A.RESET_SLIP_ID     
		 	   				AND	A.SLIP_IDSEQ = A.RESET_SLIP_IDSEQ     
		 	   				AND	A.CUST_SEQ = C.CUST_SEQ     
		 	   				--AND	A.ACC_CODE = D.ACC_CODE    
		 	   				AND A.KEEP_DT IS NOT NULL    
		 	   				AND	A.COMP_CODE LIKE :COMP_CODE || '%'    
		 	   				AND	A.DEPT_CODE LIKE :DEPT_CODE || '%'    
		 	   				AND	A.MAKE_DT BETWEEN F_T_Stringtodate(    :DT_F    ) AND F_T_Stringtodate(    :DT_T    )    
		 	   				--AND A.ACC_CODE LIKE :ACC_CODE || '%'     
		 	  				AND	A.ACC_CODE = E.CHILD_ACC_CODE
							AND E.PARENT_ACC_CODE LIKE :ACC_CODE    || '%'
		 	   				AND	C.CUST_CODE LIKE     :CUST_CODE      || '%'    
		 	   				--AND A.TRANSFER_TAG <> 'T'  
		 	   				--AND A.SLIP_KIND_TAG <> 'Z'  
					) A,     
 	   				(  
					SELECT A.*, ROWNUM rn2  FROM (
 	 					SELECT  
 	 						A.RESET_SLIP_ID,  
 	 						A.RESET_SLIP_IDSEQ,  
 	 						NVL(SUM(A.DB_AMT),0) DB_AMT,  
 	 						NVL(SUM(A.CR_AMT),0) CR_AMT
 	 					FROM  
 	 						T_ACC_SLIP_REMAIN A, 
 							T_ACC_CODE_CHILD2 B  
 	 					WHERE    
 	 						--A.SLIP_ID <> A.RESET_SLIP_ID     
 	 						--AND	     
 	 						A.ACC_CODE = B.CHILD_ACC_CODE 
 	 						AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ     
 	 						AND A.KEEP_DT IS NOT NULL  
							AND B.PARENT_ACC_CODE LIKE :ACC_CODE    || '%'
 	 					GROUP BY  
 	 						A.RESET_SLIP_ID,  
 	 						A.RESET_SLIP_IDSEQ)  A
 	 				) B1,    
 	   				(  SELECT A.*, ROWNUM rn3 FROM (
 	 					SELECT  
 	 						A.RESET_SLIP_ID,  
 	 						A.RESET_SLIP_IDSEQ,  
 	 						NVL(SUM(A.DB_AMT),0) DB_AMT,  
 	 						NVL(SUM(A.CR_AMT),0) CR_AMT
 	 					FROM  
 	 						T_ACC_SLIP_REMAIN A, 
 							T_ACC_CODE_CHILD2 B 
 	 					WHERE    
 	 						--A.SLIP_ID <> A.RESET_SLIP_ID     
 	 						--AND 
 							A.ACC_CODE = B.CHILD_ACC_CODE 
 	 						AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ     
 	 						AND A.KEEP_DT IS NULL  
							AND B.PARENT_ACC_CODE LIKE :ACC_CODE    || '%'
 	 					GROUP BY  
 	 						A.RESET_SLIP_ID,  
 	 						A.RESET_SLIP_IDSEQ  ) A
 	 				) B2,    
 	   				T_ACC_CODE D
 	   			WHERE    
 	   				A.SLIP_ID = B1.RESET_SLIP_ID (+)  
 	   				AND	A.SLIP_IDSEQ = B1.RESET_SLIP_IDSEQ (+)    
 	   				AND	A.SLIP_ID = B2.RESET_SLIP_ID (+)  
 	   				AND	A.SLIP_IDSEQ = B2.RESET_SLIP_IDSEQ (+)    
 	   				AND	A.ACC_CODE = D.ACC_CODE 