Create Or Replace Function F_T_Get_New_Make_Seq
(
	Ar_Make_Comp_Code		T_Acc_Slip_Head.Make_Comp_Code%Type,
	Ar_Make_Dt_Trans		T_Acc_Slip_Head.MAKE_DT_TRANS%Type
)
Return T_Acc_Slip_Head.MAKE_SEQ%Type
Is
	Pragma				autonomous_transaction;
	ln_Ret				T_Acc_Make_SlipNo.Make_Seq%Type;
	ls_Errm				Varchar2(2000);
Begin
	Select
		Nvl(Max(Make_Seq),0) + 1
	Into
		ln_Ret
	From	T_Acc_Make_SlipNo
	Where	Make_Comp_Code = Ar_Make_Comp_Code
	And		Make_Dt_Trans = Ar_Make_Dt_Trans;
	Insert Into T_Acc_Make_SlipNo
	(
		Make_Comp_Code,
		Make_Dt_Trans,
		Make_Seq
	)
	Values
	(
		Ar_Make_Comp_Code,
		Ar_Make_Dt_Trans,
		ln_Ret
	);
	Commit;
	Return ln_Ret;
Exception When Others Then
	ls_Errm := SqlErrm;
	Rollback;
	Raise_Application_Error(-20009,'발의 전표번호 생성중 에러발생 '||ls_Errm);
End;
/