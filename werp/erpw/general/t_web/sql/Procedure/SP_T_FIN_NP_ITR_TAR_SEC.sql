Create Or Replace Procedure SP_T_FIN_NP_ITR_TAR_SEC_I
(
	AR_WORK_NO                                 NUMBER,
	AR_SECU_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITR_CALC_NO                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_NP_ITR_TAR_SEC_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_NP_ITR_TAR_SEC ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_NP_ITR_TAR_SEC
	(
		WORK_NO,
		SECU_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITR_CALC_NO
	)
	Values
	(
		AR_WORK_NO,
		AR_SECU_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITR_CALC_NO
	);
End;
/
Create Or Replace Procedure SP_T_FIN_NP_ITR_TAR_SEC_U
(
	AR_WORK_NO                                 NUMBER,
	AR_SECU_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITR_CALC_NO                             NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_NP_ITR_TAR_SEC_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_NP_ITR_TAR_SEC ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_NP_ITR_TAR_SEC
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITR_CALC_NO = AR_ITR_CALC_NO
	Where	WORK_NO = AR_WORK_NO
	And	SECU_NO = AR_SECU_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_NP_ITR_TAR_SEC_D
(
	AR_WORK_NO                                 NUMBER,
	AR_SECU_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_NP_ITR_TAR_SEC_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_NP_ITR_TAR_SEC ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-27)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec									T_FIN_NP_ITR_TAR_SEC%RowType;
Begin
	Select
		*
	Into
		lrRec
	From	T_FIN_NP_ITR_TAR_SEC
	Where	WORK_NO = AR_WORK_NO
	And		SECU_NO = AR_SECU_NO;

	Delete T_FIN_NP_ITR_TAR_SEC
	Where	WORK_NO = AR_WORK_NO
	And	SECU_NO = AR_SECU_NO;

	Delete	T_FIN_SEC_ITR_AMT
	Where	SECU_NO = lrRec.SECU_NO
	And		ITR_CALC_NO = lrRec.ITR_CALC_NO;
End;
/
