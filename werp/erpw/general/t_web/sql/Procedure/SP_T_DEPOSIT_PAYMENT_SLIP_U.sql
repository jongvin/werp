CREATE OR REPLACE Procedure SP_T_DEPOSIT_PAYMENT_SLIP_U
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_MODUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--적금
	AR_DEPOSIT_PAY_MNG                            VARCHAR2,
	AR_DEPOSIT_PAY_MNG_TG                         VARCHAR2,
	--적금
	AR_DEPOSIT_ACCNO                              VARCHAR2,
	AR_PAYMENT_SEQ                                NUMBER,
	AR_PAYMENT_SCH_DT                             VARCHAR2,
	AR_PAYMENT_SCH_AMT                            NUMBER,
	AR_PAYMENT_DT                                 VARCHAR2,
	AR_PAYMENT_AMT                                NUMBER
)
Is
	lnCnt						T_ACC_SLIP_BODY.SLIP_ID%Type;
	lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_BILL_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 적금불입
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	--적금 설정 클리어
	Update T_DEPOSIT_PAYMENT_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		PAYMENT_DT = Null,
		PAYMENT_AMT = 0,
		SLIP_ID = Null,
		SLIP_IDSEQ = Null
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
	
	If (AR_DEPOSIT_PAY_MNG = 'T' And AR_PAYMENT_SEQ is Not Null) Or (AR_DEPOSIT_PAY_MNG = 'T' And AR_PAYMENT_SEQ is Not Null) Then
		If (Nvl(AR_ACC_REMAIN_POSITION,'D') = 'D' And Nvl(AR_DB_AMT, 0) > 0) Or
			(Nvl(AR_ACC_REMAIN_POSITION,'D') = 'C' And Nvl(AR_CR_AMT, 0) > 0) Then
			--적금 설정
			Update T_DEPOSIT_PAYMENT_LIST
			Set
				MODUSERNO = AR_MODUSERNO,
				PAYMENT_DT = F_T_STRINGTODATE(AR_PAYMENT_DT),
				PAYMENT_AMT = AR_PAYMENT_AMT,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ
			Where	ACCNO = AR_DEPOSIT_ACCNO
			AND PAYMENT_SEQ = AR_PAYMENT_SEQ;
		Else
			--적금 반제
			NULL;
		End If;
	Else
		NULL;
	End If;
End;
/
