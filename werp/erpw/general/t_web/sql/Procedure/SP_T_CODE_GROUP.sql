Create Or Replace Procedure SP_T_CODE_GROUP_I
(
	AR_CODE_GROUP_NO                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CODE_GROUP_ID                           VARCHAR2,
	AR_CODE_GROUP_NAME                         VARCHAR2,
	AR_FLEX_FIELD                              VARCHAR2,
	AR_OPEN_TAG                                VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_GROUP_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_GROUP ���̺� Insert
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_CODE_GROUP
	(
		CODE_GROUP_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CODE_GROUP_ID,
		CODE_GROUP_NAME,
		FLEX_FIELD,
		OPEN_TAG,
		REMARK
	)
	Values
	(
		AR_CODE_GROUP_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CODE_GROUP_ID,
		AR_CODE_GROUP_NAME,
		AR_FLEX_FIELD,
		AR_OPEN_TAG,
		AR_REMARK
	);
End;
/
Create Or Replace Procedure SP_T_CODE_GROUP_U
(
	AR_CODE_GROUP_NO                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CODE_GROUP_ID                           VARCHAR2,
	AR_CODE_GROUP_NAME                         VARCHAR2,
	AR_FLEX_FIELD                              VARCHAR2,
	AR_OPEN_TAG                                VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_GROUP_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_GROUP ���̺� Update
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_CODE_GROUP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CODE_GROUP_ID = AR_CODE_GROUP_ID,
		CODE_GROUP_NAME = AR_CODE_GROUP_NAME,
		FLEX_FIELD = AR_FLEX_FIELD,
		OPEN_TAG = AR_OPEN_TAG,
		REMARK = AR_REMARK
	Where	CODE_GROUP_NO = AR_CODE_GROUP_NO;
End;
/
Create Or Replace Procedure SP_T_CODE_GROUP_D
(
	AR_CODE_GROUP_NO                           NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CODE_GROUP_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CODE_GROUP ���̺� Delete
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-11-07)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_CODE_GROUP
	Where	CODE_GROUP_NO = AR_CODE_GROUP_NO;
End;
/
