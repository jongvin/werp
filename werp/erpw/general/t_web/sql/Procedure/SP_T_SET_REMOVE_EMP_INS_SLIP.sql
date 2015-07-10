Create Or Replace Procedure SP_T_SET_REMOVE_EMP_INS_SLIP
(
	AR_COMP_CODE					VARCHAR2,
	AR_INSUR_WORK_NO				NUMBER,
	AR_CRTUSERNO					VARCHAR2
)
Is
	lrRec							T_SET_EMP_INSUR_WORK%RowType;
	lnCount							Number;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_EMP_INSUR_WORK
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'����� �Ǵ� �����۾��� ã�� �� �����ϴ�.');
	End;

	If lrRec.SLIP_ID Is Not Null Then
		Update	T_SET_EMP_INSUR_WORK
		Set		SLIP_ID = Null,
				SLIP_IDSEQ = Null
		Where	COMP_CODE = AR_COMP_CODE
		And		INSUR_WORK_NO = AR_INSUR_WORK_NO;

		PKG_T_Check_Slip.DeleteMaster(lrRec.SLIP_ID);
	Else
		Raise_Application_Error(-20009,'�����Ϸ��� ��ǥ�� ����� ���� �����ϴ�.');
	End If;
End;
/
