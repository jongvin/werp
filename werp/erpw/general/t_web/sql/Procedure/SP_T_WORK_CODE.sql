Create Or Replace Procedure SP_T_WORK_CODE_I
(
	AR_WORK_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_NAME                               VARCHAR2,
	AR_SLIP_UPDATE_CLS                         VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_WORK_CODE
	(
		WORK_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_NAME,
		SLIP_UPDATE_CLS,
		CHARGE_PERS
	)
	Values
	(
		AR_WORK_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_WORK_NAME,
		AR_SLIP_UPDATE_CLS,
		AR_CHARGE_PERS
	);
End;
/
Create Or Replace Procedure SP_T_WORK_CODE_U
(
	AR_WORK_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_NAME                               VARCHAR2,
	AR_SLIP_UPDATE_CLS                         VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_WORK_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_NAME = AR_WORK_NAME,
		SLIP_UPDATE_CLS = AR_SLIP_UPDATE_CLS,
		CHARGE_PERS = AR_CHARGE_PERS
	Where	WORK_CODE = AR_WORK_CODE;
End;
/
Create Or Replace Procedure SP_T_WORK_CODE_D
(
	AR_WORK_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_WORK_CODE
	Where	WORK_CODE = AR_WORK_CODE;
End;
/
