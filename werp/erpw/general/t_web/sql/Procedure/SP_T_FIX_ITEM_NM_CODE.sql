Create Or Replace Procedure SP_T_FIX_ITEM_NM_CODE_I
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_ITEM_NM_CODE                            VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM_NM_NAME                            VARCHAR2,
	AR_SRVLIFE                                 NUMBER,
	AR_DEPREC_RAT                              NUMBER,
	AR_DEPREC_CLS                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_ITEM_NM_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_ITEM_NM_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIX_ITEM_NM_CODE
	(
		ASSET_CLS_CODE,
		ITEM_CODE,
		ITEM_NM_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NM_NAME,
		SRVLIFE,
		DEPREC_RAT,
		DEPREC_CLS
	)
	Values
	(
		AR_ASSET_CLS_CODE,
		AR_ITEM_CODE,
		AR_ITEM_NM_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM_NM_NAME,
		AR_SRVLIFE,
		AR_DEPREC_RAT,
		AR_DEPREC_CLS
	);
End;
/
Create Or Replace Procedure SP_T_FIX_ITEM_NM_CODE_U
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_ITEM_NM_CODE                            VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM_NM_NAME                            VARCHAR2,
	AR_SRVLIFE                                 NUMBER,
	AR_DEPREC_RAT                              NUMBER,
	AR_DEPREC_CLS                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_ITEM_NM_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_ITEM_NM_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIX_ITEM_NM_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM_NM_NAME = AR_ITEM_NM_NAME,
		SRVLIFE = AR_SRVLIFE,
		DEPREC_RAT = AR_DEPREC_RAT,
		DEPREC_CLS = AR_DEPREC_CLS
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	ITEM_CODE = AR_ITEM_CODE
	And	ITEM_NM_CODE = AR_ITEM_NM_CODE;
End;
/
Create Or Replace Procedure SP_T_FIX_ITEM_NM_CODE_D
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_ITEM_NM_CODE                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_ITEM_NM_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_ITEM_NM_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIX_ITEM_NM_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	ITEM_CODE = AR_ITEM_CODE
	And	ITEM_NM_CODE = AR_ITEM_NM_CODE;
End;
/
