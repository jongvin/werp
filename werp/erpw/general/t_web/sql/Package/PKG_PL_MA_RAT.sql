Create Or Replace Package PKG_PL_MA_RAT
Is
	Procedure	Set_HIST_SEQ
	(
		Ar_HIST_SEQ				Number
	);
	Procedure	Set_DVD_CODE
	(
		Ar_DVD_CODE				Varchar2
	);
	Function	Get_HIST_SEQ
	Return Number;
	Function	Get_DVD_CODE
	Return Varchar2;
	Procedure	Process
	(
		Ar_HIST_SEQ				Number,
		Ar_DVD_CODE				Varchar2
	);
End;
/
Create Or Replace Package Body PKG_PL_MA_RAT
Is
	G_HIST_SEQ					T_PL_MA_DVD_RAT_LIST.HIST_SEQ%Type;
	G_DVD_CODE					T_PL_MA_DVD_RAT_LIST.DVD_CODE%Type;
	Procedure	Set_HIST_SEQ
	(
		Ar_HIST_SEQ				Number
	)
	Is
	Begin
		G_HIST_SEQ := Ar_HIST_SEQ;
	End;
	Procedure	Set_DVD_CODE
	(
		Ar_DVD_CODE				Varchar2
	)
	Is
	Begin
		G_DVD_CODE := Ar_DVD_CODE;
	End;
	Function	Get_HIST_SEQ
	Return Number
	Is
	Begin
		Return G_HIST_SEQ;
	End;
	Function	Get_DVD_CODE
	Return Varchar2
	Is
	Begin
		Return G_DVD_CODE;
	End;
	Procedure	Process
	(
		Ar_HIST_SEQ				Number,
		Ar_DVD_CODE				Varchar2
	)
	Is
	Begin
		Set_HIST_SEQ(Ar_HIST_SEQ);
		Set_DVD_CODE(Ar_DVD_CODE);
	End;
End;
/
