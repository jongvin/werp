CREATE OR REPLACE PROCEDURE Sp_T_Acc_Slip_Conf_Core
(
	Ar_Slip_Id			NUMBER,
	Ar_KEEP_SLIPNO			VARCHAR2,
	Ar_Keep_Dt			VARCHAR2,
	Ar_Keep_Dt_Trans		VARCHAR2,
	Ar_Keep_Dept			VARCHAR2,
	Ar_KEEP_KEEPER			NUMBER,
	Ar_Confirm_YN			VARCHAR2		--T,F
)
IS
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-12-15
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
--전표확정/취소 공용(Ar_Confirm_YN : T(확정), F(취소)
	TYPE SLIP_DETAIL_TABLE IS TABLE OF T_ACC_SLIP_BODY%ROWTYPE
		INDEX BY BINARY_INTEGER;
	TYPE ACC_CODE_TABLE IS TABLE OF T_ACC_CODE%ROWTYPE
		INDEX BY T_ACC_CODE.ACC_CODE%TYPE;
	ltSLIP_DETAIL	SLIP_DETAIL_TABLE;
	ltACC_CODE		ACC_CODE_TABLE;
	lrSLIP_BODY		T_ACC_SLIP_BODY%ROWTYPE;
	lrT_ACC_CODE	T_ACC_CODE%ROWTYPE;
	ln_Count		NUMBER;
	ln_ResetCount	NUMBER;
	ln_AccBudgAmt	NUMBER;
	Bill_Count		NUMBER;
	Bill_ResetCount	NUMBER;
	ldt_MakeDtTrans T_ACC_SLIP_HEAD.MAKE_DT_TRANS%TYPE;
	ls_Msg			VARCHAR2(2000);

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
		AR_ACC_CODE			T_ACC_CODE.ACC_CODE%TYPE
	)
	RETURN T_ACC_CODE%ROWTYPE
	IS
		lrRet				T_ACC_CODE%ROWTYPE;
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
				FROM	T_ACC_CODE
				WHERE	ACC_CODE = AR_ACC_CODE;
				ltACC_CODE(AR_ACC_CODE) := lrRet;
				RETURN lrRet;
			EXCEPTION WHEN NO_DATA_FOUND THEN
				RETURN NULL;
			END;
		END;
		RETURN NULL;
	END;
BEGIN

	IF Ar_Confirm_YN = 'T' THEN
	   	--확정
		SELECT
			COUNT(*)
		INTO
			ln_Count
		FROM
		(
			SELECT
				A.SLIP_ID,
				A.SLIP_IDSEQ,
				-- 확정 전표기준 잔액
				NVL(A.DB_AMT,0)+NVL(A.CR_AMT,0) + (
							SELECT
								 NVL(SUM(DECODE(Ci.ACC_REMAIN_POSITION, 'D', 1, -1)* Bi.DB_AMT + DECODE(Ci.ACC_REMAIN_POSITION, 'C', 1, -1)*Bi.CR_AMT),0)
							FROM
								T_ACC_SLIP_HEAD Ai,
								T_ACC_SLIP_BODY Bi,
								T_ACC_CODE Ci
							WHERE
								Ai.SLIP_ID = Bi.SLIP_ID
								AND Bi.ACC_CODE = Ci.ACC_CODE
								AND Bi.COMP_CODE = A.COMP_CODE
								AND Bi.DEPT_CODE = A.DEPT_CODE
								AND Bi.CUST_SEQ = A.CUST_SEQ
								AND Bi.ACC_CODE = A.ACC_CODE
								AND Bi.RESET_SLIP_ID = A.SLIP_ID
								AND Bi.RESET_SLIP_IDSEQ = A.SLIP_IDSEQ
								AND Bi.SLIP_ID <> Bi.RESET_SLIP_ID
								AND Bi.SLIP_IDSEQ <> Bi.RESET_SLIP_IDSEQ
								AND Ai.KEEP_DT_TRANS IS NOT NULL
						) JAN_AMT,
				-- 현전표내 반제 금액 합
				(
					SELECT
						 NVL(SUM(DECODE(Ci.ACC_REMAIN_POSITION, 'D', 1, -1)* Bi.DB_AMT + DECODE(Ci.ACC_REMAIN_POSITION, 'C', 1, -1)*Bi.CR_AMT),0)
					FROM
						T_ACC_SLIP_HEAD Ai,
						T_ACC_SLIP_BODY Bi,
						T_ACC_CODE Ci
					WHERE
						Ai.SLIP_ID = Bi.SLIP_ID
						AND Bi.ACC_CODE = Ci.ACC_CODE
						AND Bi.COMP_CODE = A.COMP_CODE
						AND Bi.DEPT_CODE = A.DEPT_CODE
						AND Bi.CUST_SEQ = A.CUST_SEQ
						AND Bi.ACC_CODE = A.ACC_CODE
						AND Bi.RESET_SLIP_ID = A.SLIP_ID
						AND Bi.RESET_SLIP_IDSEQ = A.SLIP_IDSEQ
						AND Bi.SLIP_ID <> Bi.RESET_SLIP_ID
						AND Bi.SLIP_IDSEQ <> Bi.RESET_SLIP_IDSEQ
						AND Ai.KEEP_DT_TRANS IS NULL
						AND Bi.SLIP_ID=Ar_Slip_Id
				) CUR_RESET_AMT
			FROM
				T_ACC_SLIP_BODY A
			WHERE
				(A.SLIP_ID, A.SLIP_IDSEQ) IN (
					SELECT
						A.RESET_SLIP_ID,
						A.RESET_SLIP_IDSEQ
					FROM
						T_ACC_SLIP_BODY A,
						T_ACC_CODE B
					WHERE
						A.ACC_CODE = B.ACC_CODE
						AND B.ACC_REMAIN_MNG = 'T'
						AND A.SLIP_ID=Ar_Slip_Id
				)
		) A
		WHERE
			JAN_AMT+CUR_RESET_AMT<0;

		IF ln_Count > 0 THEN
			RAISE_APPLICATION_ERROR(-20009,'해당전표에 반제금액이 설정 잔액을 초과하는 행이 존재합니다.');
		END IF;

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
			RAISE_APPLICATION_ERROR(-20009,'해당 전표의 세부내역이 존재하지 않습니다.');
		END;

		/*
		-- 전표등록시 체크로 옮겨짐..
		FOR liI IN 	ltSLIP_DETAIL.First..ltSLIP_DETAIL.Last LOOP
			lrSLIP_BODY := ltSLIP_DETAIL(liI);
			lrT_ACC_CODE := GetAccCodeInfo(lrSLIP_BODY.ACC_CODE);

		   	--예산 검증
			IF lrT_ACC_CODE.BUDG_EXEC_CLS = 'T' THEN
				SELECT
					F_T_Acc_Budg_Jan_Amt(lrSLIP_BODY.COMP_CODE,lrSLIP_BODY.DEPT_CODE,lrSLIP_BODY.ACC_CODE,TO_CHAR(lrSLIP_BODY.MAKE_DT, 'YYYYMM')||'01')
				INTO ln_AccBudgAmt
				FROM
					DUAL;
				IF NVL(lrSLIP_BODY.DB_AMT,0) + NVL(lrSLIP_BODY.CR_AMT,0) > ln_AccBudgAmt THEN
				   	ls_Msg := '예산 잔액을 초과했습니다.'||GetSlipInfo;
					RAISE_APPLICATION_ERROR	(-20009, '전표생성오류!!!<br>'|| REPLACE(ls_Msg,'ORA-',CHR(10)||'ORACLE Internal Error - '));
				END IF;
			END IF;
		END LOOP;
		*/

		/*
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip','6dddd');
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip','Ar_Slip_Id');
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip',Ar_Slip_Id);
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip','Ar_KEEP_SLIPNO');
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip',Ar_KEEP_SLIPNO);
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip','Ar_Keep_Dt');
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip',Ar_Keep_Dt);
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip','Ar_Keep_Dt_Trans');
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip',Ar_Keep_Dt_Trans);
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip','Ar_Keep_Seq');
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip',Ar_Keep_Seq);
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip','Ar_Keep_Dept');
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip',Ar_Keep_Dept);
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip','Ar_KEEP_KEEPER');
		SKCC_Debug.PrintMessages('SPIA_Confirm_Slip',Ar_KEEP_KEEPER);
		*/
		
		UPDATE	T_ACC_SLIP_HEAD
		SET		KEEP_SLIPNO = Ar_KEEP_SLIPNO,
				Keep_Dt = F_T_Stringtodate(Ar_Keep_Dt),
				Keep_Dt_Trans = Ar_Keep_Dt_Trans,
				Keep_Dept_Code = Ar_Keep_Dept,
				KEEP_KEEPER = Ar_KEEP_KEEPER,
				GROUPWARE_SLIPSTATUS = 'S'
		WHERE	Slip_Id = Ar_Slip_Id;
		--Sp_T_Check_Slip(Ar_Slip_Id,'N','Y','2');
		Sp_T_Log_Acc_Slip_Head_I(AR_SLIP_ID,'2',Ar_KEEP_KEEPER);
	ELSE
		--확정해제
		-- 반제전표 존재 체크... 설정전표삭제시 체크？		
		/*
		SELECT COUNT(*)
		INTO	 ln_Count
		FROM	 T_Acc_Slip_Body
		WHERE	 SLIP_ID <> RESET_SLIP_ID
		AND 	 RESET_SLIP_ID = AR_SLIP_ID;

		IF ln_Count > 0 THEN
			RAISE_APPLICATION_ERROR(-20009,'현 전표에 대한 반제전표가 존재합니다.<br>확정취소할수 없습니다.');
		END IF;
		*/

		UPDATE	T_ACC_SLIP_HEAD
		SET		KEEP_SLIPNO = NULL,
				Keep_Dt = NULL,
				Keep_Dt_Trans = NULL,
				Keep_Dept_Code = NULL,
				KEEP_KEEPER = NULL,
				GROUPWARE_SLIPSTATUS = 'N'
		WHERE	Slip_Id = Ar_Slip_Id;
		--Sp_T_Check_Slip(Ar_Slip_Id,'N','Y','3');
		Sp_T_Log_Acc_Slip_Head_I(AR_SLIP_ID,'3',Ar_KEEP_KEEPER);
	END IF;

	--전표 발의일자
	SELECT MAKE_DT_TRANS
	INTO ldt_MakeDtTrans
	FROM T_ACC_SLIP_HEAD
	WHERE SLIP_ID = Ar_Slip_Id;

	Sp_T_Acc_Slip_Daily_Sum(Ar_Slip_Id, ldt_MakeDtTrans, Ar_KEEP_KEEPER);

	Sp_T_Log_Acc_Slip_Trans_I(Ar_Slip_Id, Ar_KEEP_KEEPER, Ar_Confirm_YN);
END;
/
