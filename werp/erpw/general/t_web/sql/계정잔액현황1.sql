SELECT   
   	d.ACC_CODE ,    
   	d.ACC_NAME ,    
   	d.ACC_REMAIN_POSITION ,    
   	C.NAME ACC_REMAIN_POSITION_NAME ,     
   	e.COMP_CODE,   
   	e.COMPANY_NAME COMP_NAME,   
   	f.DEPT_CODE,   
   	f.DEPT_NAME,   
   	g.CUST_SEQ ,    
   	g.CUST_CODE ,    
   	g.CUST_NAME ,     
   	a.SLIP_ID ,    
   	a.SLIP_IDSEQ ,   
   	A.SET_AMT,   
   	A.RESET_AMT,    
   	A.NOT_RESET_AMT,   
   	A.SET_AMT - A.RESET_AMT REMAIN_AMT,   
   	b1.MAKE_SLIPNO||'-'||b2.MAKE_SLIPLINE MAKE_SLIPNOLINE,   
   	b3.SUMMARY1||' '||b3.SUMMARY2 SUMMARY,   
  	CASE   
  		WHEN A.SLIP_ID IS NOT NULL THEN ' '||F_T_Datetostring(b1.MAKE_DT)||' '   
  		WHEN A.CUST_SEQ  IS NOT NULL THEN '거래처 합계'   
  		WHEN A.DEPT_CODE  IS NOT NULL THEN '부서 합계'   
  		WHEN A.COMP_CODE  IS NOT NULL THEN '사업장 합계'   
  		WHEN A.ACC_CODE  IS NOT NULL THEN '계정 합계'   
  		ELSE '전체 합계'   
  	END MAKE_DT_P,   
   	-- 전표조회 인자   
   	b1.MAKE_COMP_CODE ,    
   	F_T_Datetostring(b1.MAKE_DT) MAKE_DT,    
   	b1.MAKE_SEQ ,    
   	b1.SLIP_KIND_TAG,  
  	CASE   
  		WHEN A.SLIP_ID IS NOT NULL THEN 'A'   
  		WHEN A.CUST_SEQ  IS NOT NULL THEN 'B'   
  		WHEN A.DEPT_CODE  IS NOT NULL THEN 'C'   
  		WHEN A.COMP_CODE  IS NOT NULL THEN 'D'   
  		WHEN A.ACC_CODE  IS NOT NULL THEN 'E'   
  		ELSE 'F'   
  	END ROW_TYPE,   
  	CASE   
  		WHEN A.SLIP_ID IS NOT NULL THEN '#FFFFFF'   
  		WHEN A.CUST_SEQ  IS NOT NULL THEN '#FFFFFF'   
  		WHEN A.DEPT_CODE  IS NOT NULL THEN '#EFEEFF'   
  		WHEN A.COMP_CODE  IS NOT NULL THEN '#D1ECC8'   
  		WHEN A.ACC_CODE  IS NOT NULL THEN '#D3D3D3'   
  		ELSE '#BFBEFF'   
  	END ROW_COLOR  
   FROM   
   (   
	    SELECT  
	  		X.ACC_CODE,  
	  		X.COMP_CODE,  
	  		X.DEPT_CODE,  
	  		X.CUST_SEQ,  
	   		X.SLIP_ID ,    
	   		X.SLIP_IDSEQ,  
	   		SUM(X.SET_AMT) SET_AMT,    
	   		SUM(X.RESET_AMT) RESET_AMT,    
	   		SUM(X.NOT_RESET_AMT) NOT_RESET_AMT   
	   	FROM    
   		(   
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
   				T_ACC_SLIP_BODY1 A,    
   				( 
 					SELECT 
 						A.RESET_SLIP_ID, 
 						A.RESET_SLIP_IDSEQ, 
 						NVL(SUM(A.DB_AMT),0) DB_AMT, 
 						NVL(SUM(A.CR_AMT),0) CR_AMT 
 					FROM 
 						T_ACC_SLIP_BODY1 A,
						(  
		  					SELECT                         
		  						DISTINCT B.ACC_CODE  
		  					FROM  
		  						T_ACC_CODE_CHILD A,  
		  						T_ACC_CODE B  
		  					WHERE  
		  						B.FUND_INPUT_CLS = 'T'  
		  						AND A.CHILD_ACC_CODE = B.ACC_CODE  
		  						AND A.PARENT_ACC_CODE LIKE  :ACC_CODE   || '%' 
		  					UNION  
		  					SELECT  
		  						B.ACC_CODE  
		  					FROM  
		  						T_ACC_CODE B  
		  					WHERE  
		  						B.FUND_INPUT_CLS = 'T'  
		  						AND B.ACC_CODE LIKE :ACC_CODE   || '%'
		  				) B 
 					WHERE   
 						--A.SLIP_ID <> A.RESET_SLIP_ID    
 						--AND	    
 						A.ACC_CODE = B.ACC_CODE
 						AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ    
 						AND A.KEEP_DT IS NOT NULL 
 					GROUP BY 
 						A.RESET_SLIP_ID, 
 						A.RESET_SLIP_IDSEQ 
 				) B1,   
   				( 
 					SELECT 
 						A.RESET_SLIP_ID, 
 						A.RESET_SLIP_IDSEQ, 
 						NVL(SUM(A.DB_AMT),0) DB_AMT, 
 						NVL(SUM(A.CR_AMT),0) CR_AMT 
 					FROM 
 						T_ACC_SLIP_BODY1 A,
						(  
		  					SELECT                         
		  						DISTINCT B.ACC_CODE  
		  					FROM  
		  						T_ACC_CODE_CHILD A,  
		  						T_ACC_CODE B  
		  					WHERE  
		  						B.FUND_INPUT_CLS = 'T'  
		  						AND A.CHILD_ACC_CODE = B.ACC_CODE  
		  						AND A.PARENT_ACC_CODE LIKE  :ACC_CODE   || '%'  
		  					UNION  
		  					SELECT  
		  						B.ACC_CODE  
		  					FROM  
		  						T_ACC_CODE B  
		  					WHERE  
		  						B.FUND_INPUT_CLS = 'T'  
		  						AND B.ACC_CODE LIKE   :ACC_CODE   || '%'  
		  				) B
 					WHERE   
 						--A.SLIP_ID <> A.RESET_SLIP_ID    
 						--AND
						A.ACC_CODE = B.ACC_CODE
 						AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ    
 						AND A.KEEP_DT IS NULL 
 					GROUP BY 
 						A.RESET_SLIP_ID, 
 						A.RESET_SLIP_IDSEQ 
 				) B2,   
   				T_CUST_CODE C,   
   				T_ACC_CODE D,  
  				(  
  					SELECT                         
  						DISTINCT B.ACC_CODE  
  					FROM  
  						T_ACC_CODE_CHILD A,  
  						T_ACC_CODE B  
  					WHERE  
  						B.FUND_INPUT_CLS = 'T'  
  						AND A.CHILD_ACC_CODE = B.ACC_CODE  
  						AND A.PARENT_ACC_CODE LIKE   :ACC_CODE   || '%'  
  					UNION  
  					SELECT  
  						B.ACC_CODE  
  					FROM  
  						T_ACC_CODE B  
  					WHERE  
  						B.FUND_INPUT_CLS = 'T'  
  						AND B.ACC_CODE LIKE   :ACC_CODE   || '%'  
  				) E  
   			WHERE   
   				A.SLIP_ID = A.RESET_SLIP_ID    
   				AND	A.SLIP_IDSEQ = A.RESET_SLIP_IDSEQ    
   				AND	A.SLIP_ID = B1.RESET_SLIP_ID (+) 
   				AND	A.SLIP_IDSEQ = B1.RESET_SLIP_IDSEQ (+)   
   				AND	A.SLIP_ID = B2.RESET_SLIP_ID (+) 
   				AND	A.SLIP_IDSEQ = B2.RESET_SLIP_IDSEQ (+)   
   				AND	A.CUST_SEQ = C.CUST_SEQ    
   				AND	A.ACC_CODE = D.ACC_CODE   
   				AND A.KEEP_DT IS NOT NULL   
   				AND	A.COMP_CODE LIKE   :COMP_CODE     || '%'   
   				AND	A.DEPT_CODE LIKE   :DEPT_CODE     || '%'   
   				AND	A.MAKE_DT BETWEEN F_T_Stringtodate(   :DT_F   ) AND F_T_Stringtodate(   :DT_T   )   
   				--AND	A.ACC_CODE LIKE  ACC_CODE   || '%'    
  				AND	A.ACC_CODE = E.ACC_CODE   
   				AND	C.CUST_CODE LIKE    :CUST_CODE     || '%'   
   				AND D.Acc_REMAIN_MNG = 'T' 
   		) X	  
	-- 미반제  
 	WHERE 
 		 X.SET_AMT - X.RESET_AMT > 0    
  	GROUP BY GROUPING SETS  
  	(  
  		(  
  			X.ACC_CODE,  
  			X.COMP_CODE,  
  			X.DEPT_CODE,  
  			X.CUST_SEQ,  
  	 		X.SLIP_ID ,    
  	 		X.SLIP_IDSEQ  
  		),  
  		(  
  			X.ACC_CODE,  
  			X.COMP_CODE,  
  			X.DEPT_CODE,  
  			X.CUST_SEQ  
  		),  
  		(  
  			X.ACC_CODE,  
  			X.COMP_CODE,  
  			X.DEPT_CODE  
  		),  
  		(  
  			X.ACC_CODE,  
  			X.COMP_CODE  
  		),  
  		(  
  			X.ACC_CODE  
  		),  
  		(  
  		)  
  	)  
   ) A,   
  T_ACC_SLIP_HEAD B1,    
  T_ACC_SLIP_BODY1 B2,    
  T_ACC_SLIP_BODY2 B3,    
  (    
  	SELECT    
  		a.CODE_LIST_ID AS CODE,    
  		a.CODE_LIST_NAME AS NAME    
  	FROM  				 		    
  		V_T_CODE_LIST a    
  	WHERE    
  		a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION'    
  ) C,  
  T_ACC_CODE D,    
  T_COMPANY E,   
  T_DEPT_CODE F,   
  T_CUST_CODE G  
  WHERE    
  	A.SLIP_ID = B1.SLIP_ID(+)    
  	AND	A.SLIP_ID = B2.SLIP_ID(+)    
  	AND	A.SLIP_IDSEQ = B2.SLIP_IDSEQ(+)  
  	AND	A.SLIP_ID = B3.SLIP_ID(+)    
  	AND	A.SLIP_IDSEQ = B3.SLIP_IDSEQ(+)  
  	AND	A.ACC_CODE = D.ACC_CODE(+)  
  	AND	D.ACC_REMAIN_POSITION = C.CODE(+)  
  	AND	A.COMP_CODE = E.COMP_CODE(+)  
  	AND	A.DEPT_CODE = F.DEPT_CODE(+)  
  	AND	A.CUST_SEQ = G.CUST_SEQ(+)  
  ORDER BY  
  	A.ACC_CODE,  
  	A.COMP_CODE,  
  	A.DEPT_CODE,  
  	A.CUST_SEQ,  
  	A.SLIP_ID ,    
  	A.SLIP_IDSEQ
	
	
	
	
SELECT
   	d.ACC_CODE ,
   	d.ACC_NAME ,
   	d.ACC_REMAIN_POSITION ,
   	C.NAME ACC_REMAIN_POSITION_NAME ,
   	e.COMP_CODE,
   	e.COMPANY_NAME COMP_NAME,
   	f.DEPT_CODE,
   	f.DEPT_NAME,
   	g.CUST_SEQ ,
   	g.CUST_CODE ,
   	g.CUST_NAME ,
   	a.SLIP_ID ,
   	a.SLIP_IDSEQ ,
   	A.SET_AMT,
   	A.RESET_AMT,
   	A.NOT_RESET_AMT,
   	A.SET_AMT - A.RESET_AMT REMAIN_AMT,
   	b1.MAKE_SLIPNO||'-'||b2.MAKE_SLIPLINE MAKE_SLIPNOLINE,
   	b3.SUMMARY1||' '||b3.SUMMARY2 SUMMARY,
  	CASE
  		WHEN A.SLIP_ID IS NOT NULL THEN ' '||F_T_Datetostring(b1.MAKE_DT)||' '
  		WHEN A.CUST_SEQ  IS NOT NULL THEN '거래처 합계'
  		WHEN A.DEPT_CODE  IS NOT NULL THEN '부서 합계'
  		WHEN A.COMP_CODE  IS NOT NULL THEN '사업장 합계'
  		WHEN A.ACC_CODE  IS NOT NULL THEN '계정 합계'
  		ELSE '전체 합계'
  	END MAKE_DT_P,
   	-- 전표조회 인자
   	b1.MAKE_COMP_CODE ,
   	F_T_Datetostring(b1.MAKE_DT) MAKE_DT,
   	b1.MAKE_SEQ ,
   	b1.SLIP_KIND_TAG,
  	CASE
  		WHEN A.SLIP_ID IS NOT NULL THEN 'A'
  		WHEN A.CUST_SEQ  IS NOT NULL THEN 'B'
  		WHEN A.DEPT_CODE  IS NOT NULL THEN 'C'
  		WHEN A.COMP_CODE  IS NOT NULL THEN 'D'
  		WHEN A.ACC_CODE  IS NOT NULL THEN 'E'
  		ELSE 'F'
  	END ROW_TYPE,
  	CASE
  		WHEN A.SLIP_ID IS NOT NULL THEN '#FFFFFF'
  		WHEN A.CUST_SEQ  IS NOT NULL THEN '#FFFFFF'
  		WHEN A.DEPT_CODE  IS NOT NULL THEN '#EFEEFF'
  		WHEN A.COMP_CODE  IS NOT NULL THEN '#D1ECC8'
  		WHEN A.ACC_CODE  IS NOT NULL THEN '#D3D3D3'
  		ELSE '#BFBEFF'
  	END ROW_COLOR
   FROM
   (
	    SELECT
	  		X.ACC_CODE,
	  		X.COMP_CODE,
	  		X.DEPT_CODE,
	  		X.CUST_SEQ,
	   		X.SLIP_ID ,
	   		X.SLIP_IDSEQ,
	   		SUM(X.SET_AMT) SET_AMT,
	   		SUM(X.RESET_AMT) RESET_AMT,
	   		SUM(X.NOT_RESET_AMT) NOT_RESET_AMT
	   	FROM
   		(
			Select
				a.ACC_CODE,
				a.COMP_CODE,
				a.DEPT_CODE,
				a.CUST_SEQ,
				a.SLIP_ID,
				a.SLIP_IDSEQ,
				a.SET_AMT,
				a.RESET_AMT,
				a.N_RESET_AMT NOT_RESET_AMT
			From	t_acc_slip_body1_t a,
					t_cust_code b
			Where	a.SET_TAG = 'T'
			And		a.acc_code in (
						select
								x.child_acc_code
							FROM
								T_ACC_CODE_CHILD2 x
							WHERE	x.PARENT_ACC_CODE =  :ACC_CODE)
			And		a.RESET_N_COMPL_TAG = 'T'
			AND		A.KEEP_DT IS NOT NULL
			AND		A.COMP_CODE LIKE   :COMP_CODE     || '%'
			AND		A.DEPT_CODE LIKE   :DEPT_CODE     || '%'
			AND		A.MAKE_DT BETWEEN F_T_Stringtodate(   :DT_F   ) AND F_T_Stringtodate(   :DT_T   )
			And		a.CUST_SEQ = b.CUST_SEQ
			And		b.CUST_CODE like :CUST_CODE || '%'
   		) X
	-- 미반제
 	WHERE
 		 X.SET_AMT - X.RESET_AMT > 0
  	GROUP BY GROUPING SETS
  	(
  		(
  			X.ACC_CODE,
  			X.COMP_CODE,
  			X.DEPT_CODE,
  			X.CUST_SEQ,
  	 		X.SLIP_ID ,
  	 		X.SLIP_IDSEQ
  		),
  		(
  			X.ACC_CODE,
  			X.COMP_CODE,
  			X.DEPT_CODE,
  			X.CUST_SEQ
  		),
  		(
  			X.ACC_CODE,
  			X.COMP_CODE,
  			X.DEPT_CODE
  		),
  		(
  			X.ACC_CODE,
  			X.COMP_CODE
  		),
  		(
  			X.ACC_CODE
  		),
  		(
  		)
  	)
   ) A,
  T_ACC_SLIP_HEAD B1,
  T_ACC_SLIP_BODY1 B2,
  T_ACC_SLIP_BODY2 B3,
  (
  	SELECT
  		a.CODE_LIST_ID AS CODE,
  		a.CODE_LIST_NAME AS NAME
  	FROM
  		V_T_CODE_LIST a
  	WHERE
  		a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION'
  ) C,
  T_ACC_CODE D,
  T_COMPANY E,
  T_DEPT_CODE F,
  T_CUST_CODE G
  WHERE
  	A.SLIP_ID = B1.SLIP_ID(+)
  	AND	A.SLIP_ID = B2.SLIP_ID(+)
  	AND	A.SLIP_IDSEQ = B2.SLIP_IDSEQ(+)
  	AND	A.SLIP_ID = B3.SLIP_ID(+)
  	AND	A.SLIP_IDSEQ = B3.SLIP_IDSEQ(+)
  	AND	A.ACC_CODE = D.ACC_CODE(+)
  	AND	D.ACC_REMAIN_POSITION = C.CODE(+)
  	AND	A.COMP_CODE = E.COMP_CODE(+)
  	AND	A.DEPT_CODE = F.DEPT_CODE(+)
  	AND	A.CUST_SEQ = G.CUST_SEQ(+)
  ORDER BY
  	A.ACC_CODE,
  	A.COMP_CODE,
  	A.DEPT_CODE,
  	A.CUST_SEQ,
  	A.SLIP_ID ,
  	A.SLIP_IDSEQ




Select
	*
From	t_acc_slip_body1_t a
Where	a.SET_TAG = 'T'
And		a.acc_code in (
			select
					x.child_acc_code
				FROM
					T_ACC_CODE_CHILD2 x
				WHERE	x.PARENT_ACC_CODE =  :ACC_CODE)
And		a.RESET_N_COMPL_TAG = 'T'
AND		A.KEEP_DT IS NOT NULL
AND		A.COMP_CODE LIKE   :COMP_CODE     || '%'
AND		A.DEPT_CODE LIKE   :DEPT_CODE     || '%'
AND		A.MAKE_DT BETWEEN F_T_Stringtodate(   :DT_F   ) AND F_T_Stringtodate(   :DT_T   )
/

Select
	*
From	t_acc_slip_body1_t a
Where	a.SET_TAG = 'T'
And		a.acc_code in (
			select
					x.child_acc_code
				FROM
					T_ACC_CODE_CHILD2 x
				WHERE	x.PARENT_ACC_CODE =  :ACC_CODE)
And		a.R_CMPL_TAG = 'T'
AND		A.KEEP_DT IS NOT NULL
AND		A.COMP_CODE LIKE   :COMP_CODE     || '%'
AND		A.DEPT_CODE LIKE   :DEPT_CODE     || '%'
AND		A.MAKE_DT BETWEEN F_T_Stringtodate(   :DT_F   ) AND F_T_Stringtodate(   :DT_T   )
/
