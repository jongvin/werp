Create Or Replace Procedure SP_T_ACC_VAT_DIV_C_DEPT_I
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_DIV_DEPT_CODE                           VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_DIV_C_DEPT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_DIV_C_DEPT 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_ACC_VAT_DIV_C_DEPT
	(
		DIV_COMP_CODE,
		DIV_CODE,
		DIV_DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_DIV_COMP_CODE,
		AR_DIV_CODE,
		AR_DIV_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_ACC_VAT_DIV_C_DEPT_U
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_DIV_DEPT_CODE                           VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_DIV_C_DEPT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_DIV_C_DEPT 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_ACC_VAT_DIV_C_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	DIV_COMP_CODE = AR_DIV_COMP_CODE
	And	DIV_CODE = AR_DIV_CODE
	And	DIV_DEPT_CODE = AR_DIV_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_ACC_VAT_DIV_C_DEPT_D
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_DIV_DEPT_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_DIV_C_DEPT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_DIV_C_DEPT 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_ACC_VAT_DIV_C_DEPT
	Where	DIV_COMP_CODE = AR_DIV_COMP_CODE
	And	DIV_CODE = AR_DIV_CODE
	And	DIV_DEPT_CODE = AR_DIV_DEPT_CODE;
End;
/
