CREATE OR REPLACE Procedure SP_T_EXPENSE_CARD_SLIP_IU
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_CRTUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--카드영수증
	AR_CARD_MNG                                   VARCHAR2,
	--카드영수증 설정
	AR_CARD_SEQ                                   VARCHAR2,
	AR_CARD_CARDNO                                VARCHAR2,
	AR_CARD_USE_DT                                VARCHAR2,
	AR_CARD_HAVE_PERS                             VARCHAR2,
	AR_CARD_CUST_CODE                             VARCHAR2,
	AR_CARD_CUST_NAME                             VARCHAR2,
	AR_CARD_TRADE_AMT                             VARCHAR2,
	AR_CARD_REQ_TG                                VARCHAR2
)
Is
	lnCnt						Number;
	lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_CHK_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 당좌수표밠행
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Delete	T_ACC_SLIP_EXPENSE_CARDS
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;  
	If (AR_CARD_MNG = 'T' And AR_CARD_CARDNO is Not Null) Then
		If (Nvl(AR_ACC_REMAIN_POSITION,'D') = 'D' And Nvl(AR_DB_AMT, 0) > 0) Or
			(Nvl(AR_ACC_REMAIN_POSITION,'D') = 'C' And Nvl(AR_CR_AMT, 0) > 0) Then
			--카드영수증 설정
			SP_T_ACC_SLIP_EXPENSE_CARDS_I
			(
				AR_SLIP_ID,
				AR_SLIP_IDSEQ,
				AR_CARD_SEQ,
				AR_CRTUSERNO,
				AR_CARD_CARDNO,
				AR_CARD_USE_DT,
				AR_CARD_HAVE_PERS,
				AR_CARD_CUST_CODE,
				AR_CARD_CUST_NAME,
				AR_CARD_TRADE_AMT,
				AR_CARD_REQ_TG
			);

		Else
			--카드영수증 반제
			NULL;             
		End If;
	Else
		NULL;
	End If;
End;
/
