Create Or Replace Procedure SP_T_FB_ACCOUNTS_PWD_I
(
	AR_ACCOUNT_NO                              VARCHAR2,
	AR_CHANGE_YMD                              VARCHAR2,
	AR_OLD_PASSWORD                            VARCHAR2,
	AR_NEW_PASSWORD                            VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_ACCOUNTS_PWD_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_ACCOUNTS_PWD ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FB_ACCOUNTS_PWD
	(
		ACCOUNT_NO,
		CHANGE_YMD,
		OLD_PASSWORD,
		NEW_PASSWORD,
		CREATION_DATE,
		CREATION_EMP_NO,
		LAST_MODIFY_DATE,
		LAST_MODIFY_EMP_NO
	)
	Values
	(
		AR_ACCOUNT_NO,
		To_Char(SysDate,'YYYYMMDD'),
		AR_OLD_PASSWORD,
		AR_NEW_PASSWORD,
		SysDate,
		AR_CREATION_EMP_NO,
		Null,
		AR_LAST_MODIFY_EMP_NO
	);
End;
/
Create Or Replace Procedure SP_T_FB_ACCOUNTS_PWD_U
(
	AR_ACCOUNT_NO                              VARCHAR2,
	AR_CHANGE_YMD                              VARCHAR2,
	AR_OLD_PASSWORD                            VARCHAR2,
	AR_NEW_PASSWORD                            VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_ACCOUNTS_PWD_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_ACCOUNTS_PWD ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FB_ACCOUNTS_PWD
	(
		ACCOUNT_NO,
		CHANGE_YMD,
		OLD_PASSWORD,
		NEW_PASSWORD,
		CREATION_DATE,
		CREATION_EMP_NO,
		LAST_MODIFY_DATE,
		LAST_MODIFY_EMP_NO
	)
	Values
	(
		AR_ACCOUNT_NO,
		To_Char(SysDate,'YYYYMMDD'),
		AR_OLD_PASSWORD,
		AR_NEW_PASSWORD,
		SysDate,
		AR_CREATION_EMP_NO,
		Null,
		AR_LAST_MODIFY_EMP_NO
	);
Exception When Dup_Val_On_Index Then
	Update T_FB_ACCOUNTS_PWD
	Set
		CHANGE_YMD = AR_CHANGE_YMD,
		OLD_PASSWORD = AR_OLD_PASSWORD,
		NEW_PASSWORD = AR_NEW_PASSWORD,
		LAST_MODIFY_DATE = SysDate,
		LAST_MODIFY_EMP_NO = AR_LAST_MODIFY_EMP_NO
	Where	ACCOUNT_NO = AR_ACCOUNT_NO;
End;
/
Create Or Replace Procedure SP_T_FB_ACCOUNTS_PWD_D
(
	AR_ACCOUNT_NO                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FB_ACCOUNTS_PWD_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FB_ACCOUNTS_PWD ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-19)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FB_ACCOUNTS_PWD
	Where	ACCOUNT_NO = AR_ACCOUNT_NO;
End;
/
