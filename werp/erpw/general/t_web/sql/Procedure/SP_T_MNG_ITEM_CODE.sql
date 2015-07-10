Create Or Replace Procedure SP_T_MNG_ITEM_CODE_I
(
	AR_MNG_ITEM                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_MNG_NAME                                VARCHAR2,
	AR_DATA_TYPE                               VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_POPUP                                   VARCHAR2,
	AR_REMARK                                  VARCHAR2,
	AR_USE_TG                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_MNG_ITEM_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_MNG_ITEM_CODE 테이블 Insert
/* 4. 변  경  이  력 : 최언회 작성(2005-11-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_MNG_ITEM_CODE
	(
		MNG_ITEM,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MNG_NAME,
		DATA_TYPE,
		SEQ,
		POPUP,
		REMARK,
		USE_TG
	)
	Values
	(
		AR_MNG_ITEM,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_MNG_NAME,
		AR_DATA_TYPE,
		AR_SEQ,
		AR_POPUP,
		AR_REMARK,
		AR_USE_TG
	);
End;
/

Create Or Replace Procedure SP_T_MNG_ITEM_CODE_U
(
	AR_MNG_ITEM                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_MNG_NAME                                VARCHAR2,
	AR_DATA_TYPE                               VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_POPUP                                   VARCHAR2,
	AR_REMARK                                  VARCHAR2,
	AR_USE_TG                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_MNG_ITEM_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_MNG_ITEM_CODE 테이블 Update
/* 4. 변  경  이  력 : 최언회 작성(2005-11-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_MNG_ITEM_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		MNG_NAME = AR_MNG_NAME,
		DATA_TYPE = AR_DATA_TYPE,
		SEQ = AR_SEQ,
		POPUP = AR_POPUP,
		REMARK = AR_REMARK,
		USE_TG = AR_USE_TG
	Where	MNG_ITEM = AR_MNG_ITEM;
End;
/

Create Or Replace Procedure SP_T_MNG_ITEM_CODE_D
(
	AR_MNG_ITEM                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_MNG_ITEM_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_MNG_ITEM_CODE 테이블 Delete
/* 4. 변  경  이  력 : 최언회 작성(2005-11-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_MNG_ITEM_CODE
	Where	MNG_ITEM = AR_MNG_ITEM;
End;
/
