Create Or Replace Procedure SP_T_FIX_DEPREC_RAT_I
(
	AR_SRVLIFE                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DEPREC_RAT5                             NUMBER,
	AR_DEPREC_RAT10                            NUMBER,
	AR_DEPREC_AMT                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_DEPREC_RAT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_DEPREC_RAT 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIX_DEPREC_RAT
	(
		SRVLIFE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DEPREC_RAT5,
		DEPREC_RAT10,
		DEPREC_AMT
	)
	Values
	(
		AR_SRVLIFE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DEPREC_RAT5,
		AR_DEPREC_RAT10,
		AR_DEPREC_AMT
	);
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_RAT_U
(
	AR_SRVLIFE                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_DEPREC_RAT5                             NUMBER,
	AR_DEPREC_RAT10                            NUMBER,
	AR_DEPREC_AMT                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_DEPREC_RAT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_DEPREC_RAT 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIX_DEPREC_RAT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DEPREC_RAT5 = AR_DEPREC_RAT5,
		DEPREC_RAT10 = AR_DEPREC_RAT10,
		DEPREC_AMT = AR_DEPREC_AMT
	Where	SRVLIFE = AR_SRVLIFE;
End;
/
Create Or Replace Procedure SP_T_FIX_DEPREC_RAT_D
(
	AR_SRVLIFE                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_DEPREC_RAT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_DEPREC_RAT 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIX_DEPREC_RAT
	Where	SRVLIFE = AR_SRVLIFE;
End;
/
