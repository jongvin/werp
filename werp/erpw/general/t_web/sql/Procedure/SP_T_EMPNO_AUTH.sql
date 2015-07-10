Create Or Replace Procedure SP_T_EMPNO_AUTH_I
(
	AR_EMPNO                                   VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SLIP_TRANS_CLS                          VARCHAR2 Default 'F',
	AR_DEPT_CHG_CLS                            VARCHAR2 Default 'F',
	AR_ALL_DEPT_CLS                            VARCHAR2 Default 'F'
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_EMPNO_AUTH
	(
		EMPNO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SLIP_TRANS_CLS,
		DEPT_CHG_CLS,
		ALL_DEPT_CLS
	)
	Values
	(
		AR_EMPNO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		SubStrb(AR_SLIP_TRANS_CLS,1,1),
		SubStrb(AR_DEPT_CHG_CLS,1,1),
		SubStrb(AR_ALL_DEPT_CLS,1,1)
	);
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_U
(
	AR_EMPNO                                   VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SLIP_TRANS_CLS                          VARCHAR2 Default 'F',
	AR_DEPT_CHG_CLS                            VARCHAR2 Default 'F',
	AR_ALL_DEPT_CLS                            VARCHAR2 Default 'F'
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_EMPNO_AUTH
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SLIP_TRANS_CLS = SubStrb(AR_SLIP_TRANS_CLS,1,1),
		DEPT_CHG_CLS = SubStrb(AR_DEPT_CHG_CLS,1,1),
		ALL_DEPT_CLS = SubStrb(AR_ALL_DEPT_CLS,1,1)
	Where	EMPNO = AR_EMPNO;
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_D
(
	AR_EMPNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_EMPNO_AUTH_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_EMPNO_AUTH ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_EMPNO_AUTH
	Where	EMPNO = AR_EMPNO;
End;
/
