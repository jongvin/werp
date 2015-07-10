Create Or Replace Procedure SP_T_AUTO_BILL_FIX_GET_I
(
	AR_AUTO_B_F_GET_SEQ                        NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_GET_AMT                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_GET_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_GET ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_BILL_FIX_GET
	(
		AUTO_B_F_GET_SEQ,
		FIX_ASSET_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		GET_AMT
	)
	Values
	(
		AR_AUTO_B_F_GET_SEQ,
		AR_FIX_ASSET_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_GET_AMT
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_GET_U
(
	AR_AUTO_B_F_GET_SEQ                        NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_GET_AMT                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_GET_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_GET ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_AUTO_BILL_FIX_GET
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		GET_AMT = AR_GET_AMT
	Where	AUTO_B_F_GET_SEQ = AR_AUTO_B_F_GET_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_GET_D
(
	AR_AUTO_B_F_GET_SEQ                        NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_GET_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_GET ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-02-06)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_AUTO_BILL_FIX_GET
	Where	AUTO_B_F_GET_SEQ = AR_AUTO_B_F_GET_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
