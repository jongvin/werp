Create Or Replace Procedure SP_T_FL_LOAN_KIND_CODE_I
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FL_LOAN_KIND_NAME                       VARCHAR2,
	AR_FL_LOAN_KIND_TAG				   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_LOAN_KIND_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_LOAN_KIND_CODE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_LOAN_KIND_CODE
	(
		FL_LOAN_KIND_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		FL_LOAN_KIND_NAME,
		FL_LOAN_KIND_TAG
	)
	Values
	(
		AR_FL_LOAN_KIND_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_FL_LOAN_KIND_NAME,
		AR_FL_LOAN_KIND_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FL_LOAN_KIND_CODE_U
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2,
	AR_MODUSERNO                                    VARCHAR2,
	AR_FL_LOAN_KIND_NAME                       VARCHAR2,
	AR_FL_LOAN_KIND_TAG				   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_LOAN_KIND_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_LOAN_KIND_CODE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_LOAN_KIND_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FL_LOAN_KIND_NAME = AR_FL_LOAN_KIND_NAME,
		FL_LOAN_KIND_TAG	 = AR_FL_LOAN_KIND_TAG	
	Where	FL_LOAN_KIND_CODE = AR_FL_LOAN_KIND_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_LOAN_KIND_CODE_D
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_LOAN_KIND_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_LOAN_KIND_CODE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_LOAN_KIND_CODE
	Where	FL_LOAN_KIND_CODE = AR_FL_LOAN_KIND_CODE;
End;
/
