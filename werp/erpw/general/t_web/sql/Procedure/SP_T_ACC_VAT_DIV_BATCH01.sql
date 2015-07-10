CREATE OR REPLACE PROCEDURE Sp_T_Acc_Vat_Div_Batch01
(
	AR_COMP_CODE                             VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_CRTUSERNO                             VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_TAX_BILL_MEDIA_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_TAX_BILL_MEDIA 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-16)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
lrT_ACC_SLIP_BILL_HEAD T_ACC_SLIP_BILL_HEAD%ROWTYPE;
lnSEQ T_ACC_TAX_BILL_MEDIA.SEQ%TYPE;
lnDIV_RATIO NUMBER;
BEGIN
	DELETE T_ACC_VAT_DIV_HIST
	WHERE
	COMP_CODE = AR_COMP_CODE
	AND WORK_NO = AR_WORK_NO;
	
	--RAISE_APPLICATION_ERROR	(-20009,AR_COMP_CODE||'-'||AR_WORK_NO);
	BEGIN
		SELECT
			*
		INTO
			lrT_ACC_SLIP_BILL_HEAD
		FROM	T_ACC_SLIP_BILL_HEAD a
		WHERE	a.COMP_CODE = AR_COMP_CODE
		AND a.WORK_NO = AR_WORK_NO;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR	(-20009, '해당 세무신고기수를 찾을 수 없습니다.');
	END;
	
	FOR lrA IN
	(
		SELECT
			A.DIV_COMP_CODE, 
			A.DIV_CODE, 
			A.DIV_NAME, 
			A.CNT,
			A.SUPAMT01,
			A.SUPAMT02,
			A.SUPAMT,
			CASE
				WHEN A.SUPAMT=0 THEN 0
				ELSE A.SUPAMT02*100/A.SUPAMT
			END CUR_DIV_RATIO,
			B.FREE_RATE GONG_DIV_RATIO,
			NVL(
			(
			SELECT
				DIV_RATIO
			FROM T_ACC_VAT_DIV_HIST
			WHERE
				DIV_COMP_CODE = A.DIV_COMP_CODE
				AND DIV_CODE = A.DIV_CODE
				AND (COMP_CODE, WORK_NO) IN
				(
					SELECT
						COMP_CODE,
						WORK_NO
					FROM
					(
						SELECT 
							COMP_CODE,
							WORK_NO,
							TAX_YEAR, 
							TAX_GI, 
							TAX_CONF
						FROM  
							T_ACC_SLIP_BILL_HEAD 
						WHERE
							 COMP_CODE =  AR_COMP_CODE
							 AND APPLY_TAG = 'T'
							 AND TAX_YEAR||TAX_GI||TAX_CONF <
							(
								SELECT 
									TAX_YEAR||TAX_GI||TAX_CONF
								FROM  
									T_ACC_SLIP_BILL_HEAD 
								WHERE  
									COMP_CODE =  AR_COMP_CODE 
									AND WORK_NO = AR_WORK_NO
							)
						ORDER BY
							COMP_CODE,
						 	TAX_YEAR DESC, 
							TAX_GI DESC, 
							TAX_CONF DESC,
							WORK_NO DESC
					)
					WHERE
						 ROWNUM=1
				)
			), 0) PRE_DIV_RATIO
		FROM
		(
		 	-- 현장안분비율
			SELECT
				A.DIV_COMP_CODE, 
				A.DIV_CODE, 
				A.DIV_NAME, 
				COUNT(B.RCPTBILL_CLS) CNT,
				SUM(DECODE( B.RCPTBILL_CLS, '01', NVL(B.SUPAMT, 0), 0)) SUPAMT01,
				SUM(DECODE( B.RCPTBILL_CLS, '02', NVL(B.SUPAMT, 0), 0)) SUPAMT02,
				SUM(DECODE( B.RCPTBILL_CLS, '01', NVL(B.SUPAMT, 0), '02', NVL(B.SUPAMT, 0), 0)) SUPAMT
			FROM
			(
				SELECT 
				 	A.DIV_COMP_CODE, 
				 	A.DIV_CODE, 
				 	C.DIV_NAME, 
				 	A.DIV_DEPT_CODE, 
				 	B.DEPT_NAME DIV_DEPT_NAME 
				 FROM 
				 	T_ACC_VAT_DIV_C_DEPT A, 
				 	T_DEPT_CODE_ORG B ,
					T_ACC_VAT_DIV_CODE C
				 WHERE 
				 	 A.DIV_DEPT_CODE = B.DEPT_CODE 
				 	 AND A.DIV_COMP_CODE = C.DIV_COMP_CODE
				 	 AND A.DIV_CODE = C.DIV_CODE
					 AND NVL(C.MAIN_TAG, ' ') <> 'T'
				 	 AND C.USE_TAG = 'T'
				 	 AND A.DIV_COMP_CODE = AR_COMP_CODE
			) A,
			(
				SELECT   
				  	A.COMP_CODE,  
				  	A.WORK_NO,  
				  	A.SEQ,  
				  	A.TAX_COMP_CODE,  
				  	C.COMPANY_NAME TAX_COMP_NAME,  
				  	F.RCPTBILL_CLS,  
				  	F.SALEBUY_CLS,  
				  	F_T_Datetostring(A.PUBL_DT) PUBL_DT,  
				  	A.VAT_CODE,  
				  	A.BOOK_NO,  
				  	A.BOOK_SEQ,  
				  	A.DEPT_CODE,  
				  	D.DEPT_NAME,  
				  	A.CUST_SEQ,  
				  	E.CUST_CODE,  
				  	E.CUST_NAME,  
				  	DECODE(F.SALEBUY_CLS, '1', A.SUPAMT) SUPAMT,  
				  	DECODE(F.SALEBUY_CLS, '1', A.VATAMT) VATAMT,  
				  	A.ANNULMENT_CLS,  
				  	A.ANNULMENT_DT,  
				  	A.OUT_CNT,  
				  	A.MISSING_TAG,  
				  	A.REMARK,  
				  	A.UDT_TAG,  
				  	A.SLIP_ID,  
				  	A.SLIP_IDSEQ,  
				  	--B.MAKE_SLIPNO||'-'||B.MAKE_SLIPLINE MAKE_SLIPNOLINE,  
				  	B.ACC_CODE  
				  	--B.ACC_NAME  
				  FROM   
				  	T_ACC_TAX_BILL_MEDIA_RPT A,  
				  	T_ACC_SLIP_BODY1 B, 
				 	T_COMPANY C, 
				 	T_DEPT_CODE_ORG D, 
				 	T_CUST_CODE E,
					T_ACC_CODE_VIEW F
				  WHERE  
				  	A.SLIP_ID = B.SLIP_ID(+)  
				  	AND A.SLIP_IDSEQ = B.SLIP_IDSEQ(+)  
				 	AND A.TAX_COMP_CODE = C.COMP_CODE(+) 
				 	AND A.DEPT_CODE = D.DEPT_CODE(+) 
				  	AND A.CUST_SEQ = E.CUST_SEQ(+) 
					AND A.ACC_CODE = F.ACC_CODE(+) 
					AND F.SALEBUY_CLS = '1'
				  	AND A.COMP_CODE =  AR_COMP_CODE
				  	AND A.WORK_NO =   AR_WORK_NO
			) B
			WHERE
				 A.DIV_COMP_CODE = B.COMP_CODE(+)
				 AND A.DIV_DEPT_CODE = B.DEPT_CODE(+)
			GROUP BY
				A.DIV_COMP_CODE, 
				A.DIV_CODE, 
				A.DIV_NAME
			UNION ALL
			-- 본사안분비율 = 회사전체
			SELECT
				A.DIV_COMP_CODE, 
				A.DIV_CODE, 
				A.DIV_NAME, 
				COUNT(B.RCPTBILL_CLS) CNT,
				SUM(DECODE( B.RCPTBILL_CLS, '01', NVL(B.SUPAMT, 0), 0)) SUPAMT01,
				SUM(DECODE( B.RCPTBILL_CLS, '02', NVL(B.SUPAMT, 0), 0)) SUPAMT02,
				SUM(DECODE( B.RCPTBILL_CLS, '01', NVL(B.SUPAMT, 0), '02', NVL(B.SUPAMT, 0), 0)) SUPAMT
			FROM
			(
				SELECT 
				 	C.DIV_COMP_CODE, 
				 	C.DIV_CODE, 
				 	C.DIV_NAME
				 FROM 
					T_ACC_VAT_DIV_CODE C
				 WHERE 
					 NVL(C.MAIN_TAG, ' ')='T'
				 	 AND C.USE_TAG='T'
				 	 AND C.DIV_COMP_CODE = AR_COMP_CODE
			) A,
			(
				SELECT   
				  	A.COMP_CODE,  
				  	A.WORK_NO,  
				  	A.SEQ,  
				  	A.TAX_COMP_CODE,  
				  	C.COMPANY_NAME TAX_COMP_NAME,  
				  	F.RCPTBILL_CLS,  
				  	F.SALEBUY_CLS,  
				  	F_T_Datetostring(A.PUBL_DT) PUBL_DT,  
				  	A.VAT_CODE,  
				  	A.BOOK_NO,  
				  	A.BOOK_SEQ,  
				  	A.DEPT_CODE,  
				  	D.DEPT_NAME,  
				  	A.CUST_SEQ,  
				  	E.CUST_CODE,  
				  	E.CUST_NAME,  
				  	DECODE(F.SALEBUY_CLS, '1', A.SUPAMT) SUPAMT,  
				  	DECODE(F.SALEBUY_CLS, '1', A.VATAMT) VATAMT,  
				  	A.ANNULMENT_CLS,  
				  	A.ANNULMENT_DT,  
				  	A.OUT_CNT,  
				  	A.MISSING_TAG,  
				  	A.REMARK,  
				  	A.UDT_TAG,  
				  	A.SLIP_ID,  
				  	A.SLIP_IDSEQ,  
				  	--B.MAKE_SLIPNO||'-'||B.MAKE_SLIPLINE MAKE_SLIPNOLINE,  
				  	B.ACC_CODE  
				  	--B.ACC_NAME  
				  FROM   
				  	T_ACC_TAX_BILL_MEDIA_RPT A,  
				  	T_ACC_SLIP_BODY1 B, 
				 	T_COMPANY C, 
				 	T_DEPT_CODE_ORG D, 
				 	T_CUST_CODE E, 
					T_ACC_CODE_VIEW F
				  WHERE  
				  	A.SLIP_ID = B.SLIP_ID(+)  
				  	AND A.SLIP_IDSEQ = B.SLIP_IDSEQ(+)  
				 	AND A.TAX_COMP_CODE = C.COMP_CODE(+) 
				 	AND A.DEPT_CODE = D.DEPT_CODE(+) 
				  	AND A.CUST_SEQ = E.CUST_SEQ(+) 
					AND A.ACC_CODE = F.ACC_CODE(+) 
					AND F.SALEBUY_CLS = '1'
				  	AND A.COMP_CODE =  AR_COMP_CODE
				  	AND A.WORK_NO =   AR_WORK_NO
			) B
			WHERE
				 A.DIV_COMP_CODE = B.COMP_CODE(+)
			--	 AND A.DIV_DEPT_CODE = B.DEPT_CODE(+)
			GROUP BY
				A.DIV_COMP_CODE, 
				A.DIV_CODE, 
				A.DIV_NAME
		) A,
		(
			SELECT
					A.DIV_COMP_CODE, 
					A.DIV_CODE,
					SUM(A.TAX_RATE)/(COUNT(*)) TAX_RATE, --과세분
					SUM(A.FREE_RATE)/(COUNT(*)) FREE_RATE --면세분
			FROM
			(
				SELECT 
					A.DIV_COMP_CODE, 
					A.DIV_CODE, 
					C.DIV_NAME, 
					A.DIV_DEPT_CODE, 
					B.DEPT_NAME DIV_DEPT_NAME ,
					D.VATTAG,
					D.TAX_RATE,
					D.FREE_RATE
				FROM 
					T_ACC_VAT_DIV_C_DEPT A, 
					T_DEPT_CODE_ORG B ,
					T_ACC_VAT_DIV_CODE C,
					Z_CODE_DEPT D
				WHERE
					A.DIV_COMP_CODE = B.COMP_CODE
					AND A.DIV_DEPT_CODE = B.DEPT_CODE 
					AND A.DIV_COMP_CODE = C.DIV_COMP_CODE
					AND A.DIV_CODE = C.DIV_CODE
					AND C.USE_TAG = 'T'
					AND A.DIV_COMP_CODE = D.COMP_CODE(+)
					AND A.DIV_DEPT_CODE = D.DEPT_CODE (+)
					AND A.DIV_COMP_CODE = AR_COMP_CODE
			) A
			GROUP BY
					A.DIV_COMP_CODE, 
					A.DIV_CODE
		) B
		WHERE
					A.DIV_COMP_CODE = B.DIV_COMP_CODE(+)
					AND A.DIV_CODE = B.DIV_CODE(+)
	)
	LOOP
		BEGIN
			--IF lrA.TAX_COMP_CODE IS NULL THEN
			--   RAISE_APPLICATION_ERROR	(-20009, '세무사업장 오류입니다.<BR><BR>전표번호 : ' || lrA.MAKE_SLIPNOLINE);
			--END IF;
			
			SELECT
				NVL(MAX(SEQ),0)+1
			INTO lnSEQ
			FROM T_ACC_VAT_DIV_HIST
			WHERE
				 COMP_CODE = AR_COMP_CODE
				 AND WORK_NO = AR_WORK_NO;
				 
			SELECT
				CASE
					WHEN lrA.CUR_DIV_RATIO = 0 THEN
						CASE
							WHEN lrA.GONG_DIV_RATIO = 0 THEN lrA.PRE_DIV_RATIO
								 
							ELSE lrA.GONG_DIV_RATIO
						END
					ELSE lrA.CUR_DIV_RATIO
				END
			INTO  lnDIV_RATIO
			FROM DUAL;
			
			Sp_T_Acc_Vat_Div_Hist_I
			(
				AR_COMP_CODE,
				AR_WORK_NO,
				lnSEQ,
				AR_CRTUSERNO,
				lrA.DIV_COMP_CODE,
				lrA.DIV_CODE,
				lnDIV_RATIO,
				lrA.CUR_DIV_RATIO,
				lrA.GONG_DIV_RATIO,
				lrA.PRE_DIV_RATIO,
				lrA.SUPAMT02,--CUR_DIV_ACC_AMT,
				lrA.SUPAMT01 --CUR_DIV_TAX_AMT
			);
		END;
	END LOOP;

END;
/
