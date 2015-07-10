CREATE OR REPLACE PROCEDURE Sp_T_Acc_Tax_Bill_Batch02
(
	AR_COMP_CODE                             VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_CRTUSERNO                             VARCHAR2
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_TAX_BILL_MEDIA_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_ACC_TAX_BILL_MEDIA ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-16)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
lrT_ACC_SLIP_BILL_HEAD T_ACC_SLIP_BILL_HEAD%ROWTYPE;
lnSEQ T_ACC_TAX_BILL_MEDIA.SEQ%TYPE;
BEGIN
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
		RAISE_APPLICATION_ERROR	(-20009, '�ش� �����Ű����� ã�� �� �����ϴ�.');
	END;

	FOR lrA IN
	(
		SELECT
			COMP_CODE,
			WORK_NO,
			SEQ
		FROM
			T_ACC_TAX_BILL_MEDIA
		WHERE
			COMP_CODE =   lrT_ACC_SLIP_BILL_HEAD.COMP_CODE
		  	AND WORK_NO = lrT_ACC_SLIP_BILL_HEAD.WORK_NO
	)
	LOOP
		BEGIN
			Sp_T_Acc_Tax_Bill_Media_D( lrA.COMP_CODE, lrA.WORK_NO, lrA.SEQ );
		END;
	END LOOP;

END;
/
