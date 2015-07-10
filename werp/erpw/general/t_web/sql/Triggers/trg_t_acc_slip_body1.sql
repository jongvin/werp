Create Or Replace Trigger trg_t_acc_slip_body1
Before Insert Or Update On t_acc_slip_body1
For Each Row
Begin
	If PKG_CHANGE_SLIP_STAT.IsNowChange Then
		Return;
	End If;
	Select
		MAKE_COMP_CODE,
		MAKE_DEPT_CODE,
		MAKE_DT,
		SLIP_KIND_TAG,
		TRANSFER_TAG,
		IGNORE_SET_RESET_TAG,
		KEEP_DT
	Into
		:New.MAKE_COMP_CODE,
		:New.MAKE_DEPT_CODE,
		:New.MAKE_DT,
		:New.SLIP_KIND_TAG,
		:New.TRANSFER_TAG,
		:New.IGNORE_SET_RESET_TAG,
		:New.KEEP_DT
	From	T_ACC_SLIP_HEAD
	Where	Slip_Id = :New.Slip_Id;
End;
/
