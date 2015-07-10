Create Or Replace Procedure SP_T_AUTO_BILL_FIX_SELL_I
(
	AR_AUTO_B_F_SELL_SEQ                       NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SELL_AMT                                NUMBER,
	AR_INCREDU_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_SELL_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FIX_SELL 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_BILL_FIX_SELL
	(
		AUTO_B_F_SELL_SEQ,
		FIX_ASSET_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SELL_AMT,
		INCREDU_SEQ
	)
	Values
	(
		AR_AUTO_B_F_SELL_SEQ,
		AR_FIX_ASSET_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SELL_AMT,
		AR_INCREDU_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_SELL_U
(
	AR_AUTO_B_F_SELL_SEQ                       NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_SELL_AMT                                NUMBER,
	AR_INCREDU_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_SELL_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FIX_SELL 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_AUTO_BILL_FIX_SELL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SELL_AMT = AR_SELL_AMT,
		INCREDU_SEQ = AR_INCREDU_SEQ
	Where	AUTO_B_F_SELL_SEQ = AR_AUTO_B_F_SELL_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_SELL_D
(
	AR_AUTO_B_F_SELL_SEQ                       NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_SELL_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FIX_SELL 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_AUTO_BILL_FIX_SELL
	Where	AUTO_B_F_SELL_SEQ = AR_AUTO_B_F_SELL_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
