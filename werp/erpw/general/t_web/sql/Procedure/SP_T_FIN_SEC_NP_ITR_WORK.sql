Create Or Replace Procedure SP_T_FIN_SEC_NP_ITR_WORK_I
(
	AR_WORK_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_DESCRIPTION                             VARCHAR2,
	AR_CALC_DT_FROM                            VARCHAR2,
	AR_CALC_DT_TO                              VARCHAR2,
	AR_TARGET_COMP_CODE                        VARCHAR2,
	AR_NP_ITR_AMT                              NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SEC_NP_ITR_WORK_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SEC_NP_ITR_WORK ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SEC_NP_ITR_WORK
	(
		WORK_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_DT,
		DESCRIPTION,
		CALC_DT_FROM,
		CALC_DT_TO,
		TARGET_COMP_CODE,
		NP_ITR_AMT,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Values
	(
		AR_WORK_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_WORK_DT),
		AR_DESCRIPTION,
		F_T_StringToDate(AR_CALC_DT_FROM),
		F_T_StringToDate(AR_CALC_DT_TO),
		AR_TARGET_COMP_CODE,
		AR_NP_ITR_AMT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SEC_NP_ITR_WORK_U
(
	AR_WORK_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_DESCRIPTION                             VARCHAR2,
	AR_CALC_DT_FROM                            VARCHAR2,
	AR_CALC_DT_TO                              VARCHAR2,
	AR_TARGET_COMP_CODE                        VARCHAR2,
	AR_NP_ITR_AMT                              NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SEC_NP_ITR_WORK_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SEC_NP_ITR_WORK ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec					T_FIN_SEC_NP_ITR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	WORK_NO = AR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'��ǥ�� ����� �ڷ�� �����Ͻ� �� �����ϴ�.');
		End If;
	Exception When No_Data_Found Then
		Null;
	End;
	Update T_FIN_SEC_NP_ITR_WORK
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_DT = F_T_StringToDate(AR_WORK_DT),
		DESCRIPTION = AR_DESCRIPTION,
		CALC_DT_FROM = F_T_StringToDate(AR_CALC_DT_FROM),
		CALC_DT_TO = F_T_StringToDate(AR_CALC_DT_TO),
		TARGET_COMP_CODE = AR_TARGET_COMP_CODE,
		NP_ITR_AMT = AR_NP_ITR_AMT
	Where	WORK_NO = AR_WORK_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_SEC_NP_ITR_WORK_D
(
	AR_WORK_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_SEC_NP_ITR_WORK_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_FIN_SEC_NP_ITR_WORK ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-26)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec					T_FIN_SEC_NP_ITR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_SEC_NP_ITR_WORK
		Where	WORK_NO = AR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'��ǥ�� ����� �ڷ�� �����Ͻ� �� �����ϴ�.');
		End If;
	Exception When No_Data_Found Then
		Null;
	End;
	Delete T_FIN_SEC_NP_ITR_WORK
	Where	WORK_NO = AR_WORK_NO;
End;
/
