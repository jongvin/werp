CREATE OR REPLACE FUNCTION F_T_Acc_Budg_Jan_Amt
(
	Ar_COMP_CODE			VARCHAR2,
	Ar_DEPT_CODE			VARCHAR2,
	Ar_ACC_CODE				VARCHAR2,
	Ar_BUDG_YM				VARCHAR2
)
RETURN NUMBER
IS
		ln_JAN_AMT			NUMBER;
BEGIN
	
	SELECT
		NVL(SUM(A.JAN_AMT),0)
	INTO ln_JAN_AMT
	FROM
	(
		SELECT 
			A.COMP_CODE,
			A.CLSE_ACC_ID,
			A.CHK_DEPT_CODE,
			--A.DEPT_CODE,
			A.CTL_BUDG_CODE_NO,
			--A.BUDG_CODE_NO,
			--A.ACC_CODE,
			--A.ACC_NAME,
			A.BUDG_YM,
			(NVL(A.PRE_REQ_AMT,0)) PRE_REQ_AMT,
			(NVL(A.PRE_ASSIGN_AMT,0)) PRE_ASSIGN_AMT,
			(NVL(A.PRE_NOT_SIL_AMT,0)) PRE_NOT_SIL_AMT,
			(NVL(A.PRE_SIL_AMT,0)) PRE_SIL_AMT,
			(NVL(A.PRE_ASSIGN_AMT,0) - NVL(A.PRE_SIL_AMT,0)) PRE_JAN_AMT,
			(NVL(A.REQ_AMT,0)) REQ_AMT,
			(NVL(A.ASSIGN_AMT,0)) ASSIGN_AMT,
			(NVL(A.NOT_SIL_AMT,0)) NOT_SIL_AMT,
			(NVL(A.SIL_AMT,0)) SIL_AMT,
			(NVL(A.PRE_ASSIGN_AMT,0) - NVL(A.PRE_SIL_AMT,0) + NVL(A.ASSIGN_AMT,0) - NVL(A.SIL_AMT,0)) JAN_AMT	
		FROM
		(
			SELECT
				A.COMP_CODE,
				A.CLSE_ACC_ID,
				A.CHK_DEPT_CODE,
				--A.DEPT_CODE,
				A.CTL_BUDG_CODE_NO,
				--A.BUDG_CODE_NO,
				--A.ACC_CODE,
				AR_BUDG_YM BUDG_YM,
				SUM(
					CASE
						WHEN (A.BUDG_YM < F_T_Stringtodate(AR_BUDG_YM)) THEN BUDG_MONTH_REQ_AMT
					END
				) PRE_REQ_AMT,
				SUM(
					CASE
						WHEN (A.BUDG_YM < F_T_Stringtodate(AR_BUDG_YM)) THEN BUDG_MONTH_ASSIGN_AMT
					END
				) PRE_ASSIGN_AMT,
				SUM(
					CASE
						WHEN (A.BUDG_YM < F_T_Stringtodate(AR_BUDG_YM)) THEN NVL(A.NOT_SIL_AMT,0)
					END
				) PRE_NOT_SIL_AMT,
				SUM(
					CASE
						WHEN (A.BUDG_YM < F_T_Stringtodate(AR_BUDG_YM)) THEN NVL(A.SIL_AMT,0)
					END
				) PRE_SIL_AMT,
				SUM(
					CASE
						WHEN (A.BUDG_YM = F_T_Stringtodate(AR_BUDG_YM)) THEN A.BUDG_MONTH_REQ_AMT
					END
				) REQ_AMT,
				SUM(
					CASE
						WHEN (A.BUDG_YM = F_T_Stringtodate(AR_BUDG_YM)) THEN A.BUDG_MONTH_ASSIGN_AMT
					END
				) ASSIGN_AMT,
				SUM(
					CASE
						WHEN (A.BUDG_YM = F_T_Stringtodate(AR_BUDG_YM)) THEN NVL(A.NOT_SIL_AMT,0)
					END
				) NOT_SIL_AMT,
				SUM(
					CASE
						WHEN (A.BUDG_YM = F_T_Stringtodate(AR_BUDG_YM)) THEN NVL(A.SIL_AMT,0)
					END
				) SIL_AMT
			FROM
			(
		 	 	SELECT 
		 			A.COMP_CODE, 
		 			A.CLSE_ACC_ID, 
		 			A.CHK_DEPT_CODE, 
		 			--A.DEPT_CODE, 
		 			A.CTL_BUDG_CODE_NO, 
		 			A.BUDG_CODE_NO, 
		 			--A.ACC_CODE, 
		 			A.BUDG_YM, 
		 			A.BUDG_MONTH_REQ_AMT, 
		 			A.BUDG_MONTH_ASSIGN_AMT, 
		 			SUM(DECODE(A.KEEP_DT,NULL,A.SIL_AMT,0)) NOT_SIL_AMT, 
		 			SUM(DECODE(A.KEEP_DT,NULL,0,A.SIL_AMT)) SIL_AMT 
		 		FROM 
		 		( 
		 			SELECT 
		 				A.COMP_CODE, 
		 				A.CLSE_ACC_ID, 
		 				A.CHK_DEPT_CODE, 
		 				--A.DEPT_CODE, 
		 				A.CTL_BUDG_CODE_NO, 
		 				A.BUDG_CODE_NO, 
		 				B.ACC_CODE, 
		 				A.BUDG_YM, 
		 				A.BUDG_MONTH_REQ_AMT, 
		 				A.BUDG_MONTH_ASSIGN_AMT, 
		 				B.KEEP_DT, 
		 				NVL(B.DB_AMT,0)+NVL(B.CR_AMT,0) SIL_AMT 
		 			FROM 
		 				( 
				 			SELECT 
				 				B.COMP_CODE, 
				 				B.CLSE_ACC_ID, 
				 				A.CHK_DEPT_CODE, 
				 				--B.DEPT_CODE, 
				 				( 
				 					SELECT 
				 						Min(BUDG_CODE_NO )
				 					FROM 
				 						(Select * From T_BUDG_CODE Where COMP_CODE =  Ar_COMP_CODE )
				 					WHERE 
				 						CONTROL_LEVEL_TAG = 'T' 
				 					START WITH BUDG_CODE_NO = B.BUDG_CODE_NO 
				 					CONNECT BY 
				 					PRIOR P_BUDG_CODE_NO = BUDG_CODE_NO 
				 				) CTL_BUDG_CODE_NO, 
				 				B.BUDG_CODE_NO, 
				 				B.BUDG_YM, 
				 				SUM(B.BUDG_MONTH_REQ_AMT) BUDG_MONTH_REQ_AMT, 
				 				SUM(B.BUDG_MONTH_ASSIGN_AMT) BUDG_MONTH_ASSIGN_AMT
				 			FROM 
				 				T_BUDG_DEPT_MAP A, 
				 				T_BUDG_MONTH_AMT B 
				 			WHERE 
				 				A.DEPT_CODE = B.DEPT_CODE 
				 				AND B.COMP_CODE =  AR_COMP_CODE 
				 				AND A.CHK_DEPT_CODE = ( 
				 					SELECT 
				 					  CHK_DEPT_CODE 
				 					FROM 
				 						T_BUDG_DEPT_MAP 
				 					WHERE 
				 						DEPT_CODE =  AR_DEPT_CODE 
				 				) 
				 				AND B.BUDG_CODE_NO IN ( 
				 					SELECT 
				 						A.BUDG_CODE_NO 
				 					FROM 
				 						(Select * From T_BUDG_CODE Where COMP_CODE =  Ar_COMP_CODE ) A 
				 					START WITH BUDG_CODE_NO = ( 
				 						SELECT 
				 							A.BUDG_CODE_NO 
				 						FROM 
				 							(Select * From T_BUDG_CODE Where COMP_CODE =  Ar_COMP_CODE ) A 
				 						WHERE 
				 							A.CONTROL_LEVEL_TAG = 'T' 
												AND A.COMP_CODE = AR_COMP_CODE 
				 						START WITH A.ACC_CODE =  AR_ACC_CODE 
				 						CONNECT BY 
				 						PRIOR A.P_BUDG_CODE_NO = A.BUDG_CODE_NO 
				 					) 
				 					CONNECT BY 
				 					PRIOR A.BUDG_CODE_NO = A.P_BUDG_CODE_NO 
				 				) 
				 				AND B.BUDG_YM BETWEEN F_T_StringToDate(SUBSTR( AR_BUDG_YM ,1,4)||'0101') AND F_T_StringToDate( AR_BUDG_YM )
							GROUP BY 
				 				B.COMP_CODE, 
				 				B.CLSE_ACC_ID, 
				 				A.CHK_DEPT_CODE, 
				 				--B.DEPT_CODE, 
				 				B.BUDG_CODE_NO, 
				 				B.BUDG_YM
		  				) A, 
		 				( 
		 					SELECT 
		 						SLIP_ID, 
		 						SLIP_IDSEQ, 
		 						MAKE_SLIPLINE, 
		 						B.BUDG_CODE_NO, 
				 				( 
				 					SELECT 
				 						Min(BUDG_CODE_NO )
				 					FROM 
				 						(Select * From T_BUDG_CODE Where COMP_CODE =  Ar_COMP_CODE ) 
				 					WHERE 
				 						CONTROL_LEVEL_TAG = 'T' 
				 					START WITH BUDG_CODE_NO = B.BUDG_CODE_NO 
				 					CONNECT BY 
				 					PRIOR P_BUDG_CODE_NO = BUDG_CODE_NO 
				 				) CTL_BUDG_CODE_NO, 
		 						A.ACC_CODE, 
		 						DB_AMT, 
		 						CR_AMT, 
		 						SUMMARY_CODE, 
		 						TAX_COMP_CODE, 
		 						A.COMP_CODE, 
		 						DEPT_CODE, 
								( 
									SELECT 
									  CHK_DEPT_CODE 
									FROM 
										T_BUDG_DEPT_MAP 
									WHERE 
										DEPT_CODE =  A.DEPT_CODE 
								) CHK_DEPT_CODE, 
		 						CLASS_CODE, 
		 						VAT_CODE, 
		 						VAT_DT, 
		 						SUPAMT, 
		 						VATAMT, 
		 						CUST_SEQ, 
		 						CUST_NAME, 
		 						BANK_CODE, 
		 						ACCNO, 
		 						RESET_SLIP_ID, 
		 						RESET_SLIP_IDSEQ, 
		 						MAKE_COMP_CODE, 
		 						MAKE_DEPT_CODE, 
		 						F_T_StringToDate(TO_CHAR(MAKE_DT, 'YYYYMM')||'01') MAKE_DT01, 
		 						MAKE_DT, 
		 						SLIP_KIND_TAG, 
		 						TRANSFER_TAG, 
		 						IGNORE_SET_RESET_TAG, 
		 						KEEP_DT 
		 					FROM 
		 					 	T_ACC_SLIP_BODY1 A, 
								( 
									SELECT 
										ACC_CODE, BUDG_CODE_NO 
									FROM 
										(Select * From T_BUDG_CODE Where COMP_CODE =  Ar_COMP_CODE ) 
									WHERE 
										COMP_CODE = AR_COMP_CODE 
		 								AND BUDG_CODE_NO IN ( 
											SELECT 
												A.BUDG_CODE_NO 
											FROM 
												(Select * From T_BUDG_CODE Where COMP_CODE =  Ar_COMP_CODE ) A 
											START WITH BUDG_CODE_NO = ( 
												SELECT 
													A.BUDG_CODE_NO 
												FROM 
													(Select * From T_BUDG_CODE Where COMP_CODE =  Ar_COMP_CODE ) A 
												WHERE 
													A.CONTROL_LEVEL_TAG = 'T' 
													AND A.COMP_CODE = AR_COMP_CODE 
												START WITH A.ACC_CODE =  AR_ACC_CODE 
												CONNECT BY 
												PRIOR A.P_BUDG_CODE_NO = A.BUDG_CODE_NO 
											) 
											CONNECT BY 
											PRIOR A.BUDG_CODE_NO = A.P_BUDG_CODE_NO 
										) 
								) B 
		 					WHERE 
		 						A.ACC_CODE = B.ACC_CODE 
		 						AND TO_CHAR(MAKE_DT, 'YYYYMM') BETWEEN SUBSTR( AR_BUDG_YM ,1,4)||'01' AND SUBSTR( AR_BUDG_YM ,1,6) 
		  				) B 
		 			WHERE 
		 				A.COMP_CODE = B.COMP_CODE(+) 
		 				AND A.CHK_DEPT_CODE = B.CHK_DEPT_CODE(+) 
		 				AND A.BUDG_CODE_NO = B.BUDG_CODE_NO(+) 
		 				AND A.BUDG_YM = B.MAKE_DT01(+) 
		 		) A 
		 		GROUP BY 
		 			A.COMP_CODE, 
		 			A.CLSE_ACC_ID, 
		 			A.CHK_DEPT_CODE, 
		 			--A.DEPT_CODE, 
		 			A.CTL_BUDG_CODE_NO, 
		 			A.BUDG_CODE_NO, 
		 			--A.ACC_CODE, 
		 			A.BUDG_YM, 
		 			A.BUDG_MONTH_REQ_AMT, 
		 			A.BUDG_MONTH_ASSIGN_AMT 
			) A
			GROUP BY
				A.COMP_CODE,
				A.CLSE_ACC_ID,
				A.CHK_DEPT_CODE,
				--A.DEPT_CODE,
				A.CTL_BUDG_CODE_NO--,
				--A.BUDG_CODE_NO,
				--A.ACC_CODE
		) A
	) A;
	
	RETURN ln_JAN_AMT;
END;
/