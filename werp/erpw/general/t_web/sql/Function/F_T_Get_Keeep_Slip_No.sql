Create Or Replace Function F_T_Get_Keeep_Slip_No
(
	Ar_Slip_Id				NUMBER,
	Ar_Keep_Dt				VARCHAR2,
	Ar_Keep_Dt_Trans		VARCHAR2,
	Ar_Keep_Dept			VARCHAR2,
	Ar_KEEP_KEEPER			NUMBER
)
Return Varchar2
Is
	lsRet					t_acc_slip_head.KEEP_SLIPNO%Type;
Begin
	Select
		MAKE_SLIPNO
	Into
		lsRet
	From	t_acc_slip_head
	Where	Slip_Id = Ar_Slip_Id;
	Return lsRet;
Exception When No_Data_Found Then
	Raise_Application_Error(-20009,'전표 헤더를 찾을 수 없습니다.');
End;
/
