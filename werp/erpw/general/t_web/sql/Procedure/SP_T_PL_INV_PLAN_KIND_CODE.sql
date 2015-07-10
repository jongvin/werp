Create Or Replace Procedure SP_T_PL_INV_PLAN_KIND_CODE_I
(
	AR_KIND_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_INV_TAG                                 VARCHAR2,
	AR_KIND_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_INV_PLAN_KIND_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_INV_PLAN_KIND_CODE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-29)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_INV_PLAN_KIND_CODE
	(
		KIND_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		INV_TAG,
		KIND_NAME
	)
	Values
	(
		AR_KIND_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_INV_TAG,
		AR_KIND_NAME
	);
End;
/
Create Or Replace Procedure SP_T_PL_INV_PLAN_KIND_CODE_U
(
	AR_KIND_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_INV_TAG                                 VARCHAR2,
	AR_KIND_NAME                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_INV_PLAN_KIND_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_INV_PLAN_KIND_CODE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-29)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_INV_PLAN_KIND_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		INV_TAG = AR_INV_TAG,
		KIND_NAME = AR_KIND_NAME
	Where	KIND_CODE = AR_KIND_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_INV_PLAN_KIND_CODE_D
(
	AR_KIND_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_INV_PLAN_KIND_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_INV_PLAN_KIND_CODE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-29)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PL_INV_PLAN_KIND_CODE
	Where	KIND_CODE = AR_KIND_CODE;
End;
/
