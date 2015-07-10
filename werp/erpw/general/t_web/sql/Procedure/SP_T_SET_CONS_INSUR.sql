Create Or Replace Procedure SP_T_SET_CONS_INSUR_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_INSUR_NO                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_INSUR_DT_F                              VARCHAR2,
	AR_INSUR_DT_T                              VARCHAR2,
	AR_INSUR_AMT                               NUMBER,
	AR_MONTH_DEC_AMT                           NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_REMARKS                                 VARCHAR2,
	AR_SLIP_MAKE_DT                            VARCHAR2,
	AR_CUST_SEQ                                Number
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_CONS_INSUR_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_CONS_INSUR ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
Begin
	Insert Into T_SET_CONS_INSUR
	(
		DEPT_CODE,
		INSUR_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		INSUR_DT_F,
		INSUR_DT_T,
		INSUR_AMT,
		MONTH_DEC_AMT,
		SLIP_ID,
		SLIP_IDSEQ,
		REMARKS,
		SLIP_MAKE_DT,
		CUST_SEQ
	)
	Values
	(
		AR_DEPT_CODE,
		AR_INSUR_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_INSUR_DT_F),
		F_T_StringToDate(AR_INSUR_DT_T),
		AR_INSUR_AMT,
		AR_MONTH_DEC_AMT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_REMARKS,
		F_T_StringToDate(AR_SLIP_MAKE_DT),
		AR_CUST_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_SET_CONS_INSUR_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_INSUR_NO                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_INSUR_DT_F                              VARCHAR2,
	AR_INSUR_DT_T                              VARCHAR2,
	AR_INSUR_AMT                               NUMBER,
	AR_MONTH_DEC_AMT                           NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_REMARKS                                 VARCHAR2,
	AR_SLIP_MAKE_DT                            VARCHAR2,
	AR_CUST_SEQ                                Number
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_CONS_INSUR_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_CONS_INSUR ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec									T_SET_CONS_INSUR%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR
		Where	DEPT_CODE = AR_DEPT_CODE
		And	INSUR_NO = AR_INSUR_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'��ǥ�� ����� ���� ������ �Ұ����մϴ�.');
		End If;
	Exception When No_Data_Found Then
		Null;
	End;
	Update T_SET_CONS_INSUR
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		INSUR_DT_F = F_T_StringToDate(AR_INSUR_DT_F),
		INSUR_DT_T = F_T_StringToDate(AR_INSUR_DT_T),
		INSUR_AMT = AR_INSUR_AMT,
		MONTH_DEC_AMT = AR_MONTH_DEC_AMT,
		REMARKS = AR_REMARKS,
		SLIP_MAKE_DT = F_T_StringToDate(AR_SLIP_MAKE_DT),
		CUST_SEQ = AR_CUST_SEQ
	Where	DEPT_CODE = AR_DEPT_CODE
	And	INSUR_NO = AR_INSUR_NO;
End;
/
Create Or Replace Procedure SP_T_SET_CONS_INSUR_D
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_INSUR_NO                                NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_CONS_INSUR_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_CONS_INSUR ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec									T_SET_CONS_INSUR%RowType;
	lnCount									Number;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR
		Where	DEPT_CODE = AR_DEPT_CODE
		And	INSUR_NO = AR_INSUR_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'��ǥ�� ����� ���� ������ �Ұ����մϴ�.');
		End If;
	Exception When No_Data_Found Then
		Null;
	End;
	Select
		Count(*)
	Into
		lnCount
	From	T_SET_CONS_INSUR_DEC_AMT
	Where	DEPT_CODE = AR_DEPT_CODE
	And	INSUR_NO = AR_INSUR_NO
	And	RowNum < 2;
	If lnCount > 0 Then
		Raise_Application_Error(-20009,'���������� �ִ� �ڷ�� ������ �Ұ����մϴ�.');
	End If;
	Delete T_SET_CONS_INSUR
	Where	DEPT_CODE = AR_DEPT_CODE
	And	INSUR_NO = AR_INSUR_NO;
End;
/
