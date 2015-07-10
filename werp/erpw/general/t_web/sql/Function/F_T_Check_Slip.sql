CREATE OR REPLACE FUNCTION F_T_Check_Slip
(
	AR_SLIP_ID						T_ACC_SLIP_HEAD.SLIP_ID%TYPE,
	AR_CHECK_WORK_SLIP				VARCHAR2 DEFAULT 'N',			--���þ��� �Է¿��θ� ������ ������ ����
	AR_CHECK_CONFRIMED_REMAIN		VARCHAR2 DEFAULT 'Y'			--Ȯ���� �ܾ׸����� �ܾ��� ������ ������ ����
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
		RETURN 	'<br>���ι�ȣ : '||lrSLIP_BODY.MAKE_SLIPLINE||'<br>'||
				'�������� : '||lrSLIP_BODY.ACC_CODE||'('||lrT_ACC_CODE.ACC_NAME||')<br>'||
				'���� : '||lrSLIP_BODY.SUMMARY1||'<br>'||
				'����ݾ� : '||TO_CHAR(lrSLIP_BODY.DB_AMT,'FM999,999,999,999,990')||' / '||TO_CHAR(lrSLIP_BODY.CR_AMT,'FM999,999,999,999,990');
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
/* 1. �� �� �� �� id : F_T_Check_Slip
/* 2. ����(�ó�����) : Function
/* 3. ��  ��  ��  �� : ��ǥ���� üũ
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
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
		RETURN '�ش� ��ǥ�� ã�� �� �����ϴ�.';
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
		RETURN '�ش� ��ǥ�� ���γ����� �������� �ʽ��ϴ�.';
	END;
	
	--��ǥ ��� ����------------------------------------------------------------------------------*

	--�ڵ���ǥ����
	IF AR_CHECK_WORK_SLIP = 'Y' AND lrSLIP_HEAD.WORK_CODE IS NULL THEN
		RETURN '�ڵ���ǥ ���þ��� ������ �Էµ��� �ʾҽ��ϴ�.';
	END IF;
	
	-- �ⳳ�μ� : INOUT_DEPT_CODE 
	IF lrSLIP_HEAD.INOUT_DEPT_CODE IS NULL THEN
		RETURN '�ⳳ�μ��� �Էµ��� �ʾҽ��ϴ�.';
	END IF;
	-- ������� : CHARGE_PERS
	IF lrSLIP_HEAD.CHARGE_PERS IS NULL THEN
		RETURN '��������� �Էµ��� �ʾҽ��ϴ�.';
	END IF;
	-- �ۼ��� : MAKE_PERS 
	IF lrSLIP_HEAD.MAKE_PERS IS NULL THEN
		RETURN '�ۼ��ڰ� �Էµ��� �ʾҽ��ϴ�.';
	END IF;
	
	-- �ۼ��ڸ� : MAKE_NAME 
	IF lrSLIP_HEAD.MAKE_NAME IS NULL THEN
		RETURN '�ۼ��ڸ��� �Էµ��� �ʾҽ��ϴ�.';
	END IF;
	
	-- ���������
	IF lrSLIP_HEAD.CHARGE_PERS IS NULL THEN
		RETURN '��������ڰ� �Էµ��� �ʾҽ��ϴ�.';
	END IF;

	--�� ���� ����
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
			RETURN 'ȸ�Ⱑ �̹� �����Ǿ����ϴ�.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN 'ȸ�Ⱑ ��ϵ��� �ʾҽ��ϴ�.';
	END;

	--�� ���� ����
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
			RETURN '�ش� ���� �̹� �����Ǿ����ϴ�.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '�������� ��ϵ��� �ʾҽ��ϴ�.';
	END;

	--�� ���� ����
	BEGIN
		SELECT
			CLSE_CLS
		INTO
			lsCLSE_CLS
		FROM	T_DAY_CLOSE
		WHERE	CLSE_DAY = lrSLIP_HEAD.MAKE_DT
		AND		COMP_CODE = lrSLIP_HEAD.MAKE_COMP_CODE;

		IF NVL(lsCLSE_CLS,'F') = 'T' THEN
			RETURN '�ش� ���ڴ� �̹� �����Ǿ����ϴ�.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '�ϸ����� ��ϵ��� �ʾҽ��ϴ�.';
	END;

 	-- �μ� �Է±Ⱓ üũ
	BEGIN
		SELECT
			 CASE
			 	 WHEN (F_T_Datetostring(lrSLIP_HEAD.MAKE_DT) BETWEEN F_T_Datetostring(NVL(INPUT_DT_F, '19000101')) AND F_T_Datetostring(NVL(INPUT_DT_T, '19000101')) )
				 THEN 'F' -- �Է±Ⱓ
				 ELSE 'T' -- �Է¸���
			END DEPT_CLSE_CLS
		INTO
			lsCLSE_CLS
		FROM
			T_DEPT_CODE_ORG A
		WHERE
			A.COMP_CODE = lrSLIP_HEAD.MAKE_COMP_CODE
			AND DEPT_CODE = lrSLIP_HEAD.MAKE_DEPT_CODE;

		IF NVL(lsCLSE_CLS,'F') = 'T' THEN
			RETURN '�μ��� �Է±Ⱓ�� ����Ǿ����ϴ�.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '�μ������� ��ϵ��� �ʾҽ��ϴ�.';
	END;
	
	-- �ۼ����� �����, �ۼ��μ� ����üũ...
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
		RETURN '�ۼ��ڴ� �� �����/�μ��� ��ǥ��� ������ �����ϴ�.';
	END;

	--��ǥ �ϴ� ����------------------------------------------------------------------------------*
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
			RETURN '����ݾ���	��ġ���� �ʽ��ϴ�.'||CHR(10)
			||'��:��'||TO_CHAR(lnDB_AMT,'FM999,999,999,999,999,999,999,990')||':'||TO_CHAR(lnCR_AMT,'FM999,999,999,999,999,999,999,990')||CHR(10)
			||'�����Ҽ� �����ϴ�.';
		END IF;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RETURN '��ǥ ���γ����� ��ϵ��� �ʾҽ��ϴ�.';
	END;

	FOR liI IN 	ltSLIP_DETAIL.First..ltSLIP_DETAIL.Last LOOP
		lrSLIP_BODY := ltSLIP_DETAIL(liI);
		lrT_ACC_CODE := GetAccCodeInfo(lrSLIP_BODY.ACC_CODE);
		--�������� ����
		--�Է°�������
		IF NVL(lrT_ACC_CODE.FUND_INPUT_CLS,'F') = 'F' THEN
			RETURN '�ش� ��ǥ ������ �Է°��ɰ����� �ƴմϴ�.'||GetSlipInfo;
		END IF;

		-- ��꼭������ �Էµǰ�, �ΰ��� �����϶��� ��/�� ��� '0' �̰� ���
		IF  NOT ( lrT_ACC_CODE.RCPTBILL_CLS IS NOT NULL AND NVL(lrT_ACC_CODE.VATOCCUR_CLS, 'F') = 'F' ) THEN
			IF NVL(lrSLIP_BODY.DB_AMT,0)+NVL(lrSLIP_BODY.CR_AMT,0) = 0 THEN
				RETURN '����ݾ��� ��� 0�Դϴ�.'||GetSlipInfo;
			END IF;
		END IF;

		--�����ڵ����
		IF NVL(lrT_ACC_CODE.SUMMARY_CLS,'F') = 'T' AND lrSLIP_BODY.SUMMARY_CODE IS NULL THEN
			RETURN '�ش� ��ǥ���ο� �����ڵ尡 �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
		END IF;

		--����1 ����
		IF lrSLIP_BODY.SUMMARY1 IS NULL THEN
			RETURN '�ش� ��ǥ���ο� ����1�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
		END IF;

		--�ͼӻ���� ����
		IF lrSLIP_BODY.COMP_CODE IS NULL THEN
			RETURN '�ش� ��ǥ���ο� �ͼӻ������ �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
		END IF;
		
		--�ͼӺμ� ����
		IF lrSLIP_BODY.DEPT_CODE IS NULL THEN
			RETURN '�ش� ��ǥ���ο� �ͼӺμ��� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
		END IF;
		
		--��������� ����
		IF lrSLIP_BODY.TAX_COMP_CODE IS NULL THEN
			RETURN '�ش� ��ǥ���ο� ����������� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
		END IF;

		--�ι��ڵ� ����
		IF lrSLIP_BODY.CLASS_CODE IS NULL THEN
			RETURN '�ش� ��ǥ���ο� �ι��ڵ尡 �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
		END IF;

		--�����ڵ�,��������,���ް���,�ΰ��� ����
		--�ΰ��� �ڵ�� ���̴�.
		/*
		IF lrSLIP_BODY.VAT_CODE IS NOT NULL THEN
			--�����ڵ�
			BEGIN
   				SELECT
					*
				INTO
					lrT_ACC_VAT_CODE
				FROM	T_ACC_VAT_CODE a
				WHERE	a.VAT_CODE = lrSLIP_BODY.VAT_CODE;
   			EXCEPTION WHEN NO_DATA_FOUND THEN
   				RETURN '�ΰ����ڵ尡 ��ϵǾ� ���� �ʽ��ϴ�.'||GetSlipInfo;
   			END;

			--��������
			IF  lrSLIP_BODY.VAT_DT IS NULL THEN
				RETURN '�ش� ��ǥ���ο� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;

			--���ް���
			IF  NVL(lrSLIP_BODY.SUPAMT,0) = 0 THEN
				RETURN '�ش� ��ǥ���ο� ���ް����� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;

			--�ΰ�����
			IF NVL(lrT_ACC_VAT_CODE.VATOCCUR_CLS, 'F') = 'T' AND NVL(lrSLIP_BODY.VATAMT,0) = 0 THEN
				RETURN '�ش� ��ǥ���ο� �ΰ����� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
		END IF;
		*/
		IF lrSLIP_BODY.IGNORE_SET_RESET_TAG<>'T' THEN
			
			IF lrT_ACC_CODE.RCPTBILL_CLS IS NOT NULL THEN
				--��������
				IF  lrSLIP_BODY.VAT_DT IS NULL THEN
					RETURN '�ش� ��ǥ���ο� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END IF;
	
				--���ް���
				IF  NVL(lrSLIP_BODY.SUPAMT,0) = 0 THEN
					RETURN '�ش� ��ǥ���ο� ���ް����� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END IF;
	
				--�ΰ�����
				IF NVL(lrT_ACC_CODE.VATOCCUR_CLS, 'F') = 'T' AND NVL(lrSLIP_BODY.VATAMT,0) = 0 THEN
					RETURN '�ش� ��ǥ���ο� �ΰ����� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END IF;
				IF NOT ( NVL(lrT_ACC_CODE.CUST_CODE_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CUST_CODE_MNG_TG,'F') = 'T' ) THEN
					RETURN '�ش� ���������� �ŷ�ó�ڵ� �Է��ʼ��� �����Ǿ����� �ʽ��ϴ�. �ʼ��Է����� �����Ͻ� �� �ٽ��Է��Ͻñ� �ٶ��ϴ�.'||GetSlipInfo;
				END IF;
			END IF;
	
			--�ŷ�ó�ڵ����
			IF NVL(lrT_ACC_CODE.CUST_CODE_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CUST_CODE_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CUST_SEQ IS NULL THEN
				RETURN '�ش� ��ǥ���ο� �ŷ�ó�ڵ尡 �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			IF NVL(lrT_ACC_CODE.CUST_CODE_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CUST_CODE_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CUST_NAME IS NULL THEN
				RETURN '�ش� ��ǥ���ο� �ŷ�ó���� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�ŷ�ó�����
			IF NVL(lrT_ACC_CODE.CUST_NAME_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CUST_NAME_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CUST_NAME IS NULL THEN
				RETURN '�ش� ��ǥ���ο� �ŷ�ó���� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�ܾװ��� ���� 
			IF NVL(lrT_ACC_CODE.ACC_REMAIN_MNG,'F') = 'T' THEN
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--�ܾװ��� ����
					IF ( NVL(lrSLIP_BODY.RESET_SLIP_ID, 0)=0 OR NVL(lrSLIP_BODY.RESET_SLIP_IDSEQ, 0)=0 ) THEN
						RETURN '�ܾװ��� ������ǥ��ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					IF (
						NVL(lrSLIP_BODY.RESET_SLIP_ID, 0)<>NVL(lrSLIP_BODY.SLIP_ID, 0)
						OR
						NVL(lrSLIP_BODY.RESET_SLIP_IDSEQ, 0)<>NVL(lrSLIP_BODY.SLIP_IDSEQ, 0)
					) THEN
						RETURN '�ܾװ������� ��ǥ��ȣ�� �߸��ԷµǾ����ϴ�.'||GetSlipInfo;
					END IF;
				ELSE
					--�ܾװ��� ����
					IF ( NVL(lrSLIP_BODY.RESET_SLIP_ID, 0)=0 OR NVL(lrSLIP_BODY.RESET_SLIP_IDSEQ, 0)=0 ) THEN
						RETURN '�ܾװ��� ������ǥ��ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					
					--�����ݾ� < �����ݾ� üũ
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
						RETURN '�����ݾ��� �ܾ��� �ʰ��߽��ϴ�.'||GetSlipInfo;
					END IF;
		
				END IF;
			ELSE
				--�ܾװ��� ������ �ƴѰ�.
				IF ( NVL(lrSLIP_BODY.RESET_SLIP_ID, 0)<>0 OR NVL(lrSLIP_BODY.RESET_SLIP_IDSEQ, 0)<>0 ) THEN
					RETURN '�ܾװ��� ������ �ƴ� �׸� ����/������ǥ��ȣ�� �Է½��ϴ�.'||GetSlipInfo;
				END IF;
			END IF;
			
			--�������� ����
			IF lrT_ACC_CODE.BUDG_EXEC_CLS = 'T' THEN
				SELECT
					-- �ܾ�
					F_T_Acc_Budg_Jan_Amt(lrSLIP_BODY.COMP_CODE,lrSLIP_BODY.DEPT_CODE,lrSLIP_BODY.ACC_CODE,TO_CHAR(lrSLIP_BODY.MAKE_DT, 'YYYYMM')||'01'),
					-- �ͼӺμ��� �ܾ�üũ ����..
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
				   	ls_Msg := '���� �ܾ��� �ʰ��߽��ϴ�. �ܾ�:'||To_Char(ln_AccBudgAmt,'FM999,999,999,999,999,999,999')||' ����ݾ� : '||To_Char( NVL(lrSLIP_BODY.DB_AMT,0) + NVL(lrSLIP_BODY.CR_AMT,0),'FM999,999,999,999,999,999,999')||GetSlipInfo;
					RAISE_APPLICATION_ERROR	(-20009, '��ǥ��������!!!<br>'|| REPLACE(ls_Msg,'ORA-',CHR(10)||'ORACLE Internal Error - '));
				END IF;
			END IF;
	
			--��������ڵ� ����
			IF NVL(lrT_ACC_CODE.BANK_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.BANK_MNG_TG,'F') = 'T' AND lrSLIP_BODY.BANK_CODE IS NULL THEN
				RETURN '�ش� ��ǥ���ο� �����ڵ尡 �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--���¹�ȣ ����
			IF NVL(lrT_ACC_CODE.ACCNO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.ACCNO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.ACCNO IS NULL THEN
				RETURN '�ش� ��ǥ���ο� ���¹�ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
			
			--ī���ȣ ����
			IF NVL(lrT_ACC_CODE.CARD_SEQ_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CARD_SEQ_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CARD_SEQ IS NULL THEN
				RETURN '�ش� ��ǥ���ο� ī���ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--���¼�ǥ����
			IF NVL(lrT_ACC_CODE.CHK_NO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.CHK_NO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.CHK_NO IS NULL THEN
				RETURN '�ش� ��ǥ���ο� ��ǥ��ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
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
	   				RETURN '��ǥ��ȣ�� ��ϵǾ� ���� �ʽ��ϴ�.'||GetSlipInfo;
	   			END;
	
	   			--�������� ����
				IF lrT_FIN_PAY_CHK_BILL.PUBL_DT IS NULL THEN
					RETURN '�ش� ��ǥ���ο� ���¹������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END IF;
			END IF;
	
			--���޾�������
			IF NVL(lrT_ACC_CODE.BILL_NO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.BILL_NO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.BILL_NO IS NULL THEN
				RETURN '�ش� ��ǥ���ο� ���޾�����ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			ELSIF NVL(lrT_ACC_CODE.BILL_NO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.BILL_NO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.BILL_NO IS NOT NULL THEN
				BEGIN
					SELECT
						*
					INTO
						lrT_FIN_PAY_CHK_BILL
					FROM	T_FIN_PAY_CHK_BILL a
					WHERE	a.CHK_BILL_NO = lrSLIP_BODY.BILL_NO;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					RETURN '���޾�����ȣ�� ��ϵ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN		--���޾��� ����
	
					--��ǥ��ȣ ����
					IF NVL(lrT_FIN_PAY_CHK_BILL.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_PAY_CHK_BILL.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '���޾��� ��ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
					--�������� ����
	   				IF lrT_FIN_PAY_CHK_BILL.PUBL_DT IS NULL THEN
	   					RETURN '���޾����� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�������� ����
	   				IF lrT_FIN_PAY_CHK_BILL.EXPR_DT IS NULL THEN
	   					RETURN '���޾����� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�����ϰ� �����Ϻ� ����
	   				IF lrT_FIN_PAY_CHK_BILL.PUBL_DT > lrT_FIN_PAY_CHK_BILL.EXPR_DT THEN
	   					RETURN '���޾����� �������� �����Ϻ��� Ŭ�� �����ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--����ݾ� ����
					IF NVL(lrT_FIN_PAY_CHK_BILL.PUBL_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '��������ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
				ELSE																								--���޾��� ����
					--���� ������� ����
					IF lrT_FIN_PAY_CHK_BILL.SLIP_ID IS NULL OR lrT_FIN_PAY_CHK_BILL.SLIP_IDSEQ IS NULL THEN
	   					RETURN '������� ���� ������ȣ�Դϴ�.'||GetSlipInfo;
	   				END IF;
					--������ǥ��ȣ ����
					IF NVL(lrT_FIN_PAY_CHK_BILL.RESET_SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_PAY_CHK_BILL.RESET_SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '��ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
	   				--����ݾ� ����
					IF NVL(lrT_FIN_PAY_CHK_BILL.PUBL_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '��������ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
	
			--�������� ����
			IF (
				NVL(lrT_ACC_CODE.REC_BILL_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.REC_BILL_NO_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.REC_BILL_NO IS NULL
			) THEN
				RETURN '�ش� ��ǥ���ο� ����������ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
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
					RETURN '����������ȣ�� ��ϵ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--�������� ����
					--��ǥ��ȣ ����
					IF NVL(lrT_FIN_RECEIVE_CHK_BILL.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_RECEIVE_CHK_BILL.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '�������� ��ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
					--�������� ����
	   				IF lrT_FIN_RECEIVE_CHK_BILL.PUBL_DT IS NULL THEN
	   					RETURN '���������� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�������� ����
	   				IF lrT_FIN_RECEIVE_CHK_BILL.EXPR_DT IS NULL THEN
	   					RETURN '���������� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�����ϰ� �����Ϻ� ����
	   				IF lrT_FIN_RECEIVE_CHK_BILL.PUBL_DT > lrT_FIN_RECEIVE_CHK_BILL.EXPR_DT THEN
	   					RETURN '���������� �������� �����Ϻ��� Ŭ�� �����ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--����ݾ� ����
					IF NVL(lrT_FIN_RECEIVE_CHK_BILL.PUBL_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '��������ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
				ELSE
					--�������� ����
					--���� ������� ����
					IF lrT_FIN_RECEIVE_CHK_BILL.SLIP_ID IS NULL OR lrT_FIN_RECEIVE_CHK_BILL.SLIP_IDSEQ IS NULL THEN
	   					RETURN '������� ���� ������ȣ�Դϴ�.'||GetSlipInfo;
	   				END IF;
					--������ǥ��ȣ ����
					IF NVL(lrT_FIN_RECEIVE_CHK_BILL.RESET_SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_RECEIVE_CHK_BILL.RESET_SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '�������� ������ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�����ݾ� ����
					IF NVL(lrT_FIN_RECEIVE_CHK_BILL.RESET_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '���������ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
	
			--CP���� ����
			IF (
				NVL(lrT_ACC_CODE.CP_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.CP_NO_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.CP_NO IS NULL
			) THEN
				RETURN '�ش� ��ǥ���ο� ����������ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
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
					RETURN 'CP��ȣ(����)�� ��ϵ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--CP���� ����
					--��ǥ��ȣ ����
					IF NVL(lrT_FIN_CP_BUY.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_CP_BUY.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN 'CP���� ��ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
					--�������� ����
	   				IF lrT_FIN_CP_BUY.PUBL_DT IS NULL THEN
	   					RETURN 'CP(����)�� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�������� ����
	   				IF lrT_FIN_CP_BUY.EXPR_DT IS NULL THEN
	   					RETURN 'CP(����)�� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�����ϰ� �����Ϻ� ����
	   				IF lrT_FIN_CP_BUY.PUBL_DT > lrT_FIN_CP_BUY.EXPR_DT THEN
	   					RETURN 'CP(����)�� �������� �����Ϻ��� Ŭ�� �����ϴ�.'||GetSlipInfo;
	   				END IF;
					--������� ����
					IF lrT_FIN_CP_BUY.DUSE_DT IS NULL THEN
						RETURN 'CP(����)�� ������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					--����ó ����
					IF lrT_FIN_CP_BUY.PUBL_PLACE IS NULL THEN
						RETURN 'CP(����)�� ����ó�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					--������ ����
					IF lrT_FIN_CP_BUY.PUBL_NAME IS NULL THEN
						RETURN 'CP(����)�� �����ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					--INTR_RAT
					--�ְ��� ����
					IF lrT_FIN_CP_BUY.CUST_SEQ IS NULL THEN
						RETURN 'CP(����)�� �ְ��簡 �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
	   				--����ݾ� ����
					IF NVL(lrT_FIN_CP_BUY.PUBL_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN 'CP(����)����ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
					--INCOME_AMT
				ELSE
					--CP���� ����
					--CP(����)������� ����
					IF lrT_FIN_CP_BUY.SLIP_ID IS NULL OR lrT_FIN_CP_BUY.SLIP_IDSEQ IS NULL THEN
	   					RETURN '������� ���� CP(����)��ȣ�Դϴ�.'||GetSlipInfo;
	   				END IF;
					--������ǥ��ȣ ����
					IF NVL(lrT_FIN_CP_BUY.RESET_SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_CP_BUY.RESET_SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '��ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
	
	   				--�����ݾ� ����
					IF NVL(lrT_FIN_CP_BUY.RESET_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN 'CP(����)�����ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
	
			--�������� ����
			IF (
				NVL(lrT_ACC_CODE.SECU_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.SECU_MNG_TG,'F') = 'T'
				AND lrSLIP_BODY.SECU_NO IS NULL
			) THEN
				RETURN '�ش� ��ǥ���ο� �������ǹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
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
					RETURN '�������ǹ�ȣ�� ��ϵ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END;
	
				IF lrT_FIN_SECURTY.REAL_SECU_NO IS NULL THEN
					RETURN '�������ǹ�ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END IF;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--��ǥ��ȣ ����
					IF NVL(lrT_FIN_SECURTY.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_SECURTY.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '�������� ��ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
					--�������� ����
	   				IF lrT_FIN_SECURTY.PUBL_DT IS NULL THEN
	   					RETURN '���������� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�������� ����
	   				IF lrT_FIN_SECURTY.EXPR_DT IS NULL THEN
	   					RETURN '���������� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--�����ϰ� �����Ϻ� ����
	   				IF lrT_FIN_SECURTY.PUBL_DT > lrT_FIN_SECURTY.EXPR_DT THEN
	   					RETURN '���������� �������� �����Ϻ��� Ŭ�� �����ϴ�.'||GetSlipInfo;
	   				END IF;
					/*
	   				--���Ǳݾ� ����
					IF NVL(lrT_FIN_SECURTY.PERSTOCK_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '�������Ǳݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
					*/
					
					--���Աݾ�             : INCOME_AMT
					--����������������     : SEC_KIND_CODE
	   				IF lrT_FIN_SECURTY.SEC_KIND_CODE IS NULL THEN
	   					RETURN '���������� �������а� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
					--�����               : GET_DT
	   				IF lrT_FIN_SECURTY.GET_DT IS NULL THEN
	   					RETURN '���������� ������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
					--���ó               : GET_PLACE
	   				IF lrT_FIN_SECURTY.GET_PLACE IS NULL THEN
	   					RETURN '���������� ���ó�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
					--��������             : BF_GET_ITR_AMT
					--���ð������       : GET_ITR_AMT
					--�ܺ�������           : ITR_TAG
	   				IF lrT_FIN_SECURTY.ITR_TAG IS NULL THEN
	   					RETURN '���������� �ܺ��������� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
					--����                 : INTR_RATE
				ELSE
					--�������� ����
					--���� ������� ����
					IF lrT_FIN_SECURTY.SLIP_ID IS NULL OR lrT_FIN_SECURTY.SLIP_IDSEQ IS NULL THEN
	   					RETURN '������� ���� �������ǹ�ȣ�Դϴ�.'||GetSlipInfo;
	   				END IF;
					--������ǥ��ȣ ����
					IF NVL(lrT_FIN_SECURTY.RESET_SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_FIN_SECURTY.RESET_SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '��ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
					/*
	   				--�����ݾ� ����
					IF NVL(lrT_FIN_SECURTY.SALE_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '�������ǸŰ��ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
	
					--�Ű����� : SALE_DT
	   				IF lrT_FIN_SECURTY.SALE_DT IS NULL THEN
	   					RETURN '���������� �Ű����ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
					*/
					--��ȯ���� : RETURN_DT
	   				IF lrT_FIN_SECURTY.RETURN_DT IS NULL THEN
	   					RETURN '���������� ��ȯ���ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
					--��Ź���� : CONSIGN_BANK
	   				IF lrT_FIN_SECURTY.CONSIGN_BANK IS NULL THEN
	   					RETURN '���������� ��Ź������ �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
					--�Ű����� : SALE_ITR_AMT
					--�Ű����μ� : SALE_TAX
					--�Ű�ó�мս� : SALE_LOSS
					--�Ű������� : SALE_NP_ITR_AMT
				END IF;
			END IF;
	
			--���� ����
			IF (
				NVL(lrT_ACC_CODE.LOAN_NO_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.LOAN_NO_MNG_TG,'F') = 'T'
				AND
				(
					lrSLIP_BODY.LOAN_REFUND_NO IS NULL
				)
			) THEN
				RETURN '�ش� ��ǥ���ο� ���Թ�ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
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
					RETURN '����(��ȯ)��ȣ�� ��ϵ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END;
				*/
				NULL;
			END IF;
	
			--�����ڻ� ����
	
			--���� ����
			IF (
				NVL(lrT_ACC_CODE.DEPOSIT_PAY_MNG,'F') = 'T'
				AND NVL(lrT_ACC_CODE.DEPOSIT_PAY_MNG_TG,'F') = 'T'
				AND ( lrSLIP_BODY.DEPOSIT_ACCNO IS NULL OR lrSLIP_BODY.PAYMENT_SEQ IS NULL )
			) THEN
				RETURN '�ش� ��ǥ���ο� ���ݺ��Գ����� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
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
					RETURN '���ݺ��Գ����� ��ϵ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END;
	
				IF (NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrSLIP_BODY.DB_AMT, 0) > 0) OR
					(NVL(lrT_ACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrSLIP_BODY.CR_AMT, 0) > 0) THEN
					--���� ����
					--��ǥ��ȣ ����
					IF NVL(lrT_DEPOSIT_PAYMENT_LIST.SLIP_ID, 0) <> NVL(lrSLIP_BODY.SLIP_ID, 0) OR
						NVL(lrT_DEPOSIT_PAYMENT_LIST.SLIP_IDSEQ, 0) <> NVL(lrSLIP_BODY.SLIP_IDSEQ, 0) THEN
	   					RETURN '���ݺ��Գ��� ��ǥ��ȣ �����Դϴ�.'||GetSlipInfo;
	   				END IF;
					-- ���Կ����� : PAYMENT_SCH_DT
					-- ���Կ����ݾ� : PAYMENT_SCH_AMT
					-- �������� : PAYMENT_DT
	   				IF lrT_DEPOSIT_PAYMENT_LIST.PAYMENT_DT IS NULL THEN
	   					RETURN '���� �������ڰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
	   				END IF;
	   				--���Աݾ� ����
					IF NVL(lrT_DEPOSIT_PAYMENT_LIST.PAYMENT_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '���� ���Աݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
				ELSE
					--���� ����
					NULL;
				END IF;
			END IF;
	
			--����������� ����
			IF NVL(lrT_ACC_CODE.PAY_CON_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.PAY_CON_MNG_TG,'F') = 'T' THEN
				IF (lrT_ACC_CODE.ACC_REMAIN_POSITION = 'D' AND NVL(lrSLIP_BODY.DB_AMT,0) > 0) OR
						(lrT_ACC_CODE.ACC_REMAIN_POSITION = 'C' AND NVL(lrSLIP_BODY.CR_AMT,0) > 0) THEN
					IF lrSLIP_BODY.PAY_CON_CASH IS NULL AND lrSLIP_BODY.PAY_CON_BILL IS NULL THEN
						RETURN '�ش� ��ǥ���ο� ������������� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					IF NVL(lrSLIP_BODY.PAY_CON_BILL,0) <> 0 AND lrSLIP_BODY.PAY_CON_BILL_DAYS IS NULL THEN
						RETURN '�ش� ��ǥ���ο� ������޾��� �����ϼ��� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
			
			--������޸�����
			IF NVL(lrT_ACC_CODE.BILL_EXPR_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.BILL_EXPR_MNG_TG,'F') = 'T' THEN
				IF (lrT_ACC_CODE.ACC_REMAIN_POSITION = 'D' AND NVL(lrSLIP_BODY.DB_AMT,0) > 0) OR
						(lrT_ACC_CODE.ACC_REMAIN_POSITION = 'C' AND NVL(lrSLIP_BODY.CR_AMT,0) > 0) THEN
					IF lrSLIP_BODY.PAY_CON_BILL_DT IS NULL THEN
						RETURN '�ش� ��ǥ���ο� �������� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
				END IF;
			END IF;
	
			--��������� ����
			IF NVL(lrT_ACC_CODE.ANTICIPATION_DT_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.ANTICIPATION_DT_MNG_TG,'F') = 'T' AND lrSLIP_BODY.ANTICIPATION_DT IS NULL THEN
				IF (lrT_ACC_CODE.ACC_REMAIN_POSITION = 'D' AND NVL(lrSLIP_BODY.DB_AMT,0) > 0) OR
						(lrT_ACC_CODE.ACC_REMAIN_POSITION = 'C' AND NVL(lrSLIP_BODY.CR_AMT,0) > 0) THEN
					RETURN '�ش� ��ǥ���ο� ����������� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
				END IF;
			END IF;
	
			--�����ȣ ����
			IF NVL(lrT_ACC_CODE.EMP_NO_MNG,'F') = 'T' AND NVL(lrT_ACC_CODE.EMP_NO_MNG_TG,'F') = 'T' AND lrSLIP_BODY.EMP_NO IS NULL THEN
				RETURN '�ش� ��ǥ���ο� �����ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--���ݿ����� ����
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
						RETURN '���ݿ����� ���ι�ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					IF lrT_ACC_SLIP_EXPENSE_CASH.USE_DT IS NULL THEN
						RETURN '���ݿ����� ������� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					IF lrT_ACC_SLIP_EXPENSE_CASH.REQ_TG IS NULL THEN
						RETURN '���ݿ����� û�����ΰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					IF NVL(lrT_ACC_SLIP_EXPENSE_CASH.TRADE_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '���ݿ����� �ŷ��ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					--Return '���ݿ����������� ��ϵ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					NULL;
				END;
			END IF;
	
			-- �ſ�ī��
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
						RETURN '���ݿ����� ���ι�ȣ�� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					IF lrT_ACC_SLIP_EXPENSE_CARDS.USE_DT IS NULL THEN
						RETURN '���ݿ����� ������� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					END IF;
					--CARD_HAVE_PERS
					--If lrT_ACC_SLIP_EXPENSE_CARDS.REQ_TG Is Null Then
					--	Return '���ݿ����� û�����ΰ� �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					--End If;
	
					IF NVL(lrT_ACC_SLIP_EXPENSE_CARDS.TRADE_AMT,0) <> NVL(lrSLIP_BODY.CR_AMT,0) + NVL(lrSLIP_BODY.DB_AMT,0) THEN
						RETURN '���ݿ����� �ŷ��ݾװ� ��ǥ�ݾ��� ��ġ���� �ʽ��ϴ�.'||GetSlipInfo;
					END IF;
				EXCEPTION WHEN NO_DATA_FOUND THEN
					--Return 'ī���볻���� ��ϵ��� �ʾҽ��ϴ�.'||GetSlipInfo;
					NULL;
				END;
			END IF;
	
			--�����׸�-����1 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_CHAR1,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_CHAR1 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_CHAR1||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-����2 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_CHAR2,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_CHAR2 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_CHAR2||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-����3 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_CHAR3,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_CHAR3 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_CHAR3||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-����4 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_CHAR4,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_CHAR4 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_CHAR2||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-����1 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_NUM1,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_NUM1 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_NUM1||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-����2 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_NUM2,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_NUM2 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_NUM2||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-����3 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_NUM3,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_NUM3 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_NUM3||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-����4 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_NUM4,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_NUM4 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_NUM4||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-��¥1 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_DT1,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_DT1 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_DT1||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-��¥2 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_DT2,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_DT2 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_DT2||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-��¥3 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_DT3,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_DT3 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_DT3||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
	
			--�����׸�-��¥4 ����
			IF NVL(lrT_ACC_CODE.MNG_TG_DT4,'F') = 'T' AND lrSLIP_BODY.MNG_ITEM_DT4 IS NULL THEN
				RETURN '�ش� ��ǥ���ο� '||lrT_ACC_CODE.MNG_NAME_DT4||'��(��) �Էµ��� �ʾҽ��ϴ�.'||GetSlipInfo;
			END IF;
			
		END IF; -- IF NVL(lrT_ACC_CODE.ACC_REMAIN_MNG,'F') = 'T' THEN

	END LOOP;

	RETURN ls_Msg;
EXCEPTION WHEN OTHERS THEN
	ls_Msg := SQLERRM;
	RETURN ls_Msg;
END;
/
