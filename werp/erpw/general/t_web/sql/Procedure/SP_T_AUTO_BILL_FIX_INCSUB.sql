Create Or Replace Procedure SP_T_AUTO_BILL_FIX_INCSUB_I
(
	AR_AUTO_B_F_INCSUB_SEQ                     NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_INCREDU_SEQ                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_INCSUB_AMT                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_INCSUB_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_INCSUB ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_BILL_FIX_INCSUB
	(
		AUTO_B_F_INCSUB_SEQ,
		FIX_ASSET_SEQ,
		INCREDU_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		INCSUB_AMT
	)
	Values
	(
		AR_AUTO_B_F_INCSUB_SEQ,
		AR_FIX_ASSET_SEQ,
		AR_INCREDU_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_INCSUB_AMT
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_INCSUB_U
(
	AR_AUTO_B_F_INCSUB_SEQ                     NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_INCREDU_SEQ                             NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_INCSUB_AMT                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_INCSUB_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_INCSUB ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_AUTO_BILL_FIX_INCSUB
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		INCSUB_AMT = AR_INCSUB_AMT
	Where	AUTO_B_F_INCSUB_SEQ = AR_AUTO_B_F_INCSUB_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And	INCREDU_SEQ = AR_INCREDU_SEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_INCSUB_D
(
	AR_AUTO_B_F_INCSUB_SEQ                     NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_INCREDU_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_AUTO_BILL_FIX_INCSUB_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_AUTO_BILL_FIX_INCSUB ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-02-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_AUTO_BILL_FIX_INCSUB
	Where	AUTO_B_F_INCSUB_SEQ = AR_AUTO_B_F_INCSUB_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And	INCREDU_SEQ = AR_INCREDU_SEQ;
End;
/
