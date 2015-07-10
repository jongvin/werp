Create Or Replace Procedure SP_T_PL_MA_ITEM_I
(
	AR_ITEM_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_P_NO                                    NUMBER,
	AR_BIZ_PLAN_ITEM_NAME                      VARCHAR2,
	AR_ITEM_LEVEL_SEQ                          NUMBER,
	AR_ITEM_TAG                                VARCHAR2,
	AR_FUNC_NO                                 NUMBER,
	AR_MNG_CODE                                VARCHAR2,
	AR_IS_LEAF_TAG                             VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_ITEM_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_ITEM 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_MA_ITEM
	(
		ITEM_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		P_NO,
		BIZ_PLAN_ITEM_NAME,
		ITEM_LEVEL_SEQ,
		ITEM_TAG,
		FUNC_NO,
		MNG_CODE,
		IS_LEAF_TAG,
		REMARKS
	)
	Values
	(
		AR_ITEM_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_P_NO,
		AR_BIZ_PLAN_ITEM_NAME,
		AR_ITEM_LEVEL_SEQ,
		AR_ITEM_TAG,
		AR_FUNC_NO,
		AR_MNG_CODE,
		AR_IS_LEAF_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_PL_MA_ITEM_U
(
	AR_ITEM_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_P_NO                                    NUMBER,
	AR_BIZ_PLAN_ITEM_NAME                      VARCHAR2,
	AR_ITEM_LEVEL_SEQ                          NUMBER,
	AR_ITEM_TAG                                VARCHAR2,
	AR_FUNC_NO                                 NUMBER,
	AR_MNG_CODE                                VARCHAR2,
	AR_IS_LEAF_TAG                             VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_ITEM_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_ITEM 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_MA_ITEM
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		P_NO = AR_P_NO,
		BIZ_PLAN_ITEM_NAME = AR_BIZ_PLAN_ITEM_NAME,
		ITEM_LEVEL_SEQ = AR_ITEM_LEVEL_SEQ,
		ITEM_TAG = AR_ITEM_TAG,
		FUNC_NO = AR_FUNC_NO,
		MNG_CODE = AR_MNG_CODE,
		IS_LEAF_TAG = AR_IS_LEAF_TAG,
		REMARKS = AR_REMARKS
	Where	ITEM_NO = AR_ITEM_NO;
End;
/
Create Or Replace Procedure SP_T_PL_MA_ITEM_D
(
	AR_ITEM_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_ITEM_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_ITEM 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PL_MA_ITEM
	Where	ITEM_NO = AR_ITEM_NO;
End;
/
