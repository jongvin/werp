Create Or Replace Function F_T_GEN_MAKE_SLIP_NO
(
	Ar_Make_Comp_Code		T_Acc_Slip_Head.Make_Comp_Code%Type,
	Ar_Make_Dt_Trans		T_Acc_Slip_Head.MAKE_DT_TRANS%Type,
	Ar_Slip_Kind_Tag		T_Acc_Slip_Head.Slip_Kind_Tag%Type,
	Ar_Seq					Number
)
Return Varchar2
Is
Begin
	������
	If Ar_Seq > 9999 Then
		Raise_Application_Error(-20009,'��ǥ ������ �ִ��ڸ���(9999)�� �ʰ��߽��ϴ�.');
	End If;
	Return SubStrb(Ar_Make_Dt_Trans,3,6)||Ar_Slip_Kind_Tag||''||Ar_Make_Comp_Code||''||To_Char(Ar_Seq,'FM0000');
End;
/
