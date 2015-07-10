CREATE OR REPLACE Procedure SP_T_FIN_RECEIVE_BILL_SLIP_IU
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_CRTUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_COMP_CODE                                  VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--받을어음
	AR_REC_BILL_NO_MNG                            VARCHAR2,
	AR_REC_BILL_NO_MNG_TG                         VARCHAR2,
	--받을어음 설정
	AR_REC_BILL_NO_S                              VARCHAR2,
	AR_REC_BILL_PUBL_DT                           VARCHAR2,
	AR_REC_BILL_EXPR_DT                           VARCHAR2,
	--받을어음 반제
	AR_REC_BILL_NO_R                              VARCHAR2,
	AR_REC_BILL_PUBL_DT_R                         VARCHAR2,
	AR_REC_BILL_EXPR_DT_R                         VARCHAR2,
	AR_REC_BILL_DISH_DT_R         VARCHAR2,
	AR_REC_BILL_TRUST_DT_R        VARCHAR2,
	AR_REC_BILL_TRUST_BANK_CODE_R VARCHAR2,
	AR_REC_BILL_DISC_DT_R         VARCHAR2,
	AR_REC_BILL_DISC_BANK_CODE_R  VARCHAR2,
	AR_REC_BILL_DISC_RAT_R        NUMBER,
	AR_REC_BILL_DISC_AMT_R        NUMBER
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
	--받을어음 설정 클리어
	Select	Count(*)
	Into	lnCnt
	From	T_FIN_RECEIVE_CHK_BILL
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	RESET_SLIP_ID is Not Null;

	If Nvl(lnCnt,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'해당받을어음의 반제내역이 존재합니다.<br>해당전표내역을 삭제할수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Delete	T_FIN_RECEIVE_CHK_BILL
		Where	SLIP_ID = AR_SLIP_ID
		And	SLIP_IDSEQ = AR_SLIP_IDSEQ
		And	RESET_SLIP_ID is Null;
	End If;
	
	--받을어음 반제 클리어
	Update T_FIN_RECEIVE_CHK_BILL
	Set
		MODUSERNO = AR_CRTUSERNO,
		RESET_AMT = 0,
		RESET_SLIP_ID = Null,
		RESET_SLIP_IDSEQ = Null
	Where	RESET_SLIP_ID = AR_SLIP_ID
	And	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;
		
	If (AR_REC_BILL_NO_MNG = 'T' And AR_REC_BILL_NO_S is Not Null) Or (AR_REC_BILL_NO_MNG = 'T' And AR_REC_BILL_NO_R is Not Null) Then
		If (Nvl(AR_ACC_REMAIN_POSITION,'D') = 'D' And Nvl(AR_DB_AMT, 0) > 0) Or
			(Nvl(AR_ACC_REMAIN_POSITION,'D') = 'C' And Nvl(AR_CR_AMT, 0) > 0) Then
			--받을어음 설정
			SP_T_FIN_RECEIVE_CHK_BILL_I
			(
				AR_REC_BILL_NO_S, -- AR_REC_CHK_BILL_NO,
				AR_CRTUSERNO,
				'B', -- AR_CHK_BILL_CLS,
				AR_COMP_CODE,
				AR_DB_AMT+AR_CR_AMT,--AR_PUBL_AMT,
				0,--AR_RESET_AMT,
				AR_REC_BILL_PUBL_DT,--AR_PUBL_DT,
				AR_REC_BILL_EXPR_DT,--AR_EXPR_DT,
				NULL,--AR_DISH_DT,
				NULL,--AR_TRUST_DT,
				NULL,--AR_TRUST_BANK_CODE,
				NULL,--AR_DISC_DT,
				NULL,--AR_DISC_BANK_CODE,
				0,--AR_DISC_RAT,
				0,--AR_DISC_AMT,
				AR_SLIP_ID,
				AR_SLIP_IDSEQ,
				NULL,--AR_RESET_SLIP_ID,
				NULL--AR_RESET_SLIP_IDSEQ
			);

		Else
			--받을어음 반제
			Update T_FIN_RECEIVE_CHK_BILL
			Set
				MODUSERNO = AR_CRTUSERNO,
				RESET_AMT = AR_DB_AMT+AR_CR_AMT,
				DISH_DT = AR_REC_BILL_DISH_DT_R,
				TRUST_DT = AR_REC_BILL_TRUST_DT_R,
				TRUST_BANK_CODE = AR_REC_BILL_TRUST_BANK_CODE_R,
				DISC_DT = AR_REC_BILL_DISC_DT_R,
				DISC_BANK_CODE = AR_REC_BILL_DISC_BANK_CODE_R,
				DISC_RAT = AR_REC_BILL_DISC_RAT_R,
				DISC_AMT = AR_REC_BILL_DISC_AMT_R,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			Where	REC_CHK_BILL_NO = AR_REC_BILL_NO_R;
		End If;
	Else
		NULL;
	End If;
End;
/
