Create Or Replace Procedure SP_T_FIN_BILL_CHG_LIST_I
(
	AR_CHK_BILL_NO                             VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CHG_DT                                  VARCHAR2,
	AR_CHG_EXPR_DT                             VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_BILL_CHG_LIST_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_BILL_CHG_LIST ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_BILL_CHG_LIST
	(
		CHK_BILL_NO,
		CHG_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHG_DT,
		CHG_EXPR_DT,
		REMARKS
	)
	Values
	(
		AR_CHK_BILL_NO,
		AR_CHG_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_CHG_DT),
		F_T_StringToDate(AR_CHG_EXPR_DT),
		AR_REMARKS
	);
	SP_T_FIN_UPDATE_CHG_EXPR_DT(AR_CHK_BILL_NO);
End;
/
Create Or Replace Procedure SP_T_FIN_BILL_CHG_LIST_U
(
	AR_CHK_BILL_NO                             VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CHG_DT                                  VARCHAR2,
	AR_CHG_EXPR_DT                             VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_BILL_CHG_LIST_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_BILL_CHG_LIST ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_BILL_CHG_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CHG_DT = F_T_StringToDate(AR_CHG_DT),
		CHG_EXPR_DT = F_T_StringToDate(AR_CHG_EXPR_DT),
		REMARKS = AR_REMARKS
	Where	CHK_BILL_NO = AR_CHK_BILL_NO
	And	CHG_SEQ = AR_CHG_SEQ;
	SP_T_FIN_UPDATE_CHG_EXPR_DT(AR_CHK_BILL_NO);
End;
/
Create Or Replace Procedure SP_T_FIN_BILL_CHG_LIST_D
(
	AR_CHK_BILL_NO                             VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_BILL_CHG_LIST_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_BILL_CHG_LIST ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-12-22)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_BILL_CHG_LIST
	Where	CHK_BILL_NO = AR_CHK_BILL_NO
	And	CHG_SEQ = AR_CHG_SEQ;
	SP_T_FIN_UPDATE_CHG_EXPR_DT(AR_CHK_BILL_NO);
End;
/
