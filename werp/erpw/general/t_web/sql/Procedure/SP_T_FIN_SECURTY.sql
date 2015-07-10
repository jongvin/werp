Create Or Replace Procedure SP_T_FIN_SECURTY_I
(
	AR_SECU_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SEC_KIND_CODE                           VARCHAR2,
	AR_REAL_SECU_NO                            VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_RESET_SLIP_ID                           NUMBER,
	AR_RESET_SLIP_IDSEQ                        NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_GET_DT                                  VARCHAR2,
	AR_GET_PLACE                               VARCHAR2,
	AR_PERSTOCK_AMT                            NUMBER,
	AR_INCOME_AMT                              NUMBER,
	AR_BF_GET_ITR_AMT                          NUMBER,
	AR_GET_ITR_AMT                             NUMBER,
	AR_SALE_AMT                                NUMBER,
	AR_PUBL_DT                                 VARCHAR2,
	AR_ITR_TAG                                 VARCHAR2,
	AR_INTR_RATE                               NUMBER,
	AR_EXPR_DT                                 VARCHAR2,
	AR_SALE_DT                                 VARCHAR2,
	AR_RETURN_DT                               VARCHAR2,
	AR_CONSIGN_BANK                            VARCHAR2,
	AR_SALE_ITR_AMT                            NUMBER,
	AR_SALE_TAX                                NUMBER,
	AR_SALE_LOSS                               NUMBER,
	AR_SALE_NP_ITR_AMT                         NUMBER,
	AR_BF_GET_ITR_TAX                          NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SECURTY_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SECURTY ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SECURTY
	(
		SECU_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SEC_KIND_CODE,
		REAL_SECU_NO,
		SLIP_ID,
		SLIP_IDSEQ,
		RESET_SLIP_ID,
		RESET_SLIP_IDSEQ,
		COMP_CODE,
		GET_DT,
		GET_PLACE,
		PERSTOCK_AMT,
		INCOME_AMT,
		BF_GET_ITR_AMT,
		GET_ITR_AMT,
		SALE_AMT,
		PUBL_DT,
		ITR_TAG,
		INTR_RATE,
		EXPR_DT,
		SALE_DT,
		RETURN_DT,
		CONSIGN_BANK,
		SALE_ITR_AMT,
		SALE_TAX,
		SALE_LOSS,
		SALE_NP_ITR_AMT,
		BF_GET_ITR_TAX
	)
	Values
	(
		AR_SECU_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SEC_KIND_CODE,
		AR_REAL_SECU_NO,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_RESET_SLIP_ID,
		AR_RESET_SLIP_IDSEQ,
		AR_COMP_CODE,
		F_T_StringToDate(AR_GET_DT),
		AR_GET_PLACE,
		AR_PERSTOCK_AMT,
		AR_INCOME_AMT,
		AR_BF_GET_ITR_AMT,
		AR_GET_ITR_AMT,
		AR_SALE_AMT,
		F_T_StringToDate(AR_PUBL_DT),
		AR_ITR_TAG,
		AR_INTR_RATE,
		F_T_StringToDate(AR_EXPR_DT),
		F_T_StringToDate(AR_SALE_DT),
		F_T_StringToDate(AR_RETURN_DT),
		AR_CONSIGN_BANK,
		AR_SALE_ITR_AMT,
		AR_SALE_TAX,
		AR_SALE_LOSS,
		AR_SALE_NP_ITR_AMT,
		AR_BF_GET_ITR_TAX
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SECURTY_U
(
	AR_SECU_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_SEC_KIND_CODE                           VARCHAR2,
	AR_REAL_SECU_NO                            VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_RESET_SLIP_ID                           NUMBER,
	AR_RESET_SLIP_IDSEQ                        NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_GET_DT                                  VARCHAR2,
	AR_GET_PLACE                               VARCHAR2,
	AR_PERSTOCK_AMT                            NUMBER,
	AR_INCOME_AMT                              NUMBER,
	AR_BF_GET_ITR_AMT                          NUMBER,
	AR_GET_ITR_AMT                             NUMBER,
	AR_SALE_AMT                                NUMBER,
	AR_PUBL_DT                                 VARCHAR2,
	AR_ITR_TAG                                 VARCHAR2,
	AR_INTR_RATE                               NUMBER,
	AR_EXPR_DT                                 VARCHAR2,
	AR_SALE_DT                                 VARCHAR2,
	AR_RETURN_DT                               VARCHAR2,
	AR_CONSIGN_BANK                            VARCHAR2,
	AR_SALE_ITR_AMT                            NUMBER,
	AR_SALE_TAX                                NUMBER,
	AR_SALE_LOSS                               NUMBER,
	AR_SALE_NP_ITR_AMT                         NUMBER,
	AR_BF_GET_ITR_TAX                          NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SECURTY_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SECURTY ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_SECURTY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SEC_KIND_CODE = AR_SEC_KIND_CODE,
		REAL_SECU_NO = AR_REAL_SECU_NO,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		RESET_SLIP_ID = AR_RESET_SLIP_ID,
		RESET_SLIP_IDSEQ = AR_RESET_SLIP_IDSEQ,
		COMP_CODE = AR_COMP_CODE,
		GET_DT = F_T_StringToDate(AR_GET_DT),
		GET_PLACE = AR_GET_PLACE,
		PERSTOCK_AMT = AR_PERSTOCK_AMT,
		INCOME_AMT = AR_INCOME_AMT,
		BF_GET_ITR_AMT = AR_BF_GET_ITR_AMT,
		GET_ITR_AMT = AR_GET_ITR_AMT,
		SALE_AMT = AR_SALE_AMT,
		PUBL_DT = F_T_StringToDate(AR_PUBL_DT),
		ITR_TAG = AR_ITR_TAG,
		INTR_RATE = AR_INTR_RATE,
		EXPR_DT = F_T_StringToDate(AR_EXPR_DT),
		SALE_DT = F_T_StringToDate(AR_SALE_DT),
		RETURN_DT = F_T_StringToDate(AR_RETURN_DT),
		CONSIGN_BANK = AR_CONSIGN_BANK,
		SALE_ITR_AMT = AR_SALE_ITR_AMT,
		SALE_TAX = AR_SALE_TAX,
		SALE_LOSS = AR_SALE_LOSS,
		SALE_NP_ITR_AMT = AR_SALE_NP_ITR_AMT,
		BF_GET_ITR_TAX = AR_BF_GET_ITR_TAX
	Where	SECU_NO = AR_SECU_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_SECURTY_D
(
	AR_SECU_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SECURTY_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SECURTY ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lnCnt					Number;
	lrRec					T_FIN_SECURTY%rowType;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_FIN_SEC_ITR_AMT
	Where	SECU_NO = AR_SECU_NO
	And		SLIP_ID Is Not Null;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'�ش� ���������� �̼����� ��ǥ�� ����� ���� �����Ƿ� ������ �Ұ����մϴ�.');
	End If;
	Select
		*
	Into
		lrRec
	From	T_FIN_SECURTY
	Where	SECU_NO = AR_SECU_NO;
	If lrRec.SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'���� ���� ��ǥ��ȣ�� �ִ� ���� �����Ͻ� �� �����ϴ�.');
	End If;
	If lrRec.RESET_SLIP_ID Is Not Null Then
		Raise_Application_Error(-20009,'���� ���� ��ǥ��ȣ�� �ִ� ���� �����Ͻ� �� �����ϴ�.');
	End If;
	Delete T_FIN_SEC_ITR_AMT
	Where	SECU_NO = AR_SECU_NO;
	Delete T_FIN_SECURTY
	Where	SECU_NO = AR_SECU_NO;
End;
/
