Create Or Replace Procedure SP_T_ACC_SUMMARY_I
(
	AR_ACC_CODE                                VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SUMMARY_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SUMMARY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SUMMARY 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_ACC_SUMMARY
	(
		ACC_CODE,
		SUMMARY_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SUMMARY_NAME
	)
	Values
	(
		AR_ACC_CODE,
		AR_SUMMARY_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SUMMARY_NAME
	);
End;
/
Create Or Replace Procedure SP_T_ACC_SUMMARY_U
(
	AR_ACC_CODE                                VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SUMMARY_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SUMMARY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SUMMARY 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_ACC_SUMMARY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SUMMARY_NAME = AR_SUMMARY_NAME
	Where	ACC_CODE = AR_ACC_CODE
	And	SUMMARY_CODE = AR_SUMMARY_CODE;
End;
/
Create Or Replace Procedure SP_T_ACC_SUMMARY_D
(
	AR_ACC_CODE                                VARCHAR2,
	AR_SUMMARY_CODE                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_SUMMARY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_SUMMARY 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_ACC_SUMMARY
	Where	ACC_CODE = AR_ACC_CODE
	And	SUMMARY_CODE = AR_SUMMARY_CODE;
End;
/
