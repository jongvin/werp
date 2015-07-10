Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_CODE_I
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SUM_TAR_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_SUM_TAR_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_SUM_TAR_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_PL_MA_SUM_TAR_CODE
	(
		SUM_TAR_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SUM_TAR_NAME
	)
	Values
	(
		AR_SUM_TAR_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SUM_TAR_NAME
	);
End;
/
Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_CODE_U
(
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SUM_TAR_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_SUM_TAR_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_SUM_TAR_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_PL_MA_SUM_TAR_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SUM_TAR_NAME = AR_SUM_TAR_NAME
	Where	SUM_TAR_CODE = AR_SUM_TAR_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_MA_SUM_TAR_CODE_D
(
	AR_SUM_TAR_CODE                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_SUM_TAR_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_SUM_TAR_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_PL_MA_SUM_TAR_CODE
	Where	SUM_TAR_CODE = AR_SUM_TAR_CODE;
End;
/