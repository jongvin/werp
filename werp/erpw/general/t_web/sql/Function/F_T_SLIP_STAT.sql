Create Or Replace Function F_T_SLIP_STAT
(
	Ar_Slip_Id				Number
)
Return Varchar2
Is
	lddtKeepDt				Date;
Begin
	Select
		KEEP_DT
	Into
		lddtKeepDt
	From	T_ACC_SLIP_HEAD
	Where	SLIP_ID = Ar_Slip_Id;
	If lddtKeepDt Is Null Then
		Return 'N';
	Else
		Return 'C';
	End If;
Exception When No_Data_Found Then
	Return 'D';
End;
/
