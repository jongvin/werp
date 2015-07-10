Create Or Replace Function F_T_Get_Dflt_Out_AccNo
(
	Ar_Cust_Seq					Number,
	Ar_AccNo_Cls				Varchar2
)
Return Varchar2
Is
	lsRet						T_CUST_ACCNO_CODE.OUT_ACCNO%Type;
Begin
	Select
		a.OUT_ACCNO
	Into
		lsRet
	From
		(
			Select
				OUT_ACCNO
			From	T_CUST_ACCNO_CODE
			Where	CUST_SEQ = Ar_Cust_Seq
			And		ACCNO_CLS Like Ar_AccNo_Cls
			And		USE_TG = 'T'
		) a
	Where	RowNum < 2;
	Return lsRet;
Exception When No_Data_Found Then
	Return Null;
End;
/
