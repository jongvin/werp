Create Or Replace Procedure SP_T_PL_MA_USER_FUNCTIONS_I
(
	AR_FUNC_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_USER_FUNCTIONS_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_USER_FUNCTIONS ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_PL_MA_USER_FUNCTIONS
	(
		FUNC_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		FUNC_TITLE,
		FUNC_NAME,
		AUTO_RECALCC_TAG
	)
	Values
	(
		AR_FUNC_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_FUNC_TITLE,
		AR_FUNC_NAME,
		AR_AUTO_RECALCC_TAG
	);
End;
/
Create Or Replace Procedure SP_T_PL_MA_USER_FUNCTIONS_U
(
	AR_FUNC_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_FUNC_TITLE                              VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2,
	AR_AUTO_RECALCC_TAG                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_USER_FUNCTIONS_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_USER_FUNCTIONS ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_PL_MA_USER_FUNCTIONS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FUNC_TITLE = AR_FUNC_TITLE,
		FUNC_NAME = AR_FUNC_NAME,
		AUTO_RECALCC_TAG = AR_AUTO_RECALCC_TAG
	Where	FUNC_NO = AR_FUNC_NO;
End;
/
Create Or Replace Procedure SP_T_PL_MA_USER_FUNCTIONS_D
(
	AR_FUNC_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_PL_MA_USER_FUNCTIONS_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_PL_MA_USER_FUNCTIONS ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_PL_MA_USER_FUNCTIONS
	Where	FUNC_NO = AR_FUNC_NO;
End;
/
