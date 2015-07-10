Create Or Replace Function F_T_GET_NEW_MAKE_SLIP_NO
(
	Ar_Make_Comp_Code		T_Acc_Slip_Head.Make_Comp_Code%Type,
	Ar_Make_Dt_Trans		T_Acc_Slip_Head.MAKE_DT_TRANS%Type,
	Ar_Slip_Kind_Tag		T_Acc_Slip_Head.Slip_Kind_Tag%Type
)
Return Varchar2
Is
Begin
	Return F_T_GEN_MAKE_SLIP_NO( Ar_Make_Comp_Code,Ar_Make_Dt_Trans,Ar_Slip_Kind_Tag,F_T_Get_New_Make_Seq(Ar_Make_Comp_Code,Ar_Make_Dt_Trans));
End;
/
