Create Or Replace Procedure SP_T_SHEET_CODE_LVL_I
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_LVL                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SEQ_TYPE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_CODE_LVL_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_CODE_LVL 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SHEET_CODE_LVL
	(
		SHEET_CODE,
		ITEM_LVL,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SEQ_TYPE
	)
	Values
	(
		AR_SHEET_CODE,
		AR_ITEM_LVL,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SEQ_TYPE
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_CODE_LVL_U
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_LVL                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SEQ_TYPE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_CODE_LVL_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_CODE_LVL 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_SHEET_CODE_LVL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SEQ_TYPE = AR_SEQ_TYPE
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_LVL = AR_ITEM_LVL;
End;
/
Create Or Replace Procedure SP_T_SHEET_CODE_LVL_D
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_LVL                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_CODE_LVL_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_CODE_LVL 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-16)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_SHEET_CODE_LVL
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_LVL = AR_ITEM_LVL;
End;
/
