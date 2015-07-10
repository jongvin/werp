Create Or Replace Procedure SP_T_IU_EMP
(
	Ar_EmpNo			Varchar2,
	Ar_Name				Varchar2
)
Is
	lrCust				T_CUST_CODE%RowType;
	lnCustSeq			Number;
Begin
	Select
		*
	Into
		lrCust
	From	T_CUST_CODE
	Where	CUST_CODE = Ar_EmpNo
	And		RowNum < 2;
	Update	T_CUST_CODE
	Set		CUST_NAME = Ar_Name
	Where	CUST_CODE = Ar_EmpNo;
Exception When No_Data_Found Then
	Select
		Sq_T_Cust_Seq.NextVal
	Into
		lnCustSeq
	From	Dual;
	Insert Into T_CUST_CODE
	(
		CUST_SEQ,
		CUST_CODE,
		CUST_NAME,
		BOSS_NAME,
		TRADE_CLS,
		GROUP_COMP_CLS,
		USE_CLS,
		REPRESENT_CUST_SEQ
	)
	Values
	(
		lnCustSeq,
		Ar_EmpNo,
		Ar_Name,
		Ar_Name,
		'4',
		'F',
		'T',
		lnCustSeq
	);
End;
/
