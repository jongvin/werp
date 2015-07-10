Create Or Replace Package PKG_CHANGE_SLIP_STAT
Is
	Function	IsNowChange
	Return Boolean;
	Procedure	SetChangeStat
	(
		Ar_Stat				Boolean
	);
End;
/
Create Or Replace Package Body PKG_CHANGE_SLIP_STAT
Is
	G_Now_Change			Boolean;

	Function	IsNowChange
	Return Boolean
	Is
	Begin
		Return G_Now_Change;
	End;

	Procedure	SetChangeStat
	(
		Ar_Stat				Boolean
	)
	Is
	Begin
		G_Now_Change := Ar_Stat;
	End;
Begin
	G_Now_Change := False;
End;
/
