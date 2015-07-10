Create Or Replace Procedure SP_T_REMOVE_LOAN_SLIP
(
	Ar_Loan_No						Varchar2,
	Ar_Loan_Refund_Seq				Number,
	Ar_CrtUserNo					Varchar2
)
Is
	lrRec							T_FIN_LOAN_REFUND_LIST%RowType;
Begin
	Begin
		Select
			*
		Into
			lrRec
		From	T_FIN_LOAN_REFUND_LIST
		Where	LOAN_NO = Ar_Loan_No
		And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'삭제하려는 전표의 정보를 찾을 수 없습니다.');
	End;
	If lrRec.LOAN_SLIP_ID Is Not Null Then
		Update	T_FIN_LOAN_REFUND_LIST
		Set		LOAN_SLIP_ID = Null,
				LOAN_SLIP_IDSEQ = Null
		Where	LOAN_NO = Ar_Loan_No
		And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
		PKG_T_Check_Slip.DeleteMaster(lrRec.LOAN_SLIP_ID);
	End If;
	If lrRec.INTR_SLIP_ID Is Not Null Then
		Update	T_FIN_LOAN_REFUND_LIST
		Set		INTR_SLIP_ID = Null,
				INTR_SLIP_IDSEQ = Null
		Where	LOAN_NO = Ar_Loan_No
		And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
		PKG_T_Check_Slip.DeleteMaster(lrRec.INTR_SLIP_ID);
	End If;
	If lrRec.REFUND_SLIP_ID Is Not Null Then
		Update	T_FIN_LOAN_REFUND_LIST
		Set		REFUND_SLIP_ID = Null,
				REFUND_SLIP_IDSEQ = Null
		Where	LOAN_NO = Ar_Loan_No
		And		LOAN_REFUND_SEQ = Ar_Loan_Refund_Seq;
		PKG_T_Check_Slip.DeleteMaster(lrRec.REFUND_SLIP_ID);
	End If;
End;
/
