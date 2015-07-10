Create Or Replace Procedure SP_T_FIN_PAY_SAL_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_PAYGBN                                  VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_IGNORE_COMP_TAG                         VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_ACCNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_SAL_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_SAL ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_PAY_SAL
	(
		COMP_CODE,
		WORK_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_YM,
		WORK_DT,
		PAYGBN,
		CONTENTS,
		IGNORE_COMP_TAG,
		SLIP_ID,
		SLIP_IDSEQ,
		ACCNO
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_YMTOSTRINGFORMAT(AR_WORK_YM),
		F_T_StringToDate(AR_WORK_DT),
		AR_PAYGBN,
		AR_CONTENTS,
		AR_IGNORE_COMP_TAG,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_ACCNO
	);
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SAL_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_PAYGBN                                  VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_IGNORE_COMP_TAG                         VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_ACCNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_SAL_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_SAL ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Update T_FIN_PAY_SAL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_YM = F_T_YMTOSTRINGFORMAT(AR_WORK_YM),
		WORK_DT = F_T_StringToDate(AR_WORK_DT),
		PAYGBN = AR_PAYGBN,
		CONTENTS = AR_CONTENTS,
		IGNORE_COMP_TAG = AR_IGNORE_COMP_TAG,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		ACCNO = AR_ACCNO
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_SEQ = AR_WORK_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SAL_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_SAL_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_PAY_SAL ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-03)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Delete T_FIN_PAY_SAL
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_SEQ = AR_WORK_SEQ;
End;
/
