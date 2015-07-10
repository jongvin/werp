CREATE OR REPLACE PROCEDURE Sp_T_Card_Accounting_Detail
(
 AR_CARDNUMBER                          VARCHAR2,
 AR_ADJUSTYEARMONTH                VARCHAR2,
 AR_ACCTSUBSEQ                          NUMBER  ,
 AR_USAGEGUBUN                         VARCHAR2,
 AR_ACC_CODE                               VARCHAR2,
 AR_VAT_ACC_CODE                       VARCHAR2 DEFAULT NULL
)
IS
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CARD_ACCOUNTING_DETAIL
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CARD_ACCOUNTING_DETAIL ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-04)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
	Pamt              NUMBER:=0;
	Camt              NUMBER:=0;
BEGIN
	UPDATE T_CARD_ACCOUNTING_DETAIL
	SET
		USAGEGUBUN = AR_USAGEGUBUN,
		ACC_CODE   = AR_ACC_CODE,
		VAT_ACC_CODE   = AR_VAT_ACC_CODE
	WHERE
		CARDNUMBER      = AR_CARDNUMBER
		AND   ADJUSTYEARMONTH = AR_ADJUSTYEARMONTH
		AND   ACCTSUBSEQ      = AR_ACCTSUBSEQ ;
 
	SELECT
		SUM(DECODE(USAGEGUBUN ,'C', SUPPLYAMT + NVL(VATAMT,0),0)),
		SUM(DECODE(USAGEGUBUN ,'P', SUPPLYAMT + NVL(VATAMT,0),0))
	INTO
		Camt,
		Pamt
	FROM
		T_CARD_ACCOUNTING_DETAIL
	WHERE 
		CARDNUMBER = AR_CARDNUMBER
		AND ADJUSTYEARMONTH = AR_ADJUSTYEARMONTH ;
 
	UPDATE
		T_CARD_ACCOUNTING_MASTER
	SET
		COMPANYSUM  = Camt,
		PERSONSUM   = Pamt
	WHERE
		CARDNUMBER      = AR_CARDNUMBER
		AND   ADJUSTYEARMONTH = AR_ADJUSTYEARMONTH ;
 
END;
/
