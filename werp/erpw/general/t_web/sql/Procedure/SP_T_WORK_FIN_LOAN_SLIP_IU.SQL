CREATE OR REPLACE Procedure SP_T_WORK_FIN_LOAN_SLIP_IU
(
	--AR_SLIP_ID                                    NUMBER,
	--AR_SLIP_IDSEQ                                 NUMBER,
	AR_CRTUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_COMP_CODE                                  VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--차입
	AR_LOAN_NO_MNG                                   VARCHAR2,
	AR_LOAN_NO_MNG_TG                                VARCHAR2,
	--차입 설정
	AR_LOAN_REFUND_NO_S                           	VARCHAR2,
	AR_LOAN_REFUND_SEQ_S                        	NUMBER,
	AR_LOAN_TRANS_DT                                   VARCHAR2,
	AR_LOAN_FDT                               		VARCHAR2,
	AR_LOAN_EXPR_DT                               	VARCHAR2,
	AR_LOAN_REAL_INTR_RATE                          NUMBER,
	AR_LOAN_TITLE_INTR_RATE                         NUMBER,
	--차입 반제
	AR_LOAN_REFUND_NO_R                           	VARCHAR2,
	AR_LOAN_REFUND_SEQ_R                        	NUMBER,
	AR_LOAN_TRANS_DT_R                                   VARCHAR2,
	AR_LOAN_REFUND_SCH_DT_R                         VARCHAR2,
	AR_LOAN_REFUND_SCH_ORG_AMT_R                    NUMBER,
	AR_LOAN_REFUND_SCH_INTR_AMT_R                   NUMBER,
	AR_LOAN_REFUND_DT_R                           	VARCHAR2
)
Is
  	lnCnt						Number;
	lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_REFUND_SLIP_IU
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 차입/상환 등록
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Select	Count(*)
	Into	lnCnt
	From	T_FIN_LOAN_REFUND_LIST
	Where
		( LOAN_NO = AR_LOAN_REFUND_NO_S
			And	LOAN_REFUND_SEQ = AR_LOAN_REFUND_SEQ_S
			AND LOAN_SLIP_ID is Not Null );

	If Nvl(lnCnt,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'차입금의 설정(차입)전표가 이미 존재합니다.<br>해당내역을 수정할 수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Null;
	End If;
	
	Select	Count(*)
	Into	lnCnt
	From	T_FIN_LOAN_REFUND_LIST
	Where
		( LOAN_NO = AR_LOAN_REFUND_NO_R
			And	LOAN_REFUND_SEQ = AR_LOAN_REFUND_SEQ_R
			AND REFUND_SLIP_ID is Not Null );

	If Nvl(lnCnt,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'차입금의 반제(상환)전표가 이미 존재합니다.<br>해당내역을 수정할 수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Null;
	End If;
	
	If (AR_LOAN_NO_MNG = 'T' And AR_LOAN_REFUND_NO_S is Not Null) Or (AR_LOAN_NO_MNG = 'T' And AR_LOAN_REFUND_NO_R is Not Null) Then
		
		If (Nvl(AR_ACC_REMAIN_POSITION,'D') = 'D' And Nvl(AR_DB_AMT, 0) > 0) Or
			(Nvl(AR_ACC_REMAIN_POSITION,'D') = 'C' And Nvl(AR_CR_AMT, 0) > 0) Then
			--차입 설정
			UPDATE T_FIN_LOAN_REFUND_LIST
			SET
				MODUSERNO = AR_CRTUSERNO,
				TRANS_DT = AR_LOAN_TRANS_DT,
				--LOAN_AMT = AR_DB_AMT+AR_CR_AMT,
				LOAN_SLIP_ID = NULL,--AR_SLIP_ID,
				LOAN_SLIP_IDSEQ = NULL--AR_SLIP_IDSEQ
			Where LOAN_NO = AR_LOAN_REFUND_NO_S
			And	LOAN_REFUND_SEQ = AR_LOAN_REFUND_SEQ_S;
		Else
			--차입 상환(반제)
			UPDATE T_FIN_LOAN_REFUND_LIST
			SET
				MODUSERNO = AR_CRTUSERNO,
				TRANS_DT = AR_LOAN_TRANS_DT_R,
				--REFUND_SCH_DT = AR_LOAN_REFUND_SCH_DT_R,
				--REFUND_SCH_ORG_AMT = AR_LOAN_REFUND_SCH_ORG_AMT_R,
				--REFUND_SCH_INTR_AMT = AR_LOAN_REFUND_SCH_INTR_AMT_R,
				--REFUND_INTR_DT = AR_LOAN_REFUND_DT_R,
				--REFUND_AMT = AR_DB_AMT+AR_CR_AMT,
				REFUND_SLIP_ID = NULL,--AR_SLIP_ID,
				REFUND_SLIP_IDSEQ = NULL --AR_SLIP_IDSEQ
			Where LOAN_NO = AR_LOAN_REFUND_NO_R
			And	LOAN_REFUND_SEQ = AR_LOAN_REFUND_SEQ_R;
			
		End If;
	Else
		NULL;
	End If;
	
End;
/
