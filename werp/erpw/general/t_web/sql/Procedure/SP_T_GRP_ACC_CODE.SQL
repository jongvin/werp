Create Or Replace Procedure SP_T_GRP_ACC_CODE_I
(
	AR_ACC_GRP_CODE                            NUMBER,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_GRP_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_GRP_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_GRP_ACC_CODE
	(
		ACC_GRP_CODE,
		ACC_CODE
	)
	Values
	(
		AR_ACC_GRP_CODE,
		AR_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_GRP_ACC_CODE_U
(
	AR_ACC_GRP_CODE                            NUMBER,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_GRP_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_GRP_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Null;
End;
/
Create Or Replace Procedure SP_T_GRP_ACC_CODE_D
(
	AR_ACC_GRP_CODE                            NUMBER,
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_GRP_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_GRP_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_GRP_ACC_CODE
	Where	ACC_GRP_CODE = AR_ACC_GRP_CODE
	And	ACC_CODE = AR_ACC_CODE;
End;
/
