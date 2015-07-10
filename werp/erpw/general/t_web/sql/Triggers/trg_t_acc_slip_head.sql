Create Or Replace Trigger trg_t_acc_slip_head
After Update On t_acc_slip_head
For Each Row
Begin
	If :New.MAKE_COMP_CODE <> :Old.MAKE_COMP_CODE Or
			:New.MAKE_DEPT_CODE <> :Old.MAKE_DEPT_CODE Or
			:New.MAKE_DT <> :Old.MAKE_DT Or
			:New.SLIP_KIND_TAG <> :Old.SLIP_KIND_TAG Or
			:New.TRANSFER_TAG <> :Old.TRANSFER_TAG Or
			Nvl(:New.KEEP_DT,To_Date('0001-01-01','YYYY-MM-DD')) <> Nvl(:Old.KEEP_DT,To_Date('0001-01-01','YYYY-MM-DD')) Or
			:New.IGNORE_SET_RESET_TAG <> :Old.IGNORE_SET_RESET_TAG Then
		Begin
			PKG_CHANGE_SLIP_STAT.SetChangeStat(True);
			Update	T_Acc_Slip_Body1
			Set		MAKE_COMP_CODE = :New.MAKE_COMP_CODE,
					MAKE_DEPT_CODE = :New.MAKE_DEPT_CODE,
					MAKE_DT = :New.MAKE_DT,
					SLIP_KIND_TAG = :New.SLIP_KIND_TAG,
					TRANSFER_TAG = :New.TRANSFER_TAG,
					KEEP_DT = :New.KEEP_DT,
					IGNORE_SET_RESET_TAG = :New.IGNORE_SET_RESET_TAG
			Where	SLIP_ID = :Old.SLIP_ID;
			PKG_CHANGE_SLIP_STAT.SetChangeStat(False);
		Exception When Others Then
			PKG_CHANGE_SLIP_STAT.SetChangeStat(False);
			Raise;
		End;
	End If;
End;
/
