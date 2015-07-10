Create Or Replace Trigger trg_t_ACCNO_CODE_bf_iu
Before Insert Or Update On T_ACCNO_CODE
For Each Row
Begin
	:New.ACCOUNT_NO := Replace(:New.accno,'-','');
End;
/
