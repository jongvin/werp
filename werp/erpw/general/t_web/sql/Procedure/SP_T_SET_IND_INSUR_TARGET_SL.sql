Create Or Replace Procedure SP_T_SET_IND_INSUR_TARGET_SL_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_IND_INSUR_TARGET_SLIP_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_IND_INSUR_TARGET_SLIP ���̺� Insert
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec							T_SET_IND_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_IND_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'��ǥ�� ����� ���� ���� �Ǵ� ������ �ȵ˴ϴ�.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
	Insert Into T_SET_IND_INSUR_TARGET_SLIP
	(
		COMP_CODE,
		INSUR_WORK_NO,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Values
	(
		AR_COMP_CODE,
		AR_INSUR_WORK_NO,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_SET_IND_INSUR_TARGET_SL_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_IND_INSUR_TARGET_SLIP_U
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_IND_INSUR_TARGET_SLIP ���̺� Update
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec							T_SET_IND_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_IND_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'��ǥ�� ����� ���� ���� �Ǵ� ������ �ȵ˴ϴ�.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
End;
/
Create Or Replace Procedure SP_T_SET_IND_INSUR_TARGET_SL_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_INSUR_WORK_NO                           NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_SET_IND_INSUR_TARGET_SLIP_D
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : T_SET_IND_INSUR_TARGET_SLIP ���̺� Delete
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-03-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	lrRec							T_SET_IND_INSUR_WORK%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_IND_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
		If lrRec.SLIP_ID Is Not Null Then
			Raise_Application_Error(-20009,'��ǥ�� ����� ���� ���� �Ǵ� ������ �ȵ˴ϴ�.');
		End If;
	Exception When No_Data_Found Then
		Return;
	End;
	Delete T_SET_IND_INSUR_TARGET_SLIP
	Where	COMP_CODE = AR_COMP_CODE
	And	INSUR_WORK_NO = AR_INSUR_WORK_NO
	And	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
