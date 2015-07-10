Create Or Replace Procedure SP_T_SET_COST_CONV_ACC_I
(
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_R_ACC_CODE                              VARCHAR2,
	AR_R_ACC_CODE2                             VARCHAR2,
	AR_R_ACC_CODE3                             VARCHAR2,
	AR_R_ACC_CODE4                             VARCHAR2,
	AR_R_ACC_CODE5                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_COST_CONV_ACC_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_COST_CONV_ACC 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SET_COST_CONV_ACC
	(
		COST_CONV_CODE,
		ACC_CODE,
		R_ACC_CODE,
		R_ACC_CODE2,
		R_ACC_CODE3,
		R_ACC_CODE4,
		R_ACC_CODE5
	)
	Values
	(
		AR_COST_CONV_CODE,
		AR_ACC_CODE,
		AR_R_ACC_CODE,
		AR_R_ACC_CODE2,
		AR_R_ACC_CODE3,
		AR_R_ACC_CODE4,
		AR_R_ACC_CODE5
	);
End;
/
Create Or Replace Procedure SP_T_SET_COST_CONV_ACC_U
(
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_R_ACC_CODE                              VARCHAR2,
	AR_R_ACC_CODE2                             VARCHAR2,
	AR_R_ACC_CODE3                             VARCHAR2,
	AR_R_ACC_CODE4                             VARCHAR2,
	AR_R_ACC_CODE5                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_COST_CONV_ACC_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_COST_CONV_ACC 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_SET_COST_CONV_ACC
	Set
		R_ACC_CODE = AR_R_ACC_CODE,
		R_ACC_CODE2 = AR_R_ACC_CODE2,
		R_ACC_CODE3 = AR_R_ACC_CODE3,
		R_ACC_CODE4 = AR_R_ACC_CODE4,
		R_ACC_CODE5 = AR_R_ACC_CODE5
	Where	COST_CONV_CODE = AR_COST_CONV_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_SET_COST_CONV_ACC_D
(
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_COST_CONV_ACC_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_COST_CONV_ACC 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_SET_COST_CONV_ACC
	Where	COST_CONV_CODE = AR_COST_CONV_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
