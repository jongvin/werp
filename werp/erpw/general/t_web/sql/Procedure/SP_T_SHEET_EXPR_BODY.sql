Create Or Replace Procedure SP_T_SHEET_EXPR_BODY_I
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_POSITION                                VARCHAR2,
	AR_REMAIN_CLS                              VARCHAR2,
	AR_CALC_CLS                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_EXPR_BODY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_EXPR_BODY 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SHEET_EXPR_BODY
	(
		SHEET_CODE,
		ITEM_CODE,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		POSITION,
		REMAIN_CLS,
		CALC_CLS
	)
	Values
	(
		AR_SHEET_CODE,
		AR_ITEM_CODE,
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE,
		AR_POSITION,
		AR_REMAIN_CLS,
		AR_CALC_CLS
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_EXPR_BODY_U
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_POSITION                                VARCHAR2,
	AR_REMAIN_CLS                              VARCHAR2,
	AR_CALC_CLS                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_EXPR_BODY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_EXPR_BODY 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_SHEET_EXPR_BODY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE,
		POSITION = AR_POSITION,
		REMAIN_CLS = AR_REMAIN_CLS,
		CALC_CLS = AR_CALC_CLS
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_CODE = AR_ITEM_CODE
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_SHEET_EXPR_BODY_D
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_SEQ                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_EXPR_BODY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_EXPR_BODY 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_SHEET_EXPR_BODY
	Where	SHEET_CODE = AR_SHEET_CODE
	And	ITEM_CODE = AR_ITEM_CODE
	And	SEQ = AR_SEQ;
End;
/
