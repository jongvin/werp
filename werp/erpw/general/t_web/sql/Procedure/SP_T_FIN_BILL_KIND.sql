Create Or Replace Procedure SP_T_FIN_BILL_KIND_I
(
	AR_BILL_KIND                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BILL_NAME                               VARCHAR2,
	AR_REL_LOAN_KIND_CODE                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_BILL_KIND_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_BILL_KIND 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_BILL_KIND
	(
		BILL_KIND,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BILL_NAME,
		REL_LOAN_KIND_CODE
	)
	Values
	(
		AR_BILL_KIND,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BILL_NAME,
		AR_REL_LOAN_KIND_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FIN_BILL_KIND_U
(
	AR_BILL_KIND                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_BILL_NAME                               VARCHAR2,
	AR_REL_LOAN_KIND_CODE                      VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_BILL_KIND_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_BILL_KIND 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_BILL_KIND
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BILL_NAME = AR_BILL_NAME,
		REL_LOAN_KIND_CODE = AR_REL_LOAN_KIND_CODE
	Where	BILL_KIND = AR_BILL_KIND;
End;
/
Create Or Replace Procedure SP_T_FIN_BILL_KIND_D
(
	AR_BILL_KIND                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_BILL_KIND_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_BILL_KIND 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete	T_FIN_BILL_ACC_CODE
	Where	BILL_KIND = AR_BILL_KIND;
	Delete	T_FIN_BILL_KIND
	Where	BILL_KIND = AR_BILL_KIND;
End;
/
