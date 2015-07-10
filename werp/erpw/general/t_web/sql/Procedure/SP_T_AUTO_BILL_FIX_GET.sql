Create Or Replace Procedure SP_T_AUTO_BILL_FIX_GET_I
(
	AR_AUTO_B_F_GET_SEQ                        NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_GET_AMT                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_GET_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FIX_GET 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_BILL_FIX_GET
	(
		AUTO_B_F_GET_SEQ,
		FIX_ASSET_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		GET_AMT
	)
	Values
	(
		AR_AUTO_B_F_GET_SEQ,
		AR_FIX_ASSET_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_GET_AMT
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_GET_U
(
	AR_AUTO_B_F_GET_SEQ                        NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_GET_AMT                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_GET_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FIX_GET 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_AUTO_BILL_FIX_GET
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		GET_AMT = AR_GET_AMT
	Where	AUTO_B_F_GET_SEQ = AR_AUTO_B_F_GET_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_BILL_FIX_GET_D
(
	AR_AUTO_B_F_GET_SEQ                        NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_BILL_FIX_GET_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_BILL_FIX_GET 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_AUTO_BILL_FIX_GET
	Where	AUTO_B_F_GET_SEQ = AR_AUTO_B_F_GET_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
