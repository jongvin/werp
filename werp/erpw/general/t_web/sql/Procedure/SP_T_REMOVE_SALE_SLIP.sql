Create Or Replace Procedure SP_T_REMOVE_SALE_SLIP
(
	AR_COMP_CODE					Varchar2,
	AR_WORK_NO						Number,
	AR_CRTUSERNO					Varchar2
)
Is
	lrRec							T_SET_SALE_SLIP%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_SET_SALE_SLIP
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_NO = AR_WORK_NO;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'�����Ϸ��� ��ǥ�� ������ ��ǥ�۾� ��Ͽ��� ã�� �� �����ϴ�.');
	End;
	Update	T_SET_SALE_SLIP
	Set		SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_NO = AR_WORK_NO;

	PKG_T_Check_Slip.DeleteMaster(lrRec.SLIP_ID);
End;
/
