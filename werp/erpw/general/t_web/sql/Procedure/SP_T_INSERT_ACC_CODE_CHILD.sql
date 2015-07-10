Create Or Replace Procedure SP_T_INSERT_ACC_CODE_CHILD
(
	Ar_Acc_code			Varchar2,
	Ar_Child_Acc		Varchar2
)
Is
ls_Parent				Varchar2(10);
Begin
	If Ar_Acc_code = '000000000' Then
		Return;
	End If;
	Select
		Computer_Acc
	Into
		ls_Parent
	From	t_acc_code
	Where	acc_code = Ar_Acc_code;
	If ls_Parent = '000000000' Then
		Return;
	End If;
	Begin
		Insert Into t_acc_code_CHILD
		(
			PARENT_ACC_CODE,
			CHILD_ACC_CODE
		)
		values
		(
			ls_Parent,
			Ar_Child_Acc
		);
		Insert Into t_acc_code_CHILD2
		(
			PARENT_ACC_CODE,
			CHILD_ACC_CODE
		)
		values
		(
			ls_Parent,
			Ar_Child_Acc
		);
	Exception When Others Then
		Null;
	End;
	SP_T_INSERT_ACC_CODE_CHILD(ls_Parent,Ar_Child_Acc);
End;
/
