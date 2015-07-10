Create Or Replace Function F_T_Get_Make_Slipno
(
	Ar_Slip_Id			T_ACC_SLIP_HEAD.SLIP_ID%Type,
	Ar_Slip_IdSeq			T_ACC_SLIP_BODY1.SLIP_IDSEQ%Type
)
Return Varchar2
Is
	ln_Ret				Varchar2(50);
Begin
	Select
		A.MAKE_SLIPNO||'-'||B.MAKE_SLIPLINE
	Into
		ln_Ret
	From	T_ACC_SLIP_HEAD	A,
		T_ACC_SLIP_BODY1 B
	Where	A.SLIP_ID	= B.SLIP_ID
	And	A.SLIP_ID	= Ar_Slip_Id
	And	B.SLIP_IDSEQ	= Ar_Slip_IdSeq;
	Return ln_Ret;
Exception When No_Data_Found Then
	Return '전표번호가 존재하지 않습니다.';
End;
/
