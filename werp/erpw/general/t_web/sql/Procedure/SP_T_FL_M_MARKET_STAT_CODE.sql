Create Or Replace Procedure SP_T_FL_M_MARKET_STAT_CODE_I
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_M_MARKET_STAT_NAME                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_M_MARKET_STAT_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_M_MARKET_STAT_CODE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_M_MARKET_STAT_CODE
	(
		M_MARKET_STAT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		M_MARKET_STAT_NAME
	)
	Values
	(
		AR_M_MARKET_STAT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_M_MARKET_STAT_NAME
	);
End;
/
Create Or Replace Procedure SP_T_FL_M_MARKET_STAT_CODE_U
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_M_MARKET_STAT_NAME                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_M_MARKET_STAT_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_M_MARKET_STAT_CODE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_M_MARKET_STAT_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		M_MARKET_STAT_NAME = AR_M_MARKET_STAT_NAME
	Where	M_MARKET_STAT_CODE = AR_M_MARKET_STAT_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_M_MARKET_STAT_CODE_D
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_M_MARKET_STAT_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_M_MARKET_STAT_CODE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_M_MARKET_STAT_CODE
	Where	M_MARKET_STAT_CODE = AR_M_MARKET_STAT_CODE;
End;
/
