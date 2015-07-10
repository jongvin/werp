CREATE OR REPLACE Procedure SP_T_WORK_EXPENSE_CASH_SLIP_IU
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_CRTUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--현금영수증
	AR_CASH_MNG                                   VARCHAR2,
	--현금영수증 설정
	AR_CASH_CASHNO                                VARCHAR2,
	AR_CASH_USE_DT                                VARCHAR2,
	AR_CASH_EMP_NO                                VARCHAR2,
	AR_CASH_HAVE_PERS                             VARCHAR2,
	AR_CASH_CUST_CODE                             VARCHAR2,
	AR_CASH_CUST_NAME                             VARCHAR2,
	AR_CASH_TRADE_AMT                             VARCHAR2,
	AR_CASH_REQ_TG                                VARCHAR2
)
Is
	lnCnt						Number;
	lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_EXPENSE_CASH_SLIP_IU
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 당좌수표밠행
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Delete	T_WORK_ACC_SLIP_EXPENSE_CASH
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
	
	If (AR_CASH_MNG = 'T' And AR_CASH_CASHNO is Not Null) Then
		If (Nvl(AR_ACC_REMAIN_POSITION,'D') = 'D' And Nvl(AR_DB_AMT, 0) > 0) Or
			(Nvl(AR_ACC_REMAIN_POSITION,'D') = 'C' And Nvl(AR_CR_AMT, 0) > 0) Then
			SP_T_WORK_ACC_SLIP_CASH_I
			(
				AR_SLIP_ID,
				AR_SLIP_IDSEQ,
				1,--AR_CASH_SEQ,
				AR_CRTUSERNO,
				AR_CASH_CASHNO,
				AR_CASH_USE_DT,
				AR_CASH_EMP_NO,
				AR_CASH_HAVE_PERS,
				AR_CASH_CUST_CODE,
				AR_CASH_CUST_NAME,
				AR_CASH_TRADE_AMT,
				AR_CASH_REQ_TG
			);

		Else
			--현금영수증
			NULL;             
		End If;
	Else
		NULL;
	End If;
End;
/
