Create Or Replace Procedure SP_T_REMOVE_CONS_INSUR_SLIP
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_INSUR_NO                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2
)
Is
	lrRec							T_SET_CONS_INSUR%RowType;
	lnCount							Number;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_CONS_INSUR
		Where	DEPT_CODE = AR_DEPT_CODE
		And		INSUR_NO = AR_INSUR_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'�����Ϸ��� ��ǥ�� ������ ã�� �� �����ϴ�.');
	End;
	If lrRec.SLIP_ID Is Not Null Then
		Select
			Count(*)
		Into
			lnCount
		From	T_SET_CONS_INSUR_DEC_AMT
		Where	DEPT_CODE = AR_DEPT_CODE
		And		INSUR_NO = AR_INSUR_NO;
		If lnCount > 0 Then
			Raise_Application_Error(-20009,'�ش� �ڷ�� �̹� ���������� �����Ƿ� ��ǥ�� �����Ͻ� �� �����ϴ�.');
		End If;
		Update	T_SET_CONS_INSUR
		Set		SLIP_ID = Null,
				SLIP_IDSEQ = Null
		Where	DEPT_CODE = AR_DEPT_CODE
		And		INSUR_NO = AR_INSUR_NO;
		PKG_T_Check_Slip.DeleteMaster(lrRec.SLIP_ID);
	Else
		Raise_Application_Error(-20009,'�����Ϸ��� ��ǥ�� ����� ���� �����ϴ�.');
	End If;
End;
/
