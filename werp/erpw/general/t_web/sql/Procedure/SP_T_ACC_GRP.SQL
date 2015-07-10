Create Or Replace Procedure SP_T_ACC_GRP_I
(
	AR_ACC_GRP_CODE                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_GRP_NAME                            VARCHAR2,
	AR_REMARK                                  VARCHAR2,
	AR_USE_TAG                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_GRP_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_GRP 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_ACC_GRP
	(
		ACC_GRP_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_GRP_NAME,
		REMARK,
		USE_TAG
	)
	Values
	(
		AR_ACC_GRP_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_GRP_NAME,
		AR_REMARK,
		AR_USE_TAG
	);
End;
/
Create Or Replace Procedure SP_T_ACC_GRP_U
(
	AR_ACC_GRP_CODE                            NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_GRP_NAME                            VARCHAR2,
	AR_REMARK                                  VARCHAR2,
	AR_USE_TAG                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_GRP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_GRP 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_ACC_GRP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_GRP_NAME = AR_ACC_GRP_NAME,
		REMARK = AR_REMARK,
		USE_TAG = AR_USE_TAG
	Where	ACC_GRP_CODE = AR_ACC_GRP_CODE;
End;
/
Create Or Replace Procedure SP_T_ACC_GRP_D
(
	AR_ACC_GRP_CODE                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_GRP_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_GRP 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_ACC_GRP
	Where	ACC_GRP_CODE = AR_ACC_GRP_CODE;
End;
/
