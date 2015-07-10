Create Or Replace Procedure SP_T_FIN_UPDATE_CHG_EXPR_DT
(
	Ar_CHK_BILL_NO			Varchar2
)
Is
	lbFound					Boolean;
	lddtDate				Date;
	Cursor CurA
	Is
	Select
		CHG_EXPR_DT
	From	T_FIN_BILL_CHG_LIST
	Where	CHK_BILL_NO = Ar_CHK_BILL_NO
	Order By
		CHG_DT desc,
		CHG_SEQ desc;
Begin
	Open CurA;
	Fetch CurA Into lddtDate;
	lbFound := CurA%Found;
	Close CurA;
	If Not lbFound Then
		lddtDate := Null;
	End If;
	Update T_FIN_PAY_CHK_BILL
	Set		CHG_EXPR_DT = lddtDate
	Where	CHK_BILL_NO = Ar_CHK_BILL_NO;
Exception When Others Then
	If CurA%IsOpen Then
		Close CurA;
	End If;
	Raise;
End;
/
