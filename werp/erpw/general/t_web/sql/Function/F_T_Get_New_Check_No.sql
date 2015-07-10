Create Or Replace Function F_T_Get_New_Check_No
(
	Ar_Date				Varchar2
)
Return Varchar2
Is
	Pragma				autonomous_transaction;
	ln_Ret				Number;
	ls_Errm				Varchar2(2000);
Begin
	Select
		Nvl(Max(No),0) + 1
	Into
		ln_Ret
	From	T_FB_CHECK_NO
	Where	PAY_YMD = Ar_Date;
	
	Insert Into T_FB_CHECK_NO
	(
		PAY_YMD,
		NO
	)
	Values
	(
		Ar_Date,
		ln_Ret
	);
	Commit;
	Return ln_Ret;
Exception When Others Then
	ls_Errm := SqlErrm;
	Rollback;
	Raise_Application_Error(-20009,'어음 번호 생성중 에러발생 '||ls_Errm);
End;
/
