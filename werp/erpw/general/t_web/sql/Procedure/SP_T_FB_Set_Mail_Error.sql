Create Or Replace Procedure SP_T_FB_Set_Mail_Error
(
	Ar_MAIL_SEQ						Number,
	Ar_MAIL_SEND_YN					Varchar2,
	Ar_MAIL_SEND_RESULT_MSG			Varchar2
)
Is
	Pragma autonomous_transaction;
	Type T_T_FB_PAYDUE_MAIL_DETAIL Is Table Of T_FB_PAYDUE_MAIL_DETAIL%RowType
		Index By Binary_Integer;
	ltRec							T_T_FB_PAYDUE_MAIL_DETAIL;
	liFirst							Number;
	liLast							Number;
	lnKey							Number;
Begin
	Begin
		Select
			*
		Bulk Collect Into ltRec
		From	T_FB_PAYDUE_MAIL_DETAIL
		Where	MAIL_SEQ = Ar_MAIL_SEQ;
	Exception When No_Data_Found Then
		Null;
	End;
	Update	T_FB_PAYDUE_MAIL_MASTER
	Set		MAIL_SEND_YN = Ar_MAIL_SEND_YN,
			MAIL_SEND_RESULT_MSG = Ar_MAIL_SEND_RESULT_MSG,
			MAIL_SEND_DATE = SysDate
	Where	MAIL_SEQ = Ar_MAIL_SEQ;
	If ltRec.Count > 0 Then
		liFirst := ltRec.First;
		liLast := ltRec.Last;
		For liI In liFirst..liLast Loop
			If ltRec(liI).CASH_BILL_GUBUN = 'C' Then		--현금이라면
				lnKey := To_number(ltRec(liI).KEY_VALUE);
				Update	T_FB_CASH_PAY_DATA
				Set		MAIL_SEND_YN = Ar_MAIL_SEND_YN
				Where	PAY_SEQ = lnKey;
			ElsIf ltRec(liI).CASH_BILL_GUBUN = 'B' Then		--어음이라면
				lnKey := To_number(ltRec(liI).KEY_VALUE);
				Update	T_FB_BILL_PAY_DATA
				Set		MAIL_SEND_YN = Ar_MAIL_SEND_YN
				Where	PAY_SEQ = lnKey;
			End If;
		End Loop;
	End If;
	Commit;
Exception When Others Then
	Rollback;
End;
/
