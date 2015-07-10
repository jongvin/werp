Create Or Replace Procedure SP_T_FL_LOAN_KIND_CODE_I
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FL_LOAN_KIND_NAME                       VARCHAR2,
	AR_FL_LOAN_KIND_TAG				   VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_LOAN_KIND_CODE_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_LOAN_KIND_CODE ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FL_LOAN_KIND_CODE
	(
		FL_LOAN_KIND_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		FL_LOAN_KIND_NAME,
		FL_LOAN_KIND_TAG
	)
	Values
	(
		AR_FL_LOAN_KIND_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_FL_LOAN_KIND_NAME,
		AR_FL_LOAN_KIND_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FL_LOAN_KIND_CODE_U
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2,
	AR_MODUSERNO                                    VARCHAR2,
	AR_FL_LOAN_KIND_NAME                       VARCHAR2,
	AR_FL_LOAN_KIND_TAG				   VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_LOAN_KIND_CODE_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_LOAN_KIND_CODE ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FL_LOAN_KIND_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FL_LOAN_KIND_NAME = AR_FL_LOAN_KIND_NAME,
		FL_LOAN_KIND_TAG	 = AR_FL_LOAN_KIND_TAG	
	Where	FL_LOAN_KIND_CODE = AR_FL_LOAN_KIND_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_LOAN_KIND_CODE_D
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FL_LOAN_KIND_CODE_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FL_LOAN_KIND_CODE ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-24)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FL_LOAN_KIND_CODE
	Where	FL_LOAN_KIND_CODE = AR_FL_LOAN_KIND_CODE;
End;
/
