Create Or Replace Procedure SP_T_FB_LOOKUP_VALUES_I
(
	AR_LOOKUP_TYPE                             VARCHAR2,
	AR_LOOKUP_CODE                             VARCHAR2,
	AR_LOOKUP_VALUE                            VARCHAR2,
	AR_USE_YN                                  VARCHAR2,
	AR_DESCRIPTION                             VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_ATTRIBUTE4                              VARCHAR2,
	AR_ATTRIBUTE5                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_LOOKUP_VALUES_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_LOOKUP_VALUES ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FB_LOOKUP_VALUES
	(
		LOOKUP_TYPE,
		LOOKUP_CODE,
		LOOKUP_VALUE,
		USE_YN,
		DESCRIPTION,
		CREATION_DATE,
		CREATION_EMP_NO,
		LAST_MODIFY_DATE,
		LAST_MODIFY_EMP_NO,
		ATTRIBUTE1,
		ATTRIBUTE2,
		ATTRIBUTE3,
		ATTRIBUTE4,
		ATTRIBUTE5
	)
	Values
	(
		AR_LOOKUP_TYPE,
		AR_LOOKUP_CODE,
		AR_LOOKUP_VALUE,
		Decode(AR_USE_YN,'T','Y','F','N'),
		AR_DESCRIPTION,
		SysDate,
		AR_CREATION_EMP_NO,
		Null,
		Null,
		AR_ATTRIBUTE1,
		AR_ATTRIBUTE2,
		AR_ATTRIBUTE3,
		AR_ATTRIBUTE4,
		AR_ATTRIBUTE5
	);
End;
/
Create Or Replace Procedure SP_T_FB_LOOKUP_VALUES_U
(
	AR_LOOKUP_TYPE                             VARCHAR2,
	AR_LOOKUP_CODE                             VARCHAR2,
	AR_LOOKUP_VALUE                            VARCHAR2,
	AR_USE_YN                                  VARCHAR2,
	AR_DESCRIPTION                             VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_ATTRIBUTE4                              VARCHAR2,
	AR_ATTRIBUTE5                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_LOOKUP_VALUES_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_LOOKUP_VALUES ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FB_LOOKUP_VALUES
	Set
		LOOKUP_VALUE = AR_LOOKUP_VALUE,
		USE_YN = Decode(AR_USE_YN,'T','Y','F','N'),
		DESCRIPTION = AR_DESCRIPTION,
		LAST_MODIFY_DATE = SysDate,
		LAST_MODIFY_EMP_NO = AR_LAST_MODIFY_EMP_NO,
		ATTRIBUTE1 = AR_ATTRIBUTE1,
		ATTRIBUTE2 = AR_ATTRIBUTE2,
		ATTRIBUTE3 = AR_ATTRIBUTE3,
		ATTRIBUTE4 = AR_ATTRIBUTE4,
		ATTRIBUTE5 = AR_ATTRIBUTE5
	Where	LOOKUP_TYPE = AR_LOOKUP_TYPE
	And	LOOKUP_CODE = AR_LOOKUP_CODE;
End;
/
Create Or Replace Procedure SP_T_FB_LOOKUP_VALUES_D
(
	AR_LOOKUP_TYPE                             VARCHAR2,
	AR_LOOKUP_CODE                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_LOOKUP_VALUES_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_LOOKUP_VALUES ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FB_LOOKUP_VALUES
	Where	LOOKUP_TYPE = AR_LOOKUP_TYPE
	And	LOOKUP_CODE = AR_LOOKUP_CODE;
End;
/
