Create Or Replace Function F_T_Get_Cust_AccNo
(
	Ar_Slip_Id				Number,
	Ar_Slip_IdSeq			Number,
	Ar_Cust_Seq				Number,
	Ar_Exec_Kind			Varchar2
)
Return Varchar2
Is
	lsAccNo					T_FIN_PAY_EXEC_LIST.IN_ACC_NO%Type;
	lsACCNO_CLS				T_CUST_ACCNO_CODE.ACCNO_CLS%Type;
Begin
	--만약 제일먼저 자금지급자료에 있는것을 가져온다.
	Begin
		Select
			a.IN_ACC_NO
		Into
			lsAccNo
		From	T_FIN_PAY_EXEC_LIST a
		Where	a.TARGET_SLIP_ID = Ar_Slip_Id
		And		a.TARGET_SLIP_IDSEQ = Ar_Slip_IdSeq
		And		RowNum < 2;
		Return lsAccNo;
	Exception When No_Data_Found Then
		lsAccNo := Null;
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
			ACCNO
		Into
			lsAccNo
		From	T_CUST_ACCNO_CODE a
		Where	a.CUST_SEQ = Ar_Cust_Seq
		And		a.USE_TG = 'T'
		And		RowNum < 2;
		Return lsAccNo;
	Exception When No_Data_Found Then
		lsAccNo := Null;
	End;
	Return lsAccNo;
End;
/
