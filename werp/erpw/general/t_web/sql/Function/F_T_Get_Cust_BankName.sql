Create Or Replace Function F_T_Get_Cust_BankName
(
	Ar_Slip_Id				Number,
	Ar_Slip_IdSeq			Number,
	Ar_Cust_Seq				Number,
	Ar_Exec_Kind			Varchar2
)
Return Varchar2
Is
	lsBankMainName			T_BANK_MAIN.BANK_MAIN_NAME%Type;
	lsACCNO_CLS				T_CUST_ACCNO_CODE.ACCNO_CLS%Type;
Begin
	--만약 제일먼저 자금지급자료에 있는것을 가져온다.
	Begin
		Select
			b.BANK_MAIN_NAME
		Into
			lsBankMainName
		From	T_FIN_PAY_EXEC_LIST a,
				T_BANK_MAIN b
		Where	a.TARGET_SLIP_ID = Ar_Slip_Id
		And		a.TARGET_SLIP_IDSEQ = Ar_Slip_IdSeq
		And		a.IN_BANK_MAIN_CODE = b.BANK_MAIN_CODE
		And		RowNum < 2;
		Return lsBankMainName;
	Exception When No_Data_Found Then
		lsBankMainName := Null;
	End;
	If Ar_Exec_Kind = '1' Then		--예금이라면
		lsACCNO_CLS := '1';
	ElsIf Ar_Exec_Kind = '2' Then		--구매카드이라면
		lsACCNO_CLS := '3';
	ElsIf Ar_Exec_Kind = '3' Then		--어음이라면
		lsACCNO_CLS := '2';
	End If;
	Begin
		Select
			b.BANK_MAIN_NAME
		Into
			lsBankMainName
		From	T_CUST_ACCNO_CODE a,
				T_BANK_MAIN b
		Where	a.CUST_SEQ = Ar_Cust_Seq
		And		a.BANK_MAIN_CODE = b.BANK_MAIN_CODE
		And		a.USE_TG = 'T'
		And		RowNum < 2;
		Return lsBankMainName;
	Exception When No_Data_Found Then
		lsBankMainName := Null;
	End;
	Return lsBankMainName;
End;
/
