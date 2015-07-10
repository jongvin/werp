Create Or Replace Procedure SP_T_FIX_ITEM_CODE_I
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_ITEM_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_ITEM_CODE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIX_ITEM_CODE
	(
		ASSET_CLS_CODE,
		ITEM_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NAME
	)
	Values
	(
		AR_ASSET_CLS_CODE,
		AR_ITEM_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM_NAME
	);
End;
/
Create Or Replace Procedure SP_T_FIX_ITEM_CODE_U
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_ITEM_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_ITEM_CODE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIX_ITEM_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM_NAME = AR_ITEM_NAME
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	ITEM_CODE = AR_ITEM_CODE;
End;
/
Create Or Replace Procedure SP_T_FIX_ITEM_CODE_D
(
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_ITEM_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_ITEM_CODE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIX_ITEM_CODE
	Where	ASSET_CLS_CODE = AR_ASSET_CLS_CODE
	And	ITEM_CODE = AR_ITEM_CODE;
End;
/
