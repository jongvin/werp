Create Or Replace Procedure SP_T_EMPNO_AUTH_DEPT_I
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_DEPT_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH_DEPT ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_EMPNO_AUTH_DEPT
	(
		EMPNO,
		COMP_CODE,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_EMPNO,
		AR_COMP_CODE,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_DEPT_U
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_DEPT_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH_DEPT ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_EMPNO_AUTH_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	EMPNO = AR_EMPNO
	And	COMP_CODE = AR_COMP_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_DEPT_D
(
	AR_EMPNO                                   VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_DEPT_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH_DEPT ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_EMPNO_AUTH_DEPT
	Where	EMPNO = AR_EMPNO
	And	COMP_CODE = AR_COMP_CODE
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
