CREATE OR REPLACE PROCEDURE Sp_T_Work_Acc_Slip_Body_Emy_I
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CRTUSERNO                               VARCHAR2, 
	AR_WORK_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_WORK_ACC_SLIP_BODY_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_WORK_ACC_SLIP_BODY ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
lrT_WORK_ACC_CODE	T_WORK_ACC_CODE%ROWTYPE;
lrT_DEPT_CODE_ORG	T_DEPT_CODE_ORG%ROWTYPE;
lrT_DEPT_CLASS_CODE T_DEPT_CLASS_CODE%ROWTYPE;

BEGIN
	BEGIN
		SELECT
			*
		INTO lrT_DEPT_CODE_ORG
		FROM
			T_DEPT_CODE_ORG
		WHERE
			DEPT_CODE=AR_DEPT_CODE;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		--NULL;
		RAISE_APPLICATION_ERROR(-20009,'�������� �ʴ� �μ��ڵ��Դϴ�');
	END;
	
	IF lrT_DEPT_CODE_ORG.COST_DEPT_KND_TAG IS NULL THEN
		RAISE_APPLICATION_ERROR(-20009,'['||lrT_DEPT_CODE_ORG.DEPT_CODE||']'||lrT_DEPT_CODE_ORG.DEPT_NAME||'�� �������屸���� ��ϵ��� �ʾҽ��ϴ�.');
	END IF;
	
	BEGIN
		SELECT
			/*
			WORK_CODE,
			ACC_CODE,
			ACC_POSITION,
			SUMMARY_CODE,
			SUMMARY1,
			SUMMARY2,
			VAT_CODE,
			SEQ,
			USE_TAG
			*/
			*
		INTO lrT_WORK_ACC_CODE
		FROM
			T_WORK_ACC_CODE
		WHERE
			WORK_CODE=AR_WORK_CODE
			AND COST_DEPT_KND_TAG = lrT_DEPT_CODE_ORG.COST_DEPT_KND_TAG
			AND USE_TAG = 'T'
			AND ROWNUM=1;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		--NULL;
		RAISE_APPLICATION_ERROR(-20009,'�ش� �ڵ���ǥ�� ������������ ������ �� �����ϴ�.');
	END;

	BEGIN
		SELECT
			*
		INTO lrT_DEPT_CLASS_CODE
		FROM		  
			T_DEPT_CLASS_CODE
		WHERE
			DEPT_CODE = AR_DEPT_CODE
			AND DFLT_TAG='T';
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR(-20009,'�μ� �ι��ڵ尡 ��ϵ��� �ʽ��ϴ�.');
		--NULL;
	END;

	INSERT INTO T_WORK_ACC_SLIP_BODY
	(
		SLIP_ID,
		SLIP_IDSEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_CODE,
		ACC_CODE,
		SUMMARY_CODE,
		SUMMARY1,
		SUMMARY2,
		VAT_CODE,
		TAX_COMP_CODE,
		COMP_CODE,
		DEPT_CODE,
		CLASS_CODE
	)
	VALUES
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_WORK_CODE,
		lrT_WORK_ACC_CODE.ACC_CODE,
		lrT_WORK_ACC_CODE.SUMMARY_CODE,
		lrT_WORK_ACC_CODE.SUMMARY1,
		lrT_WORK_ACC_CODE.SUMMARY2,
		lrT_WORK_ACC_CODE.VAT_CODE,
		lrT_DEPT_CODE_ORG.TAX_COMP_CODE,
		lrT_DEPT_CODE_ORG.COMP_CODE,
		lrT_DEPT_CODE_ORG.DEPT_CODE,
		lrT_DEPT_CLASS_CODE.CLASS_CODE
	);
END;
/
