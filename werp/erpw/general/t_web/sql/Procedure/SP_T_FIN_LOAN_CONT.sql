Create Or Replace Procedure SP_T_FIN_LOAN_CONT_I
(
	AR_LOAN_CONT_NO                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_LIMIT_AMT                               NUMBER,
	AR_BANK_CODE                               VARCHAR2,
	AR_LOAN_CONT_NAME                          VARCHAR2,
	AR_LOAN_CONT_EXPR_DT                       VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_FL_LOAN_KIND_CODE                               VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_CONT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_CONT 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_LOAN_CONT
	(
		LOAN_CONT_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		LIMIT_AMT,
		BANK_CODE,
		LOAN_CONT_NAME,
		LOAN_CONT_EXPR_DT,
		COMP_CODE,
		FL_LOAN_KIND_CODE,
		REMARK
	)
	Values
	(
		AR_LOAN_CONT_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_LIMIT_AMT,
		AR_BANK_CODE,
		AR_LOAN_CONT_NAME,
		F_T_StringToDate(AR_LOAN_CONT_EXPR_DT),
		AR_COMP_CODE,
		AR_FL_LOAN_KIND_CODE,
		AR_REMARK
	);
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_CONT_U
(
	AR_LOAN_CONT_NO                            NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_LIMIT_AMT                               NUMBER,
	AR_BANK_CODE                               VARCHAR2,
	AR_LOAN_CONT_NAME                          VARCHAR2,
	AR_LOAN_CONT_EXPR_DT                       VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_FL_LOAN_KIND_CODE                               VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_CONT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_CONT 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_LOAN_CONT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		LIMIT_AMT = AR_LIMIT_AMT,
		BANK_CODE = AR_BANK_CODE,
		LOAN_CONT_NAME = AR_LOAN_CONT_NAME,
		LOAN_CONT_EXPR_DT = F_T_StringToDate(AR_LOAN_CONT_EXPR_DT),
		COMP_CODE = AR_COMP_CODE,
		FL_LOAN_KIND_CODE= AR_FL_LOAN_KIND_CODE,
		REMARK = AR_REMARK
	Where	LOAN_CONT_NO = AR_LOAN_CONT_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_CONT_D
(
	AR_LOAN_CONT_NO                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_CONT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_CONT 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_LOAN_CONT
	Where	LOAN_CONT_NO = AR_LOAN_CONT_NO;
End;
/
