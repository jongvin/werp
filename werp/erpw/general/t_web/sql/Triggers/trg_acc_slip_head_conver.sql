Create Or Replace Trigger trg_acc_slip_head_conver
Before Insert On t_acc_slip_head_conver
For Each Row
Begin
	:New.MAKE_SLIPNO := F_T_GEN_MAKE_SLIP_NO(:New.MAKE_COMP_CODE,:New.MAKE_DT_TRANS,:New.SLIP_KIND_TAG,:New.MAKE_SEQ);
End;
/

