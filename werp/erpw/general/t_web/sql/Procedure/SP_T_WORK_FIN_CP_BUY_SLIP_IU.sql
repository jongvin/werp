CREATE OR REPLACE Procedure SP_T_WORK_FIN_CP_BUY_SLIP_IU
(
	--AR_SLIP_ID              NUMBER,
	--AR_SLIP_IDSEQ           NUMBER,
	AR_CRTUSERNO            VARCHAR2,
	AR_ACC_REMAIN_POSITION  VARCHAR2,
	AR_COMP_CODE            VARCHAR2,
	AR_DB_AMT               NUMBER,
	AR_CR_AMT               NUMBER,
	--CP매입
	AR_CP_NO_MNG            VARCHAR2,
	AR_CP_NO_MNG_TG         VARCHAR2,
	--CP매입 설정
	AR_CP_NO_S              VARCHAR2,
	AR_CP_BUY_PUBL_DT       VARCHAR2,
	AR_CP_BUY_EXPR_DT       VARCHAR2,
	AR_CP_BUY_DUSE_DT       VARCHAR2,
	AR_CP_BUY_PUBL_AMT      NUMBER,
	AR_CP_BUY_INCOME_AMT    NUMBER,
	AR_CP_BUY_PUBL_PLACE    VARCHAR2,
	AR_CP_BUY_PUBL_NAME     VARCHAR2,
	AR_CP_BUY_INTR_RAT      NUMBER,
	AR_CP_BUY_CUST_SEQ      NUMBER,
	AR_CP_BUY_REMARKS       VARCHAR2,
	--CP매입 반제
	AR_CP_NO_R              VARCHAR2,
	AR_CP_BUY_PUBL_DT_R     VARCHAR2,
	AR_CP_BUY_EXPR_DT_R     VARCHAR2,
	AR_CP_BUY_DUSE_DT_R     VARCHAR2,
	AR_CP_BUY_PUBL_AMT_R    NUMBER,
	AR_CP_BUY_INCOME_AMT_R  NUMBER,
	AR_CP_BUY_PUBL_PLACE_R  VARCHAR2,
	AR_CP_BUY_PUBL_NAME_R   VARCHAR2,
	AR_CP_BUY_INTR_RAT_R    NUMBER,
	AR_CP_BUY_CUST_SEQ_R    NUMBER,
	AR_CP_BUY_RESET_AMT_R   NUMBER,
	AR_CP_BUY_REMARKS_R     VARCHAR2
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
	Select	Count(*)
	Into	lnCnt
	From	T_FIN_CP_BUY
	Where
		( CP_NO = AR_CP_NO_S AND SLIP_ID is Not Null );

	If Nvl(lnCnt,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'해당기업어음의 설정전표가 이미 존재합니다.<br>해당내역을 수정할 수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Null;
	End If;
	
	Select	Count(*)
	Into	lnCnt
	From	T_FIN_CP_BUY
	Where
		( CP_NO = AR_CP_NO_R AND RESET_SLIP_ID is Not Null );

	If Nvl(lnCnt,0) > 0 Then
		lsMsg := '전표생성오류!!!<br>'||'해당기업어음의 반제전표가 이미 존재합니다.<br>해당내역을 수정할 수 없습니다.'||lsMsg;
		Raise_Application_Error (-20009, lsMsg);
	Else
		Null;
	End If;
	
	If (AR_CP_NO_MNG = 'T' And AR_CP_NO_S is Not Null) Or (AR_CP_NO_MNG = 'T' And AR_CP_NO_R is Not Null) Then
		If (Nvl(AR_ACC_REMAIN_POSITION,'D') = 'D' And Nvl(AR_DB_AMT, 0) > 0) Or
			(Nvl(AR_ACC_REMAIN_POSITION,'D') = 'C' And Nvl(AR_CR_AMT, 0) > 0) Then
			Delete
				T_FIN_CP_BUY
			Where
				CP_NO = AR_CP_NO_S;
			
			--CP매입 설정
			SP_T_FIN_CP_BUY_I
			(
				AR_CP_NO_S,	--AR_CP_NO
				AR_CRTUSERNO,
				AR_COMP_CODE,
				AR_CP_BUY_PUBL_DT,
				AR_CP_BUY_EXPR_DT,
				AR_CP_BUY_DUSE_DT,
				AR_CP_BUY_PUBL_AMT,
				AR_CP_BUY_INCOME_AMT,
				NULL,--AR_RESET_AMT,
				AR_CP_BUY_PUBL_PLACE,
				AR_CP_BUY_PUBL_NAME,
				AR_CP_BUY_INTR_RAT,
				AR_CP_BUY_CUST_SEQ,
				0,--AR_SLIP_ID,
				0,--AR_SLIP_IDSEQ,
				NULL,--AR_RESET_SLIP_ID,
				NULL,--AR_RESET_SLIP_IDSEQ,
				AR_CP_BUY_REMARKS
			);
		Else
			--CP매입 반제
			Update T_FIN_CP_BUY
			Set
				MODUSERNO = AR_CRTUSERNO,
				RESET_AMT = AR_CP_BUY_RESET_AMT_R,
				REMARKS = AR_CP_BUY_REMARKS_R,
				RESET_SLIP_ID = NULL,
				RESET_SLIP_IDSEQ = NULL
			Where	CP_NO = AR_CP_NO_R;
		End If;
	Else
		NULL;
	End If;
End;
/
