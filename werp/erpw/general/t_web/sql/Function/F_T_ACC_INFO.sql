Create Or Replace Function F_T_ACC_INFO
(
	Ar_Slip_Id				Number,
	Ar_Slip_IdSeq			Number,
	Ar_Tag					Varchar2			--지불방법	'1' =>예금		'2' => 실물어음		'3' 구매자금
)
Return T_OA_ACC_INFO
Is
	ltRec				T_OA_ACC_INFO := T_OA_ACC_INFO();
	lsTag				T_FIN_PAY_SUM_ACC_GROUP.PAY_TAR_TAG%Type;
	lnCustSeq			T_ACC_SLIP_BODY.CUST_SEQ%Type;
	lnCardSeq			T_ACC_SLIP_BODY.CARD_SEQ%Type;
	lsEmpNo				T_ACC_SLIP_BODY.EMP_NO%Type;
	lsBANK_MAIN_CODE	Varchar2(4);
	lsACCNO				Varchar2(20);
	lsACCNO_OWNER		Varchar2(60);
Begin
	Begin
		Select
			c.PAY_TAR_TAG,
			a.CUST_SEQ,
			a.EMP_NO,
			a.CARD_SEQ
		Into
			lsTag,
			lnCustSeq,
			lsEmpNo,
			lnCardSeq
		From	T_ACC_SLIP_BODY a,
				T_FIN_PAY_SUM_ACC_LIST b,
				T_FIN_PAY_SUM_ACC_GROUP c
		Where	a.SLIP_ID = Ar_Slip_Id
		And		a.SLIP_IDSEQ = Ar_Slip_IdSeq
		And		b.ACC_CODE = a.ACC_CODE
		And		b.ACC_KIND_CODE = c.ACC_KIND_CODE
		And		rowNum < 2;
	Exception When No_Data_Found Then
		Return ltRec;
	End;
	If lsTag = '1' Then	-- 거래처지급이면
		Begin
			Select
				ACCNO,
				BANK_MAIN_CODE,
				ACCNO_OWNER
			Into
				lsACCNO,
				lsBANK_MAIN_CODE,
				lsACCNO_OWNER
			From	T_CUST_ACCNO_CODE
			Where	CUST_SEQ = lnCustSeq
			And		USE_TG = 'T'
			And		ACCNO_CLS = Ar_Tag
			And		RowNum < 2;
		Exception When No_Data_Found Then
			Return ltRec;
		End;
		ltRec.Extend();
		ltRec(ltRec.Count) := T_O_ACC_INFO(lsBANK_MAIN_CODE,lsACCNO,lsACCNO_OWNER);
	ElsIf lsTag = '2' Then	--사원경비지급이면
		Begin
			Select
				a.IN_ACC_NO_2,
				a.IN_BANK_MAIN_CODE_2,
				b.NAME
			Into
				lsACCNO,
				lsBANK_MAIN_CODE,
				lsACCNO_OWNER
			From	T_FIN_EMP_IN_ACC_NO a,
					Z_AUTHORITY_USER b
			Where	a.ERMP_NO = b.EMPNO
			And		a.ERMP_NO = lsEmpNo
			And		RowNum < 2;
		Exception When No_Data_Found Then
			Return ltRec;
		End;
		ltRec.Extend();
		ltRec(ltRec.Count) := T_O_ACC_INFO(lsBANK_MAIN_CODE,lsACCNO,lsACCNO_OWNER);
	ElsIf lsTag = '3' Then	--사원법인카드 지급이면
		If lnCardSeq Is Null Then
			Return ltRec;
		End If;
		Begin
			Select
				a.ACCNO,
				a.BANK_MAIN_CODE,
				a.ACCNO_OWNER
			Into
				lsACCNO,
				lsBANK_MAIN_CODE,
				lsACCNO_OWNER
			From	T_CARD_MEMBER_HISTORY a
			Where	a.CardOwnerEmpNo = lsEmpNo
			And		a.CARD_SEQ = lnCardSeq
			And		RowNum < 2;
		Exception When No_Data_Found Then
			Return ltRec;
		End;
		ltRec.Extend();
		ltRec(ltRec.Count) := T_O_ACC_INFO(lsBANK_MAIN_CODE,lsACCNO,lsACCNO_OWNER);
	End If;
	Return ltRec;
End;
/
