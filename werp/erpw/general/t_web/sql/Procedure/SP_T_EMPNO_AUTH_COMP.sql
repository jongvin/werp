Create Or Replace Procedure SP_T_EMPNO_AUTH_COMP_I
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_COMP_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH_COMP ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_EMPNO_AUTH_COMP
	(
		EMPNO,
		COMP_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_EMPNO,
		AR_COMP_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_COMP_U
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_COMP_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH_COMP ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_EMPNO_AUTH_COMP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	EMPNO = AR_EMPNO
	And	COMP_CODE = AR_COMP_CODE;
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_COMP_D
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_COMP_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH_COMP ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_EMPNO_AUTH_DEPT
	Where	EMPNO = AR_EMPNO
	And	COMP_CODE = AR_COMP_CODE;

	Delete T_EMPNO_AUTH_COMP
	Where	EMPNO = AR_EMPNO
	And	COMP_CODE = AR_COMP_CODE;
End;
/
