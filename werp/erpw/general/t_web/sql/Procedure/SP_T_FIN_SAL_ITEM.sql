Create Or Replace Procedure SP_T_FIN_SAL_ITEM_I
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SAL_ITEM_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SAL_ITEM 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SAL_ITEM
	(
		ITEM_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM_NAME
	)
	Values
	(
		AR_ITEM_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM_NAME
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SAL_ITEM_U
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SAL_ITEM_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SAL_ITEM 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_SAL_ITEM
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM_NAME = AR_ITEM_NAME
	Where	ITEM_CODE = AR_ITEM_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_SAL_ITEM_D
(
	AR_ITEM_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SAL_ITEM_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SAL_ITEM 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_SAL_ITEM
	Where	ITEM_CODE = AR_ITEM_CODE;
End;
/
