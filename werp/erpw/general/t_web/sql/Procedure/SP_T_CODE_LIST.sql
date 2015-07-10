Create Or Replace Procedure SP_T_CODE_LIST_I
(
	AR_CODE_GROUP_NO                           NUMBER,
	AR_CODE_LIST_ID                            VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CODE_LIST_NAME                          VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_USE_TAG                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_LIST_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_LIST ���̺� Insert
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_CODE_LIST
	(
		CODE_GROUP_NO,
		CODE_LIST_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CODE_LIST_NAME,
		SEQ,
		USE_TAG
	)
	Values
	(
		AR_CODE_GROUP_NO,
		AR_CODE_LIST_ID,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CODE_LIST_NAME,
		AR_SEQ,
		AR_USE_TAG
	);
End;
/
Create Or Replace Procedure SP_T_CODE_LIST_U
(
	AR_CODE_GROUP_NO                           NUMBER,
	AR_CODE_LIST_ID                            VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CODE_LIST_NAME                          VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_USE_TAG                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_LIST_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_LIST ���̺� Update
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_CODE_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CODE_LIST_NAME = AR_CODE_LIST_NAME,
		SEQ = AR_SEQ,
		USE_TAG = AR_USE_TAG
	Where	CODE_GROUP_NO = AR_CODE_GROUP_NO
	And	CODE_LIST_ID = AR_CODE_LIST_ID;
End;
/
Create Or Replace Procedure SP_T_CODE_LIST_D
(
	AR_CODE_GROUP_NO                           NUMBER,
	AR_CODE_LIST_ID                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_LIST_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_LIST ���̺� Delete
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_CODE_LIST
	Where	CODE_GROUP_NO = AR_CODE_GROUP_NO
	And	CODE_LIST_ID = AR_CODE_LIST_ID;
End;
/
