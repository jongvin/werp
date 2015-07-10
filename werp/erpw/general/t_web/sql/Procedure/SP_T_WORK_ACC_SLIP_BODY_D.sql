CREATE OR REPLACE Procedure SP_T_WORK_ACC_SLIP_BODY_D
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
	lnMAKE_SLIPLINE				T_ACC_SLIP_BODY.MAKE_SLIPLINE%Type;
	lsACC_CODE					T_ACC_SLIP_BODY.ACC_CODE%Type;
	lsACC_NAME					T_ACC_CODE.ACC_NAME%Type;
	lsSUMMARY1					T_ACC_SLIP_BODY.SUMMARY1%Type;
	lnDB_AMT					T_ACC_SLIP_BODY.DB_AMT%Type;
	lnCR_AMT					T_ACC_SLIP_BODY.CR_AMT%Type;
	ldKEEP_DT					T_ACC_SLIP_BODY.KEEP_DT%Type;
	lnCnt1						T_ACC_SLIP_BODY.SLIP_ID%Type;
	lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SLIP_BODY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SLIP_BODY 테이블 Delete
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
    dssfsfs
	--지급어음설정 어음 CLEAR
	Select	Count(*)
	Into	lnCnt1
	From	T_FIN_PAY_CHK_BILL
	Where	SLIP_ID = AR_SLIP_ID
	And		SLIP_IDSEQ = AR_SLIP_IDSEQ
	And		RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '전표오류!!!<br>'||'해당지급어음의 반제내역이 존재합니다.<br>해당전표내역을 삭제할수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Update T_FIN_PAY_CHK_BILL
		Set
			PUBL_DT = Null,
			EXPR_DT = Null,
			PUBL_AMT = Null,
			SLIP_ID = Null,
			SLIP_IDSEQ = Null
		Where	SLIP_ID = AR_SLIP_ID
		And		SLIP_IDSEQ = AR_SLIP_IDSEQ
		And		RESET_SLIP_ID is Null;
	End If;

	--지급어음반제 CLEAR
	Update T_FIN_PAY_CHK_BILL
	Set
		RESET_SLIP_ID = Null,
		RESET_SLIP_IDSEQ = Null
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And		RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--받을어음설정 CLEAR
	Select	Count(*)
	Into	lnCnt1
	From	T_FIN_RECEIVE_CHK_BILL
	Where	SLIP_ID = AR_SLIP_ID
	And		SLIP_IDSEQ = AR_SLIP_IDSEQ
	And		RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'해당받을어음의 반제내역이 존재합니다.<br>해당전표내역을 삭제할수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Delete	T_FIN_RECEIVE_CHK_BILL
		Where	SLIP_ID = AR_SLIP_ID
		And		SLIP_IDSEQ = AR_SLIP_IDSEQ
		And		RESET_SLIP_ID is Null;
	End If;


	--받을어음반제 CLEAR
	Update T_FIN_RECEIVE_CHK_BILL
	Set
		RESET_AMT = 0,
		RESET_SLIP_ID = Null,
		RESET_SLIP_IDSEQ = Null
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And		RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--유가증권설정 CLEAR
	-- 유가증권 미수이자가 등록되어 있으면 에러
	Select	Count(*)
	Into	lnCnt1
	From
		T_FIN_SECURTY A,
		T_FIN_SEC_ITR_AMT B
	Where
	A.SECU_NO = B.SECU_NO
	And	A.SLIP_ID = AR_SLIP_ID
	And	A.SLIP_IDSEQ = AR_SLIP_IDSEQ;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'해당유가증권의 미수이자가 존재합니다.<br>삭제할수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	End If;

	Select	Count(*)
	Into	lnCnt1
	From	T_FIN_SECURTY
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'해당유가증권의 반제내역이 존재합니다.<br>삭제할수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Delete	T_FIN_SECURTY
		Where	SLIP_ID = AR_SLIP_ID
		And	SLIP_IDSEQ = AR_SLIP_IDSEQ
		And	RESET_SLIP_ID is Null;
	End If;

	--유가증권반제 CLEAR
	Update T_FIN_SECURTY
	Set
		SALE_AMT = NULL,
		SALE_DT = NULL,
		RETURN_DT = NULL,
		CONSIGN_BANK = NULL,
		SALE_ITR_AMT = NULL,
		SALE_TAX = NULL,
		SALE_LOSS = NULL,
		SALE_NP_ITR_AMT = NULL,
		RESET_SLIP_ID = Null,
		RESET_SLIP_IDSEQ = Null
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--차입/상환 내역 삭제
	Delete	T_FIN_LOAN_REFUND_LIST
	Where	LOAN_SLIP_ID = AR_SLIP_ID
	And	LOAN_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	Delete	T_FIN_LOAN_REFUND_LIST
	Where	REFUND_SLIP_ID = AR_SLIP_ID
	And	REFUND_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--적금 불입내역 CLEAR
	Update T_DEPOSIT_PAYMENT_LIST
	Set
		PAYMENT_DT = Null,
		PAYMENT_AMT = 0,
		SLIP_ID = Null,
		SLIP_IDSEQ = Null
	Where	SLIP_ID = AR_SLIP_ID
	And		SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--CP매입설정 CLEAR
	Select	Count(*)
	Into	lnCnt1
	From	T_FIN_CP_BUY
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt1,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'해당CP매입의 반제내역이 존재합니다.<br>해당전표내역을 삭제할수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Delete	T_FIN_CP_BUY
		Where	SLIP_ID = AR_SLIP_ID
		And	SLIP_IDSEQ = AR_SLIP_IDSEQ
		And	RESET_SLIP_ID is Null;
	End If;

	--CP매입반제 CLEAR
	Update T_FIN_CP_BUY
	Set
		RESET_AMT = NULL,
		REMARKS = NULL,
		RESET_SLIP_ID = NULL,
		RESET_SLIP_IDSEQ = NULL
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--현금영수증
	Delete	T_ACC_SLIP_EXPENSE_CASH
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--카드영수증 반제
	Delete	T_ACC_SLIP_EXPENSE_CARDS
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;

	--전표BODY 삭제
	Delete T_ACC_SLIP_BODY
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
