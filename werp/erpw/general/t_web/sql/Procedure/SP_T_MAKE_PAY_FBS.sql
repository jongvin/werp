Create Or Replace Procedure SP_T_MAKE_PAY_FBS
(
	AR_COMP_CODE						VARCHAR2,
	AR_WORK_DT							VARCHAR2,
	AR_DEPT_CODE						VARCHAR2,
	AR_CRTUSERNO						VARCHAR2
)
Is
	Type T_REC Is Table Of T_FIN_PAY_EXEC_LIST_TMP%RowType
		Index By Binary_Integer;
	ltRec								T_REC;
	ltCheck								T_REC;
	liFirst								Number;
	liLast								Number;
	Function	GetSlipBody
	(
		Ari_Slip_Id							T_ACC_SLIP_BODY.SLIP_ID%Type,
		Ari_Slip_IdSeq						T_ACC_SLIP_BODY.SLIP_IDSEQ%Type
	)
	Return T_ACC_SLIP_BODY%RowType
	Is
		lrRet				T_ACC_SLIP_BODY%RowType;
	Begin
		Select
			*
		Into
			lrRet
		From	T_ACC_SLIP_BODY
		Where	SLIP_ID = Ari_Slip_Id
		And		SLIP_IDSEQ = Ari_Slip_IdSeq;
		Return lrRet;
	Exception When No_Data_Found Then
		Raise_Application_Error(-20009,'지불전표를 찾을 수 없습니다.');
	End;
	--예금 처리
	Procedure	processTag1
	(
		Ar_Rec			In Out NoCopy T_FIN_PAY_EXEC_LIST_TMP%RowType
	)
	Is
		lnPaySeq			Number;
		lrBodyOrg			T_ACC_SLIP_BODY%RowType;
	Begin
		--전표내용 가져오기
		lrBodyOrg := GetSlipBody(Ar_Rec.SLIP_ID,Ar_Rec.SLIP_IDSEQ);
		--지불순번 가져오기
		Select
			T_FB_CASH_PAY_DATA_SEQ.NextVal
		Into
			lnPaySeq
		From	Dual;
		Insert Into T_FB_CASH_PAY_DATA
		(
			PAY_SEQ,
			PAY_METHOD_GUBUN,
			PAY_KIND_GUBUN,
			COMP_CODE,
			DEPT_CODE,
			PAY_AMT,
			PAY_DUE_YMD,
			DESCRIPTION,
			IN_BANK_CODE,
			IN_ACCOUNT_NO,
			ACCT_HOLDER_NAME,
			CUST_SEQ,
			VENDOR_NAME,
			OUT_BANK_CODE,
			OUT_ACCOUNT_NO,
			PAY_YMD,
			PAY_STATUS,
			PAY_SUCCESS_AMT,
			PAY_FAIL_AMT,
			MAIL_SEND_YN,
			SLIP_ID,
			SLIP_IDSEQ,
			CASHIER_CONFIRM_DATE,
			EDI_CREATE_REQ_YN,
			RESULT_TEXT,
			PAY_CANCEL_DATE,
			PAY_CANCEL_REASON,
			CREATION_DATE,
			CREATION_EMP_NO,
			LAST_MODIFY_DATE,
			LAST_MODIFY_EMP_NO,
			MANAGER_CONFIRM_DATE
		)
		Select
			lnPaySeq PAY_SEQ,
			'B' PAY_METHOD_GUBUN,		--배치
			'SE' PAY_KIND_GUBUN,		--거래처지급분
			lrBodyOrg.COMP_CODE COMP_CODE,
			lrBodyOrg.DEPT_CODE DEPT_CODE,
			Ar_Rec.EXEC_AMT PAY_AMT,
			To_Char(Ar_Rec.WORK_DT,'YYYYMMDD') PAY_DUE_YMD,
			lrBodyOrg.SUMMARY1 ||' '|| lrBodyOrg.SUMMARY2 DESCRIPTION,
			Ar_Rec.IN_BANK_MAIN_CODE IN_BANK_CODE,
			Replace(Ar_Rec.IN_ACC_NO,'-','') IN_ACCOUNT_NO,
			Ar_Rec.ACCNO_OWNER ACCT_HOLDER_NAME,
			lrBodyOrg.CUST_SEQ CUST_SEQ,
			lrBodyOrg.CUST_NAME VENDOR_NAME,
			c.BANK_MAIN_CODE OUT_BANK_CODE,
			b.ACCOUNT_NO OUT_ACCOUNT_NO,
			Null PAY_YMD,
			'0' PAY_STATUS,				--출납미확인
			0 PAY_SUCCESS_AMT,
			0 PAY_FAIL_AMT,
			'N' MAIL_SEND_YN,
			Ar_Rec.SLIP_ID SLIP_ID,
			Ar_Rec.SLIP_IDSEQ SLIP_IDSEQ,
			Null CASHIER_CONFIRM_DATE,
			'N' EDI_CREATE_REQ_YN,
			Null RESULT_TEXT,
			Null PAY_CANCEL_DATE,
			Null PAY_CANCEL_REASON,
			SysDate CREATION_DATE,
			AR_CRTUSERNO CREATION_EMP_NO,
			Null LAST_MODIFY_DATE,
			Null LAST_MODIFY_EMP_NO,
			Null MANAGER_CONFIRM_DATE
		From	T_ACCNO_CODE b,
				T_BANK_CODE c
		Where	b.ACCNO = Ar_Rec.OUT_ACC_NO
		And		b.BANK_CODE = c.BANK_CODE;
	End;
	--구매카드
	Procedure	processTag2
	(
		Ar_Rec			In Out NoCopy T_FIN_PAY_EXEC_LIST_TMP%RowType
	)
	Is
		lnPaySeq			Number;
		lrBodyOrg			T_ACC_SLIP_BODY%RowType;
	Begin
		--전표내용 가져오기
		lrBodyOrg := GetSlipBody(Ar_Rec.SLIP_ID,Ar_Rec.SLIP_IDSEQ);
		--지불순번 가져오기
		Select
			T_FB_BILL_PAY_DATA_SEQ.NextVal
		Into
			lnPaySeq
		From	Dual;
		Insert Into T_FB_BILL_PAY_DATA
		(
			PAY_SEQ,
			PAY_METHOD_GUBUN,
			PAY_KIND_GUBUN,
			COMP_CODE,
			DEPT_CODE,
			PAY_AMT,
			PAY_DUE_YMD,
			FUTURE_PAY_DUE_YMD,
			CHECK_NO,
			DESCRIPTION,
			VAT_REGISTRATION_NUM,
			CUST_SEQ,
			VENDOR_NAME,
			OUT_BANK_CODE,
			OUT_ACCOUNT_NO,
			PAY_YMD,
			PAY_STATUS,
			MAIL_SEND_YN,
			SLIP_ID,
			SLIP_IDSEQ,
			CASHIER_CONFIRM_DATE,
			EDI_CREATE_REQ_YN,
			RESULT_TEXT,
			PAY_CANCEL_DATE,
			PAY_CANCEL_REASON,
			CREATION_DATE,
			CREATION_EMP_NO,
			LAST_MODIFY_DATE,
			LAST_MODIFY_EMP_NO,
			MANAGER_CONFIRM_DATE
		)
		Select
			lnPaySeq PAY_SEQ,
			'B' PAY_METHOD_GUBUN,		--배치
			'SE' PAY_KIND_GUBUN,		--거래처지급분
			lrBodyOrg.COMP_CODE COMP_CODE,
			lrBodyOrg.DEPT_CODE DEPT_CODE,
			Ar_Rec.EXEC_AMT PAY_AMT,
			To_Char(Ar_Rec.WORK_DT,'YYYYMMDD') PAY_DUE_YMD,
			To_Char(Ar_Rec.EXPR_DT,'YYYYMMDD') FUTURE_PAY_DUE_YMD,
			Ar_Rec.CHK_BILL_NO CHECK_NO,
			lrBodyOrg.SUMMARY1 ||' '|| lrBodyOrg.SUMMARY2 DESCRIPTION,
			(
				Select
					CUST_CODE
				From	T_CUST_CODE
				Where	CUST_SEQ = lrBodyOrg.CUST_SEQ
			) VAT_REGISTRATION_NUM,
			lrBodyOrg.CUST_SEQ CUST_SEQ,
			lrBodyOrg.CUST_NAME VENDOR_NAME,
			c.BANK_MAIN_CODE OUT_BANK_CODE,
			b.ACCOUNT_NO OUT_ACCOUNT_NO,
			Null PAY_YMD,
			'0' PAY_STATUS,				--출납미확인
			'N' MAIL_SEND_YN,
			Ar_Rec.SLIP_ID SLIP_ID,
			Ar_Rec.SLIP_IDSEQ SLIP_IDSEQ,
			Null CASHIER_CONFIRM_DATE,
			'N' EDI_CREATE_REQ_YN,
			Null RESULT_TEXT,
			Null PAY_CANCEL_DATE,
			Null PAY_CANCEL_REASON,
			SysDate CREATION_DATE,
			AR_CRTUSERNO CREATION_EMP_NO,
			Null LAST_MODIFY_DATE,
			Null LAST_MODIFY_EMP_NO,
			Null MANAGER_CONFIRM_DATE
		From	T_ACCNO_CODE b,
				T_BANK_CODE c
		Where	b.ACCNO = Ar_Rec.OUT_ACC_NO
		And		b.BANK_CODE = c.BANK_CODE;
	End;
Begin
	--전표발행을 위해 먼저 T_FIN_PAY_EXEC_LIST_TMP에 전표 발행 대상 행이 삽입되어 있다고 가정한다.
	--먼저 지불전표가 발행되지 않았거나 확정되지 않은 행이 선택되었는지를 확인한다.
	Select
		*
	Bulk Collect Into
		ltCheck
	From	T_FIN_PAY_EXEC_LIST_TMP a
	Where	Not Exists
	(
		Select
			Null
		From	T_ACC_SLIP_HEAD b
		Where	a.SLIP_ID = b.SLIP_ID
		And		b.KEEP_DT Is Not Null
	);
	If ltCheck.Count > 0 Then
		Raise_Application_Error(-20009,'FBS자료를 생성하기 위해서는 먼저 지불전표를 발행 후 확정하셔야 합니다.');
	End If;
	--선택된 행을 읽어들인다.
	Select
		a.*
	Bulk Collect Into
		ltRec
	From	T_FIN_PAY_EXEC_LIST_TMP a
	Order By
		a.EXEC_KIND_TAG,
		a.SLIP_ID ,
		a.SLIP_IDSEQ;
	If ltRec.Count < 1 Then
		Raise_Application_Error(-20009,'FBS자료를 생성할 대상을 선택 후 작업해 주십시오.');
	End If;
	liFirst := ltRec.First;
	liLast := ltRec.Last;
	For liI In liFirst..liLast Loop
		Declare
			lrRec								T_FIN_PAY_EXEC_LIST_TMP%RowType;
		Begin
			lrRec := ltRec(liI);
			If lrRec.EXEC_KIND_TAG = '1' Then
				processTag1(lrRec);
			ElsIf lrRec.EXEC_KIND_TAG = '2' Then
				processTag2(lrRec);
			ElsIf lrRec.EXEC_KIND_TAG = '3' Then
				Null;
			ElsIf lrRec.EXEC_KIND_TAG = '4' Then
				Null;
			End If;
		End;
	End Loop;
End;
/
