Create Or Replace Procedure SP_T_CUST_ACCNO_CODE_I
(
	AR_CUST_SEQ                                NUMBER,
	AR_ACCNO                                   VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2,
	AR_ACCNO_CLS                               VARCHAR2,
	AR_USE_TG                                  VARCHAR2,
	AR_OUT_ACCNO                               VARCHAR2,
	AR_CLOSE_DT                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CUST_ACCNO_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CUST_ACCNO_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-02)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	If AR_ACCNO_CLS = '3' Then	--�����ڱ��� ���
		If AR_OUT_ACCNO Is Null Then
			Raise_Application_Error(-20009,'�����ڱ��� ���� ��� ������¸� �Է��Ͽ� �ֽʽÿ�.');
		End If;
	End If;
	Insert Into T_CUST_ACCNO_CODE
	(
		CUST_SEQ,
		ACCNO,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BANK_MAIN_CODE,
		ACCNO_OWNER,
		ACCNO_CLS,
		USE_TG,
		OUT_ACCNO,
		CLOSE_DT
	)
	Values
	(
		AR_CUST_SEQ,
		AR_ACCNO,
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BANK_MAIN_CODE,
		AR_ACCNO_OWNER,
		AR_ACCNO_CLS,
		AR_USE_TG,
		AR_OUT_ACCNO,
		F_T_StringToDate(AR_CLOSE_DT)
	);
End;
/
Create Or Replace Procedure SP_T_CUST_ACCNO_CODE_U
(
	AR_CUST_SEQ                                NUMBER,
	AR_ACCNO                                   VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2,
	AR_ACCNO_CLS                               VARCHAR2,
	AR_USE_TG                                  VARCHAR2,
	AR_OUT_ACCNO                               VARCHAR2,
	AR_CLOSE_DT                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CUST_ACCNO_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CUST_ACCNO_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-02)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	If AR_ACCNO_CLS = '3' Then	--�����ڱ��� ���
		If AR_OUT_ACCNO Is Null Then
			Raise_Application_Error(-20009,'�����ڱ��� ���� ��� ������¸� �Է��Ͽ� �ֽʽÿ�.');
		End If;
	End If;
	Update T_CUST_ACCNO_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BANK_MAIN_CODE = AR_BANK_MAIN_CODE,
		ACCNO_OWNER = AR_ACCNO_OWNER,
		ACCNO_CLS = AR_ACCNO_CLS,
		USE_TG = AR_USE_TG,
		OUT_ACCNO = AR_OUT_ACCNO,
		CLOSE_DT = F_T_StringToDate(AR_CLOSE_DT)
	Where	CUST_SEQ = AR_CUST_SEQ
	And	ACCNO = AR_ACCNO
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_CUST_ACCNO_CODE_D
(
	AR_CUST_SEQ                                NUMBER,
	AR_ACCNO                                   VARCHAR2,
	AR_SEQ                                     NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_CUST_ACCNO_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_CUST_ACCNO_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-03-02)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_CUST_ACCNO_CODE
	Where	CUST_SEQ = AR_CUST_SEQ
	And	ACCNO = AR_ACCNO
	And	SEQ = AR_SEQ;
End;
/
