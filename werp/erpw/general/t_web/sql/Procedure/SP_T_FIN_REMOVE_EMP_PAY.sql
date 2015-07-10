Create Or Replace Procedure SP_T_FIN_REMOVE_EMP_PAY
(
	AR_COMP_CODE					Varchar2,
	AR_WORK_DT						Varchar2,
	AR_WORK_SEQ						Number,
	AR_CRTUSERNO					Varchar2
)
Is
	lrRec							T_FIN_EMP_PAY_MAIN%RowType;
	lddtWorkDt						Date := f_t_stringtodate(AR_WORK_DT);
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_EMP_PAY_MAIN
		Where	COMP_CODE = AR_COMP_CODE
		And		WORK_DT = lddtWorkDt
		And		WORK_SEQ = AR_WORK_SEQ;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'�����Ϸ��� ��ǥ�� ������ ��ǥ�۾� ��Ͽ��� ã�� �� �����ϴ�.');
	End;
	Update	T_FIN_EMP_PAY_MAIN
	Set		SLIP_ID = Null
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = lddtWorkDt
	And		WORK_SEQ = AR_WORK_SEQ;

	Update	T_FIN_EMP_PAY_LIST
	Set		SLIP_ID = Null,
			SLIP_IDSEQ = Null
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = lddtWorkDt
	And		WORK_SEQ = AR_WORK_SEQ;

	PKG_T_Check_Slip.DeleteMaster(lrRec.SLIP_ID);
End;
/
