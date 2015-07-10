CREATE OR REPLACE FUNCTION F_T_Check_Slip
(
	AR_SLIP_ID						T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
	AR_CHECK_WORK_SLIP				VARCHAR2 DEFAULT 'N',			--관련업무 입력여부를 검증할 것인지 여부
	AR_CHECK_CONFRIMED_REMAIN		VARCHAR2 DEFAULT 'Y'			--확정된 잔액만으로 잔액을 검증할 것인지 여부
)
RETURN VARCHAR2
IS
	TYPE SLIP_DETAIL_TABLE IS TABLE OF T_ACC_SLIP_BODY%ROWTYPE
		INDEX BY BINARY_INTEGER;
	TYPE ACC_CODE_TABLE IS TABLE OF T_ACC_CODE_VIEW%ROWTYPE
		INDEX BY T_ACC_CODE_VIEW.ACC_CODE%TYPE;
	ls_Msg								VARCHAR2(2000) := 'T';
	ltSLIP_DETAIL						SLIP_DETAIL_TABLE;
	ltACC_CODE							ACC_CODE_TABLE;
	lrSLIP_HEAD							T_ACC_SLIP_HEAD%ROWTYPE;
	lrSLIP_BODY							T_ACC_SLIP_BODY%ROWTYPE;
	lrT_ACC_CODE						T_ACC_CODE_VIEW%ROWTYPE;
	lrT_ACC_VAT_CODE					T_ACC_VAT_CODE%ROWTYPE;
	lrT_FIN_PAY_CHK_BILL				T_FIN_PAY_CHK_BILL%ROWTYPE;
	lrT_FIN_RECEIVE_CHK_BILL			T_FIN_RECEIVE_CHK_BILL%ROWTYPE;
	lrT_FIN_CP_BUY						T_FIN_CP_BUY%ROWTYPE;
	lrT_FIN_SECURTY						T_FIN_SECURTY%ROWTYPE;
	lrT_DEPOSIT_PAYMENT_LIST			T_DEPOSIT_PAYMENT_LIST%ROWTYPE;
	lrT_ACC_SLIP_EXPENSE_CASH			T_ACC_SLIP_EXPENSE_CASH%ROWTYPE;
	lrT_ACC_SLIP_EXPENSE_CARDS			T_ACC_SLIP_EXPENSE_CARDS%ROWTYPE;
	lrT_FIN_LOAN_REFUND_LIST  			T_FIN_LOAN_REFUND_LIST%ROWTYPE;
	lsCLSE_CLS							T_YEAR_CLOSE.CLSE_CLS%TYPE;
	lnDB_AMT							T_ACC_SLIP_BODY.DB_AMT%TYPE;
	lnCR_AMT							T_ACC_SLIP_BODY.CR_AMT%TYPE;
	
	lnSET_AMT						NUMBER;
	lnRESET_AMT					  NUMBER;
	
	ln_AccBudgAmt	NUMBER;
	ls_DeptBudgCls	T_DEPT_CODE.BUDG_CLS%TYPE;

	lsAuthCompCode T_ACC_SLIP_BODY.COMP_CODE%TYPE;
	lsAuthDeptCode T_ACC_SLIP_BODY.DEPT_CODE%TYPE;

	FUNCTION	GetSlipInfo
	RETURN VARCHAR2
	IS
	BEGIN
		RETURN 	'<br>라인번호 : '||lrSLIP_BODY.MAKE_SLIPLINE||'<br>'||
				'계정과목 : '||lrSLIP_BODY.ACC_CODE||'('||lrT_ACC_CODE.ACC_NAME||')<br>'||
				'적요 : '||lrSLIP_BODY.SUMMARY1||'<br>'||
				'차대금액 : '||TO_CHAR(lrSLIP_BODY.DB_AMT,'FM999,999,999,999,990')||' / '||TO_CHAR(lrSLIP_BODY.CR_AMT,'FM999,999,999,999,990');
	END;

	FUNCTION	GetAccCodeInfo
	(
		AR_ACC_CODE			T_ACC_CODE_VIEW.ACC_CODE%TYPE
	)
	RETURN T_ACC_CODE_VIEW%ROWTYPE
	IS
		lrRet				T_ACC_CODE_VIEW%ROWTYPE;
	BEGIN
		BEGIN
			lrRet := ltACC_CODE(AR_ACC_CODE);
			RETURN lrRet;
		EXCEPTION WHEN NO_DATA_FOUND THEN
			BEGIN
				SELECT
					*
				INTO
					lrRet
				FROM	T_ACC_CODE_VIEW
				WHERE	ACC_CODE = AR_ACC_CODE;
				ltACC_CODE(AR_ACC_CODE) := lrRet;
				RETURN lrRet;
			EXCEPTION WHEN NO_DATA_FOUND THEN
				RETURN NULL;
			END;
		END;
		RETURN NULL;
	END;
/**************************************************************************/
/* 1. 프 로 그 램 id : F_T_Check_Slip
/* 2. 유형(시나리오) : Function
/* 3. 기  능  정  의 : 전표오류 체크
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	BEGIN
		SELECT
			*
		INTO
			lrSLIP_HEAD
		FROM	T_ACC_SLIP_HEAD a
		WHERE	a.SLIP_ID = AR_SLIP_ID;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '해당 전표를 찾을 수 없습니다.';
	END;

	BEGIN
		SELECT
			*
		BULK COLLECT INTO
			ltSLIP_DETAIL
		FROM	T_ACC_SLIP_BODY a
		WHERE	a.SLIP_ID = AR_SLIP_ID
		ORDER BY
			a.MAKE_SLIPLINE,
			a.SLIP_IDSEQ;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '해당 전표의 세부내역이 존재하지 않습니다.';
	END;
	
	--전표 상단 검증------------------------------------------------------------------------------*

	--자동전표검증
	IF AR_CHECK_WORK_SLIP = 'Y' AND lrSLIP_HEAD.WORK_CODE IS NULL THEN
		RETURN '자동전표 관련업무 구분이 입력되지 않았습니다.';
	END IF;
	
	-- 출납부서 : INOUT_DEPT_CODE 
	IF lrSLIP_HEAD.INOUT_DEPT_CODE IS NULL THEN
		RETURN '출납부서가 입력되지 않았습니다.';
	END IF;
	-- 관리담당 : CHARGE_PERS
	IF lrSLIP_HEAD.CHARGE_PERS IS NULL THEN
		RETURN '관리담당이 입력되지 않았습니다.';
	END IF;
	-- 작성자 : MAKE_PERS 
	IF lrSLIP_HEAD.MAKE_PERS IS NULL THEN
		RETURN '작성자가 입력되지 않았습니다.';
	END IF;
	
	-- 작성자명 : MAKE_NAME 
	IF lrSLIP_HEAD.MAKE_NAME IS NULL THEN
		RETURN '작성자명이 입력되지 않았습니다.';
	END IF;
	
	-- 관리담당자
	IF lrSLIP_HEAD.CHARGE_PERS IS NULL THEN
		RETURN '관리담당자가 입력되지 않았습니다.';
	END IF;

	--년 마감 검증
	BEGIN
		SELECT
			CLSE_CLS
		INTO
			lsCLSE_CLS
		FROM	T_YEAR_CLOSE
		WHERE	ACCOUNT_FDT <= lrSLIP_HEAD.MAKE_DT
		AND		ACCOUNT_EDT >= lrSLIP_HEAD.MAKE_DT
		AND		COMP_CODE = lrSLIP_HEAD.MAKE_COMP_CODE;

		IF NVL(lsCLSE_CLS,'F') = 'T' THEN
			RETURN '회기가 이미 마감되었습니다.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '회기가 등록되지 않았습니다.';
	END;

	--월 마감 검증
	BEGIN
		SELECT
			CLSE_CLS
		INTO
			lsCLSE_CLS
		FROM T_MONTH_CLOSE
		WHERE
			CLSE_MONTH = TO_CHAR(lrSLIP_HEAD.MAKE_DT,'YYYYMM')
			AND COMP_CODE = lrSLIP_HEAD.MAKE_COMP_CODE;

		IF NVL(lsCLSE_CLS,'F') = 'T' THEN
			RETURN '해당 월은 이미 마감되었습니다.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '월마감이 등록되지 않았습니다.';
	END;

	--일 마감 검증
	BEGIN
		SELECT
			CLSE_CLS
		INTO
			lsCLSE_CLS
		FROM	T_DAY_CLOSE
		WHERE	CLSE_DAY = lrSLIP_HEAD.MAKE_DT
		AND		COMP_CODE = lrSLIP_HEAD.MAKE_COMP_CODE;

		IF NVL(lsCLSE_CLS,'F') = 'T' THEN
			RETURN '해당 일자는 이미 마감되었습니다.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '일마감이 등록되지 않았습니다.';
	END;

 	-- 부서 입력기간 체크
	BEGIN
		SELECT
			 CASE
			 	 WHEN (F_T_Datetostring(lrSLIP_HEAD.MAKE_DT) BETWEEN F_T_Datetostring(NVL(INPUT_DT_F, '19000101')) AND F_T_Datetostring(NVL(INPUT_DT_T, '19000101')) )
				 THEN 'F' -- 입력기간
				 ELSE 'T' -- 입력마감
			END DEPT_CLSE_CLS
		INTO
			lsCLSE_CLS
		FROM
			T_DEPT_CODE_ORG A
		WHERE
			A.COMP_CODE = lrSLIP_HEAD.MAKE_COMP_CODE
			AND DEPT_CODE = lrSLIP_HEAD.MAKE_DEPT_CODE;

		IF NVL(lsCLSE_CLS,'F') = 'T' THEN
			RETURN '부서의 입력기간이 종료되었습니다.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '부서정보가 등록되지 않았습니다.';
	END;
	
	-- 작성자의 사업장, 작성부서 권한체크...
	BEGIN
		SELECT
			a.COMP_CODE,
			a.DEPT_CODE
		INTO
			lsAuthCompCode, lsAuthDeptCode
		FROM
			(	
				SELECT 
				 	a.COMP_CODE, a.DEPT_CODE
				FROM
					T_EMPNO_AUTH_DEPT a
				WHERE	
					a.EMPNO = lrSLIP_HEAD.MAKE_PERS 
					AND 'T' = (
						SELECT
							a.DEPT_CHG_CLS
						FROM
							T_EMPNO_AUTH a
						WHERE
							a.EMPNO = lrSLIP_HEAD.MAKE_PERS
					)
				UNION
				SELECT COMP_CODE, DEPT_CODE
				FROM T_DEPT_CODE
				WHERE
					DEPT_CODE IN (
						SELECT
							DEPT_CODE
						FROM
							Z_AUTHORITY_USER 
						WHERE
							 EMPNO = lrSLIP_HEAD.MAKE_PERS 
					)
			) A
		WHERE
			a.COMP_CODE = lrSLIP_HEAD.MAKE_COMP_CODE
			AND a.DEPT_CODE = lrSLIP_HEAD.MAKE_DEPT_CODE;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '작성자는 현 사업장/부서의 전표등록 권한이 없습니다.';
	END;

	--전표 하단 검증------------------------------------------------------------------------------*
	BEGIN
		SELECT
			SUM(DB_AMT),
			SUM(CR_AMT)
		INTO
			lnDB_AMT,
			lnCR_AMT
		FROM	T_ACC_SLIP_BODY
		WHERE	SLIP_ID = AR_SLIP_ID;

		IF lnDB_AMT <> lnCR_AMT THEN
			RETURN '차대금액이	일치하지 않습니다.'||CHR(10)
			||'차:대'||TO_CHAR(lnDB_AMT,'FM999,999,999,999,999,999,999,990')||':'||TO_CHAR(lnCR_AMT,'FM999,999,999,999,999,999,999,990')||CHR(10)
			||'저장할수 없습니다.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '전표 세부내역이 등록되지 않았습니다.';
	END;

	FOR liI IN 	ltSLIP_DETAIL.First..ltSLIP_DETAIL.Last LOOP
		lrSLIP_BODY := ltSLIP_DETAIL(liI);
		lrT_ACC_CODE := GetAccCodeInfo(lrSLIP_BODY.ACC_CODE);
		--계정과목 검증
		--입력계정여부
		IF NVL(lrT_ACC_CODE.FUND_INPUT_CLS,'F') = 'F' THEN
			RETURN '해당 전표 라인이 입력가능계정이 아닙니다.'||GetSlipInfo;
		END IF;

		-- 계산서구분이 입력되고, 부가세 없음일때만 차/대 모두 '0' 이것 허용
		IF  NOT ( lrT_ACC_CODE.RCPTBILL_CLS IS NOT NULL AND NVL(lrT_ACC_CODE.VATOCCUR_CLS, 'F') = 'F' ) THEN
			IF NVL(lrSLIP_BODY.DB_AMT,0)+NVL(lrSLIP_BODY.CR_AMT,0) = 0 THEN
				RETURN '차대금액이 모두 0입니다.'||GetSlipInfo;
			END IF;
		END IF;

		--적요코드관리
		IF NVL(lrT_ACC_CODE.SUMMARY_CLS,'F') = 'T' AND lrSLIP_BODY.SUMMARY_CODE IS NULL THEN
			RETURN '해당 전표라인에 적요코드가 입력되지 않았습니다.'||GetSlipInfo;
		END IF;

		--적요1 검증
		IF lrSLIP_BODY.SUMMARY1 IS NULL THEN
			RETURN '해당 전표라인에 적요1이 입력되지 않았습니다.'||GetSlipInfo;
		END IF;

		--귀속사업장 검증
		IF lrSLIP_BODY.COMP_CODE IS NULL THEN
			RETURN '해당 전표라인에 귀속사업장이 입력되지 않았습니다.'||GetSlipInfo;
		END IF;
		
		--귀속부서 검증
		IF lrSLIP_BODY.DEPT_CODE IS NULL THEN
			RETURN '해당 전표라인에 귀속부서가 입력되지 않았습니다.'||GetSlipInfo;
		END IF;
		
		--세무사업장 검증
		IF lrSLIP_BODY.TAX_COMP_CODE IS NULL THEN
			RETURN '해당 전표라인에 세무사업장이 입력되지 않았습니다.'||GetSlipInfo;
		END IF;

		--부문코드 검증
		IF lrSLIP_BODY.CLASS_CODE IS NULL THEN
			RETURN '해당 전표라인에 부문코드가 입력되지 않았습니다.'||GetSlipInfo;
		END IF;

		--증빙코드,증빙일자,공급가액,부가세 검증
		--부가세 코드는 폼이다.
		/*
		IF lrSLIP_BODY.VAT_CODE IS NOT NULL THEN
			--증빙코드
			BEGIN
   				SELECT
					*
				INTO
					lrT_ACC_VAT_CODE
				FROM	T_ACC_VAT_CODE a
				WHERE	a.VAT_CODE = lrSLIP_BODY.VAT_CODE;
   			EXCEPTION WHEN NO_DATA_FOUND THEN
   				RETURN '부가세코드가 등록되어 있지 않습니다.'||GetSlipInfo;
   			END;

			--증빙일자
			IF  lrSLIP_BODY.VAT_DT IS NULL THEN
				RETURN '해당 전표라인에 증빙일자가 입력되지 않았습니다.'||GetSlipInfo;
			END IF;

			--공급가액
			IF  NVL(lrSLIP_BODY.SUPAMT,0) = 0 THEN
				RETURN '해당 전표라인에 공급가액이 입력되지 않았습니다.'||GetSlipInfo;
			END IF;

			--부가세액
			IF NVL(lrT_ACC_VAT_CODE.VATOCCUR_CLS, 'F') = 'T' AND NVL(lrSLIP_BODY.VATAMT,0) = 0 THEN
				RETURN '해당 전표라인에 부가세가 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
		END IF;
		*/
		IF lrSLIP_BODY.IGNORE_SET_RESET_TAG<>'T' THEN
			
			IF lrT_ACC_CODE.RCPTBILL_CLS IS NOT NULL THEN
				--증빙일자
				IF  lrSLIP_BODY.VAT_DT IS NULL THEN
					RETURN '해당 전표라인에 증빙일자가 입력되지 않았습니다.'||GetSlipInfo;
				END IF;
	
				--공급가액
				IF  NVL(lrSLIP_BODY.SUPAMT,0) = 0 THEN
					RETURN '해당 전표라인에 공급가액이 입력되지 않았습니다.'||GetSlipInfo;
				END IF;
	
				--부가세액
				IF NVL(lrT_ACC_CODE.VATOCCUR_CLS, 'F') = 'T' AND NVL(lrSLIP_BODY.VATAMT,0) = 0 THEN
					RETURN '해당 전표라인에 부가세가 입력되지 않았습니다.'||GetSlipInfo;
				END IF;
				IF NOT ( NVL(lrT_ACC_CODE.CUST_CODE_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CUST_CODE_MNG_TG,'F') = 'T' ) THEN
					RETURN '해당 계정설정이 거래처코드 입력필수로 지정되어있지 않습니다. 필수입력으로 수정하신 후 다시입력하시기 바랍니다.'||GetSlipInfo;
				END IF;
			END IF;
	
			--거래처코드검증
			IF NVL(lrT_ACC_CODE.CUST_CODE_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CUST_CODE_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CUST_SEQ IS NULL THEN
				RETURN '해당 전표라인에 거래처코드가 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			IF NVL(lrT_ACC_CODE.CUST_CODE_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CUST_CODE_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CUST_NAME IS NULL THEN
				RETURN '해당 전표라인에 거래처명이 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--거래처명검증
			IF NVL(lrT_ACC_CODE.CUST_NAME_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CUST_NAME_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CUST_NAME IS NULL THEN
				RETURN '해당 전표라인에 거래처명이 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--잔액관리 검증 
			IF NVL(lrT_ACC_CODE.ACC_REMAIN_MNG,'F') = 'T' THEN
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--잔액관리 설정
					IF ( NVL(lrSLIP_BODY.RESET_SLIP_ID, 0)=0 OR NVL(lrSLIP_BODY.RESET_SLIP_IDSEQ, 0)=0 ) THEN
						RETURN '잔액관리 설정전표번호가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					IF (
						NVL(lrSLIP_BODY.RESET_SLIP_ID, 0)<>NVL(lrSLIP_BODY.SLIP_ID, 0)
						OR
						NVL(lrSLIP_BODY.RESET_SLIP_IDSEQ, 0)<>NVL(lrSLIP_BODY.SLIP_IDSEQ, 0)
					) THEN
						RETURN '잔액관리설정 전표번호가 잘못입력되었습니다.'||GetSlipInfo;
					END IF;
				ELSE
					--잔액관리 반제
					IF ( NVL(lrSLIP_BODY.RESET_SLIP_ID, 0)=0 OR NVL(lrSLIP_BODY.RESET_SLIP_IDSEQ, 0)=0 ) THEN
						RETURN '잔액관리 반제전표번호가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					
					--설정금액 < 반제금액 체크
					SELECT
						--A.SLIP_ID,
						--A.SLIP_IDSEQ,
						(
							SELECT
								NVL(SUM(NVL(DB_AMT,0) + NVL(CR_AMT,0)), 0)
							FROM
								T_ACC_SLIP_BODY
							WHERE
								SLIP_ID=A.RESET_SLIP_ID
								AND SLIP_IDSEQ = A.RESET_SLIP_IDSEQ
						) SET_AMT,
						(
							SELECT
								NVL(SUM(DECODE(Bi.ACC_REMAIN_POSITION, 'D', 1, -1)* Ai.DB_AMT + DECODE(Bi.ACC_REMAIN_POSITION, 'C', 1, -1)*Ai.CR_AMT),0)
							FROM
								T_ACC_SLIP_BODY Ai,
								T_ACC_CODE Bi
							WHERE
								Ai.ACC_CODE = Bi.ACC_CODE
								AND Ai.SLIP_ID <> A.RESET_SLIP_ID
								AND Ai.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ
								AND Ai.RESET_SLIP_ID=A.RESET_SLIP_ID
								AND Ai.RESET_SLIP_IDSEQ = A.RESET_SLIP_IDSEQ
						) RESET_AMT
					INTO
						lnSET_AMT, lnRESET_AMT
					FROM
						T_ACC_SLIP_BODY A
					WHERE
						A.SLIP_ID=lrSLIP_BODY.RESET_SLIP_ID
						AND A.SLIP_IDSEQ = lrSLIP_BODY.RESET_SLIP_IDSEQ;
						
					IF ( lnSET_AMT + lnRESET_AMT < 0 ) THEN
						RETURN '반제금액이 잔액을 초과했습니다.'||GetSlipInfo;
					END IF;
		
				END IF;
			ELSE
				--잔액관리 계정이 아닌것.
				IF ( NVL(lrSLIP_BODY.RESET_SLIP_ID, 0)<>0 OR NVL(lrSLIP_BODY.RESET_SLIP_IDSEQ, 0)<>0 ) THEN
					RETURN '잔액관리 계정이 아닌 항목에 설정/반제전표번호가 입력습니다.'||GetSlipInfo;
				END IF;
			END IF;
			
			--예산통제 검증
			IF lrT_ACC_CODE.BUDG_EXEC_CLS = 'T' THEN
				SELECT
					-- 잔액
					F_T_Acc_Budg_Jan_Amt(lrSLIP_BODY.COMP_CODE,lrSLIP_BODY.DEPT_CODE,lrSLIP_BODY.ACC_CODE,TO_CHAR(lrSLIP_BODY.MAKE_DT, 'YYYYMM')||'01'),
					-- 귀속부서별 잔액체크 여부..
					(
						SELECT
							BUDG_CLS 
						FROM
							T_DEPT_CODE
						WHERE
							COMP_CODE = lrSLIP_BODY.COMP_CODE
							AND DEPT_CODE = lrSLIP_BODY.DEPT_CODE
					)				
				INTO ln_AccBudgAmt, ls_DeptBudgCls
				FROM
					DUAL;
					
				IF (ls_DeptBudgCls = 'T' ) AND ( NVL(lrSLIP_BODY.DB_AMT,0) + NVL(lrSLIP_BODY.CR_AMT,0) > ln_AccBudgAmt ) THEN
				   	ls_Msg := '예산 잔액을 초과했습니다. 잔액:'||To_Char(ln_AccBudgAmt,'FM999,999,999,999,999,999,999')||' 발행금액 : '||To_Char( NVL(lrSLIP_BODY.DB_AMT,0) + NVL(lrSLIP_BODY.CR_AMT,0),'FM999,999,999,999,999,999,999')||GetSlipInfo;
					RAISE_APPLICATION_ERROR	(-20009, '전표생성오류!!!<br>'|| REPLACE(ls_Msg,'ORA-',CHR(10)||'ORACLE Internal Error - '));
				END IF;
			END IF;
	
			--금융기관코드 검증
			IF NVL(lrT_ACC_CODE.BANK_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.BANK_MNG_TG,'F') = 'T' AND lrSLIP_BODY.BANK_CODE IS NULL THEN
				RETURN '해당 전표라인에 은행코드가 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--계좌번호 검증
			IF NVL(lrT_ACC_CODE.ACCNO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.ACCNO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.ACCNO IS NULL THEN
				RETURN '해당 전표라인에 계좌번호가 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
			
			--카드번호 검증
			IF NVL(lrT_ACC_CODE.CARD_SEQ_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CARD_SEQ_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CARD_SEQ IS NULL THEN
				RETURN '해당 전표라인에 카드번호가 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--당좌수표검증
			IF NVL(lrT_ACC_CODE.CHK_NO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CHK_NO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CHK_NO IS NULL THEN
				RETURN '해당 전표라인에 수표번호가 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			IF lrSLIP_BODY.CHK_NO IS NOT NULL THEN
				BEGIN
	   				SELECT
						*
					INTO
						lrT_FIN_PAY_CHK_BILL
					FROM	T_FIN_PAY_CHK_BILL a
					WHERE	a.CHK_BILL_NO = lrSLIP_BODY.CHK_NO;
	   			EXCEPTION WHEN NO_DATA_FOUND THEN
	   				RETURN '수표번호가 등록되어 있지 않습니다.'||GetSlipInfo;
	   			END;
	
	   			--발행일자 검증
				IF lrT_FIN_PAY_CHK_BILL.PUBL_DT IS NULL THEN
					RETURN '해당 전표라인에 당좌발행일자가 입력되지 않았습니다.'||GetSlipInfo;
				END IF;
			END IF;
	
			--지급어음검증
			IF NVL(lrT_ACC_CODE.BILL_NO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.BILL_NO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.BILL_NO IS NULL THEN
				RETURN '해당 전표라인에 지급어음번호가 입력되지 않았습니다.'||GetSlipInfo;
			ELSIF NVL(lrT_ACC_CODE.BILL_NO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.BILL_NO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.BILL_NO IS NOT NULL THEN
				BEGIN
					SELECT
						*
					INTO
						lrT_FIN_PAY_CHK_BILL
					FROM	T_FIN_PAY_CHK_BILL a
					WHERE	a.CHK_BILL_NO = lrSLIP_BODY.BILL_NO;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RETURN '지급어음번호가 등록되지 않았습니다.'||GetSlipInfo;
				END;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN		--지급어음 설정
	
					--전표번호 검증
					IF NVL(lrT_FIN_PAY_CHK_BILL.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_PAY_CHK_BILL.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '지급어음 전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
					--발행일자 검증
	   				IF lrT_FIN_PAY_CHK_BILL.PUBL_DT IS NULL THEN
	   					RETURN '지급어음의 발행일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--만기일자 검증
	   				IF lrT_FIN_PAY_CHK_BILL.EXPR_DT IS NULL THEN
	   					RETURN '지급어음의 만기일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--발행일과 만기일비교 검증
	   				IF lrT_FIN_PAY_CHK_BILL.PUBL_DT > lrT_FIN_PAY_CHK_BILL.EXPR_DT THEN
	   					RETURN '지급어음의 발행일은 만기일보다 클수 없습니다.'||GetSlipInfo;
	   				END IF;
	   				--발행금액 검증
					IF NVL(lrT_FIN_PAY_CHK_BILL.PUBL_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '어음발행금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
				ELSE																								--지급어음 반제
					--어음 발행검증 검증
					IF lrT_FIN_PAY_CHK_BILL.SLIP_ID IS NULL OR lrT_FIN_PAY_CHK_BILL.SLIP_IDSEQ IS NULL THEN
	   					RETURN '발행되지 않은 어음번호입니다.'||GetSlipInfo;
	   				END IF;
					--반제전표번호 검증
					IF NVL(lrT_FIN_PAY_CHK_BILL.RESET_SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_PAY_CHK_BILL.RESET_SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
	   				--발행금액 검증
					IF NVL(lrT_FIN_PAY_CHK_BILL.PUBL_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '어음발행금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
	
			--받을어음 검증
			IF (
				NVL(lrT_ACC_CODE.REC_BILL_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.REC_BILL_NO_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.REC_BILL_NO IS NULL
			) THEN
				RETURN '해당 전표라인에 받을어음번호가 입력되지 않았습니다.'||GetSlipInfo;
			ELSIF (
				NVL(lrT_ACC_CODE.REC_BILL_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.REC_BILL_NO_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.REC_BILL_NO IS NOT NULL
			) THEN
				BEGIN
					SELECT
						*
					INTO
						lrT_FIN_RECEIVE_CHK_BILL
					FROM	T_FIN_RECEIVE_CHK_BILL a
					WHERE	a.REC_CHK_BILL_NO = lrSLIP_BODY.REC_BILL_NO;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RETURN '받을어음번호가 등록되지 않았습니다.'||GetSlipInfo;
				END;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--받을어음 설정
					--전표번호 검증
					IF NVL(lrT_FIN_RECEIVE_CHK_BILL.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_RECEIVE_CHK_BILL.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '받을어음 전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
					--발행일자 검증
	   				IF lrT_FIN_RECEIVE_CHK_BILL.PUBL_DT IS NULL THEN
	   					RETURN '받을어음의 발행일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--만기일자 검증
	   				IF lrT_FIN_RECEIVE_CHK_BILL.EXPR_DT IS NULL THEN
	   					RETURN '받을어음의 만기일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--발행일과 만기일비교 검증
	   				IF lrT_FIN_RECEIVE_CHK_BILL.PUBL_DT > lrT_FIN_RECEIVE_CHK_BILL.EXPR_DT THEN
	   					RETURN '받을어음의 발행일은 만기일보다 클수 없습니다.'||GetSlipInfo;
	   				END IF;
	   				--발행금액 검증
					IF NVL(lrT_FIN_RECEIVE_CHK_BILL.PUBL_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '어음발행금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
				ELSE
					--받을어음 반제
					--어음 발행검증 검증
					IF lrT_FIN_RECEIVE_CHK_BILL.SLIP_ID IS NULL OR lrT_FIN_RECEIVE_CHK_BILL.SLIP_IDSEQ IS NULL THEN
	   					RETURN '발행되지 않은 어음번호입니다.'||GetSlipInfo;
	   				END IF;
					--반제전표번호 검증
					IF NVL(lrT_FIN_RECEIVE_CHK_BILL.RESET_SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_RECEIVE_CHK_BILL.RESET_SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '받을어음 반제전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
	   				--반제금액 검증
					IF NVL(lrT_FIN_RECEIVE_CHK_BILL.RESET_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '어음반제금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
	
			--CP매입 검증
			IF (
				NVL(lrT_ACC_CODE.CP_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.CP_NO_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.CP_NO IS NULL
			) THEN
				RETURN '해당 전표라인에 받을어음번호가 입력되지 않았습니다.'||GetSlipInfo;
			ELSIF (
				NVL(lrT_ACC_CODE.CP_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.CP_NO_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.CP_NO IS NOT NULL
			) THEN
				BEGIN
					SELECT
						*
					INTO
						lrT_FIN_CP_BUY
					FROM	T_FIN_CP_BUY a
					WHERE	a.CP_NO = lrSLIP_BODY.CP_NO;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RETURN 'CP번호(매입)가 등록되지 않았습니다.'||GetSlipInfo;
				END;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--CP매입 설정
					--전표번호 검증
					IF NVL(lrT_FIN_CP_BUY.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_CP_BUY.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN 'CP매입 전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
					--발행일자 검증
	   				IF lrT_FIN_CP_BUY.PUBL_DT IS NULL THEN
	   					RETURN 'CP(매입)의 발행일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--만기일자 검증
	   				IF lrT_FIN_CP_BUY.EXPR_DT IS NULL THEN
	   					RETURN 'CP(매입)의 만기일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--발행일과 만기일비교 검증
	   				IF lrT_FIN_CP_BUY.PUBL_DT > lrT_FIN_CP_BUY.EXPR_DT THEN
	   					RETURN 'CP(매입)의 발행일은 만기일보다 클수 없습니다.'||GetSlipInfo;
	   				END IF;
					--폐기일자 검증
					IF lrT_FIN_CP_BUY.DUSE_DT IS NULL THEN
						RETURN 'CP(매입)의 폐기일자가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					--발행처 검증
					IF lrT_FIN_CP_BUY.PUBL_PLACE IS NULL THEN
						RETURN 'CP(매입)의 발행처가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					--발행자 검증
					IF lrT_FIN_CP_BUY.PUBL_NAME IS NULL THEN
						RETURN 'CP(매입)의 발행자가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					--INTR_RAT
					--주관사 검증
					IF lrT_FIN_CP_BUY.CUST_SEQ IS NULL THEN
						RETURN 'CP(매입)의 주관사가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
	   				--발행금액 검증
					IF NVL(lrT_FIN_CP_BUY.PUBL_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN 'CP(매입)발행금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
					--INCOME_AMT
				ELSE
					--CP매입 반제
					--CP(매입)발행검증 검증
					IF lrT_FIN_CP_BUY.SLIP_ID IS NULL OR lrT_FIN_CP_BUY.SLIP_IDSEQ IS NULL THEN
	   					RETURN '발행되지 않은 CP(매입)번호입니다.'||GetSlipInfo;
	   				END IF;
					--반제전표번호 검증
					IF NVL(lrT_FIN_CP_BUY.RESET_SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_CP_BUY.RESET_SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
	
	   				--반제금액 검증
					IF NVL(lrT_FIN_CP_BUY.RESET_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN 'CP(매입)반제금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
	
			--유가증권 검증
			IF (
				NVL(lrT_ACC_CODE.SECU_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.SECU_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.SECU_NO IS NULL
			) THEN
				RETURN '해당 전표라인에 유가증권번호가 입력되지 않았습니다.'||GetSlipInfo;
			ELSIF (
				NVL(lrT_ACC_CODE.SECU_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.SECU_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.SECU_NO IS NOT NULL
			) THEN
				BEGIN
					SELECT
						*
					INTO
						lrT_FIN_SECURTY
					FROM	T_FIN_SECURTY a
					WHERE	a.SECU_NO = lrSLIP_BODY.SECU_NO;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RETURN '유가증권번호가 등록되지 않았습니다.'||GetSlipInfo;
				END;
	
				IF lrT_FIN_SECURTY.REAL_SECU_NO IS NULL THEN
					RETURN '유가증권번호가 입력되지 않았습니다.'||GetSlipInfo;
				END IF;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--전표번호 검증
					IF NVL(lrT_FIN_SECURTY.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_SECURTY.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '유가증권 전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
					--발행일자 검증
	   				IF lrT_FIN_SECURTY.PUBL_DT IS NULL THEN
	   					RETURN '유가증권의 발행일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--만기일자 검증
	   				IF lrT_FIN_SECURTY.EXPR_DT IS NULL THEN
	   					RETURN '유가증권의 만기일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--발행일과 만기일비교 검증
	   				IF lrT_FIN_SECURTY.PUBL_DT > lrT_FIN_SECURTY.EXPR_DT THEN
	   					RETURN '유가증권의 발행일은 만기일보다 클수 없습니다.'||GetSlipInfo;
	   				END IF;
					/*
	   				--증권금액 검증
					IF NVL(lrT_FIN_SECURTY.PERSTOCK_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '유가증권금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
					*/
					
					--매입금액             : INCOME_AMT
					--유가증권종류구분     : SEC_KIND_CODE
	   				IF lrT_FIN_SECURTY.SEC_KIND_CODE IS NULL THEN
	   					RETURN '유가증권의 종류구분가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
					--취득일               : GET_DT
	   				IF lrT_FIN_SECURTY.GET_DT IS NULL THEN
	   					RETURN '유가증권의 취득일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
					--취득처               : GET_PLACE
	   				IF lrT_FIN_SECURTY.GET_PLACE IS NULL THEN
	   					RETURN '유가증권의 취득처가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
					--선취이자             : BF_GET_ITR_AMT
					--취득시경과이자       : GET_ITR_AMT
					--단복리구분           : ITR_TAG
	   				IF lrT_FIN_SECURTY.ITR_TAG IS NULL THEN
	   					RETURN '유가증권의 단복리구분이 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
					--이율                 : INTR_RATE
				ELSE
					--유가증권 반제
					--어음 발행검증 검증
					IF lrT_FIN_SECURTY.SLIP_ID IS NULL OR lrT_FIN_SECURTY.SLIP_IDSEQ IS NULL THEN
	   					RETURN '발행되지 않은 유가증권번호입니다.'||GetSlipInfo;
	   				END IF;
					--반제전표번호 검증
					IF NVL(lrT_FIN_SECURTY.RESET_SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_SECURTY.RESET_SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
					/*
	   				--반제금액 검증
					IF NVL(lrT_FIN_SECURTY.SALE_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '유가증권매각금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
	
					--매각일자 : SALE_DT
	   				IF lrT_FIN_SECURTY.SALE_DT IS NULL THEN
	   					RETURN '유가증권의 매각일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
					*/
					--상환일자 : RETURN_DT
	   				IF lrT_FIN_SECURTY.RETURN_DT IS NULL THEN
	   					RETURN '유가증권의 상환일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
					--수탁은행 : CONSIGN_BANK
	   				IF lrT_FIN_SECURTY.CONSIGN_BANK IS NULL THEN
	   					RETURN '유가증권의 수탁은행이 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
					--매각이자 : SALE_ITR_AMT
					--매각법인세 : SALE_TAX
					--매각처분손실 : SALE_LOSS
					--매각수수료 : SALE_NP_ITR_AMT
				END IF;
			END IF;
	
			--차입 검증
			IF (
				NVL(lrT_ACC_CODE.LOAN_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.LOAN_NO_MNG_TG,'F') = 'T'
				AND
				(
					lrSLIP_BODY.LOAN_REFUND_NO IS NULL
				)
			) THEN
				RETURN '해당 전표라인에 차입번호가 입력되지 않았습니다.'||GetSlipInfo;
			ELSIF (
				NVL(lrT_ACC_CODE.LOAN_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.LOAN_NO_MNG_TG,'F') = 'T'
				AND
				(
					lrSLIP_BODY.LOAN_REFUND_NO IS NOT NULL
				)
			) THEN
			  	/*
				BEGIN
					SELECT
						*
					INTO
						lrT_FIN_LOAN_REFUND_LIST
					FROM	T_FIN_LOAN_REFUND_LIST a
					WHERE
						LOAN_NO = lrSLIP_BODY.LOAN_REFUND_NO
						AND LOAN_REFUND_SEQ = lrSLIP_BODY.LOAN_REFUND_SEQ;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RETURN '차입(상환)번호가 등록되지 않았습니다.'||GetSlipInfo;
				END;
				*/
				NULL;
			END IF;
	
			--고정자산 검증
	
			--적금 검증
			IF (
				NVL(lrT_ACC_CODE.DEPOSIT_PAY_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.DEPOSIT_PAY_MNG_TG,'F') = 'T'
				AND ( lrSLIP_BODY.DEPOSIT_ACCNO IS NULL OR lrSLIP_BODY.PAYMENT_SEQ IS NULL )
			) THEN
				RETURN '해당 전표라인에 적금불입내역이 입력되지 않았습니다.'||GetSlipInfo;
			ELSIF (
				NVL(lrT_ACC_CODE.DEPOSIT_PAY_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.DEPOSIT_PAY_MNG_TG,'F') = 'T'
				AND ( lrSLIP_BODY.DEPOSIT_ACCNO IS NOT NULL OR lrSLIP_BODY.PAYMENT_SEQ IS NOT NULL )
			) THEN
				BEGIN
					SELECT
						*
					INTO
						lrT_DEPOSIT_PAYMENT_LIST
					FROM	T_DEPOSIT_PAYMENT_LIST a
					WHERE	a.ACCNO = lrSLIP_BODY.ACCNO
					AND		a.PAYMENT_SEQ = lrSLIP_BODY.PAYMENT_SEQ;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RETURN '적금불입내역이 등록되지 않았습니다.'||GetSlipInfo;
				END;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--적금 설정
					--전표번호 검증
					IF NVL(lrT_DEPOSIT_PAYMENT_LIST.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_DEPOSIT_PAYMENT_LIST.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '적금불입내역 전표번호 오류입니다.'||GetSlipInfo;
	   				END IF;
					-- 불입예정일 : PAYMENT_SCH_DT
					-- 불입예정금액 : PAYMENT_SCH_AMT
					-- 불입일자 : PAYMENT_DT
	   				IF lrT_DEPOSIT_PAYMENT_LIST.PAYMENT_DT IS NULL THEN
	   					RETURN '적금 불입일자가 입력되지 않았습니다.'||GetSlipInfo;
	   				END IF;
	   				--불입금액 검증
					IF NVL(lrT_DEPOSIT_PAYMENT_LIST.PAYMENT_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '적금 불입금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
				ELSE
					--적금 반제
					NULL;
				END IF;
			END IF;
	
			--대금지급조건 검증
			IF NVL(lrT_ACC_CODE.PAY_CON_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.PAY_CON_MNG_TG,'F') = 'T' THEN
				IF (lrT_ACC_CODE.ACC_REMAIN_POSITION = 'D' AND NVL(lrSLIP_BODY.DB_AMT,0) > 0) OR
						(lrT_ACC_CODE.ACC_REMAIN_POSITION = 'C' AND NVL(lrSLIP_BODY.CR_AMT,0) > 0) THEN
					IF lrSLIP_BODY.PAY_CON_CASH IS NULL AND lrSLIP_BODY.PAY_CON_BILL IS NULL THEN
						RETURN '해당 전표라인에 대금지급조건이 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					IF NVL(lrSLIP_BODY.PAY_CON_BILL,0) <> 0 AND lrSLIP_BODY.PAY_CON_BILL_DAYS IS NULL THEN
						RETURN '해당 전표라인에 대금지급어음 만기일수가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
			
			--대금지급만기일
			IF NVL(lrT_ACC_CODE.BILL_EXPR_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.BILL_EXPR_MNG_TG,'F') = 'T' THEN
				IF (lrT_ACC_CODE.ACC_REMAIN_POSITION = 'D' AND NVL(lrSLIP_BODY.DB_AMT,0) > 0) OR
						(lrT_ACC_CODE.ACC_REMAIN_POSITION = 'C' AND NVL(lrSLIP_BODY.CR_AMT,0) > 0) THEN
					IF lrSLIP_BODY.PAY_CON_BILL_DT IS NULL THEN
						RETURN '해당 전표라인에 만기일이 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
	
			--지급희망일 검증
			IF NVL(lrT_ACC_CODE.ANTICIPATION_DT_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.ANTICIPATION_DT_MNG_TG,'F') = 'T' AND lrSLIP_BODY.ANTICIPATION_DT IS NULL THEN
				IF (lrT_ACC_CODE.ACC_REMAIN_POSITION = 'D' AND NVL(lrSLIP_BODY.DB_AMT,0) > 0) OR
						(lrT_ACC_CODE.ACC_REMAIN_POSITION = 'C' AND NVL(lrSLIP_BODY.CR_AMT,0) > 0) THEN
					RETURN '해당 전표라인에 지급희망일이 입력되지 않았습니다.'||GetSlipInfo;
				END IF;
			END IF;
	
			--사원번호 검증
			IF NVL(lrT_ACC_CODE.EMP_NO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.EMP_NO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.EMP_NO IS NULL THEN
				RETURN '해당 전표라인에 사원번호가 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--현금영수증 검증
			IF lrT_ACC_CODE.SLIP_DETAIL_LIST = 'P' THEN
				BEGIN
					SELECT
						*
					INTO
						lrT_ACC_SLIP_EXPENSE_CASH
					FROM	T_ACC_SLIP_EXPENSE_CASH a
					WHERE	a.SLIP_ID = lrSLIP_BODY.SLIP_ID
					AND		a.SLIP_IDSEQ = lrSLIP_BODY.SLIP_IDSEQ;
					IF lrT_ACC_SLIP_EXPENSE_CASH.CASHNO IS NULL THEN
						RETURN '현금영수증 승인번호가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					IF lrT_ACC_SLIP_EXPENSE_CASH.USE_DT IS NULL THEN
						RETURN '현금영수증 사용일이 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					IF lrT_ACC_SLIP_EXPENSE_CASH.REQ_TG IS NULL THEN
						RETURN '현금영수증 청구여부가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					IF NVL(lrT_ACC_SLIP_EXPENSE_CASH.TRADE_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '현금영수증 거래금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					--Return '현금영수증내역이 등록되지 않았습니다.'||GetSlipInfo;
					NULL;
				END;
			END IF;
	
			-- 신용카드
			IF lrT_ACC_CODE.SLIP_DETAIL_LIST = 'C' THEN
				BEGIN
					SELECT
						*
					INTO
						lrT_ACC_SLIP_EXPENSE_CARDS
					FROM	T_ACC_SLIP_EXPENSE_CARDS a
					WHERE	a.SLIP_ID = lrSLIP_BODY.SLIP_ID
					AND		a.SLIP_IDSEQ = lrSLIP_BODY.SLIP_IDSEQ;
	
					IF lrT_ACC_SLIP_EXPENSE_CARDS.CARDNO IS NULL THEN
						RETURN '현금영수증 승인번호가 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					IF lrT_ACC_SLIP_EXPENSE_CARDS.USE_DT IS NULL THEN
						RETURN '현금영수증 사용일이 입력되지 않았습니다.'||GetSlipInfo;
					END IF;
					--CARD_HAVE_PERS
					--If lrT_ACC_SLIP_EXPENSE_CARDS.REQ_TG Is Null Then
					--	Return '현금영수증 청구여부가 입력되지 않았습니다.'||GetSlipInfo;
					--End If;
	
					IF NVL(lrT_ACC_SLIP_EXPENSE_CARDS.TRADE_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '현금영수증 거래금액과 전표금액이 일치하지 않습니다.'||GetSlipInfo;
					END IF;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					--Return '카드사용내역이 등록되지 않았습니다.'||GetSlipInfo;
					NULL;
				END;
			END IF;
	
			--관리항목-문자1 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_CHAR1,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_CHAR1 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_CHAR1||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-문자2 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_CHAR2,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_CHAR2 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_CHAR2||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-문자3 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_CHAR3,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_CHAR3 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_CHAR3||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-문자4 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_CHAR4,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_CHAR4 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_CHAR2||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-숫자1 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_NUM1,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_NUM1 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_NUM1||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-숫자2 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_NUM2,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_NUM2 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_NUM2||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-숫자3 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_NUM3,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_NUM3 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_NUM3||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-숫자4 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_NUM4,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_NUM4 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_NUM4||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-날짜1 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_DT1,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_DT1 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_DT1||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-날짜2 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_DT2,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_DT2 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_DT2||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-날짜3 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_DT3,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_DT3 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_DT3||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
	
			--관리항목-날짜4 검증
			IF NVL(lrT_ACC_CODE.MNG_TG_DT4,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_DT4 IS NULL THEN
				RETURN '해당 전표라인에 '||lrT_ACC_CODE.MNG_NAME_DT4||'가(이) 입력되지 않았습니다.'||GetSlipInfo;
			END IF;
			
		END IF; -- IF NVL(lrT_ACC_CODE.ACC_REMAIN_MNG,'F') = 'T' THEN

	END LOOP;

	RETURN ls_Msg;
EXCEPTION WHEN OTHERS THEN
	ls_Msg := SQLERRM;
	RETURN ls_Msg;
END;
/
