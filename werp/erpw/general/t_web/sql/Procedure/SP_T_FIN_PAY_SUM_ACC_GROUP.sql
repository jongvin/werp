Create Or Replace Procedure SP_T_FIN_PAY_SUM_ACC_GROUP_I
(
	AR_ACC_KIND_CODE                           VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_KIND_NAME                           VARCHAR2,
	AR_PAY_TAR_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SUM_ACC_GROUP_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SUM_ACC_GROUP 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_PAY_SUM_ACC_GROUP
	(
		ACC_KIND_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_KIND_NAME,
		PAY_TAR_TAG
	)
	Values
	(
		AR_ACC_KIND_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_KIND_NAME,
		AR_PAY_TAR_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SUM_ACC_GROUP_U
(
	AR_ACC_KIND_CODE                           VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_KIND_NAME                           VARCHAR2,
	AR_PAY_TAR_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SUM_ACC_GROUP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SUM_ACC_GROUP 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_PAY_SUM_ACC_GROUP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_KIND_NAME = AR_ACC_KIND_NAME,
		PAY_TAR_TAG = AR_PAY_TAR_TAG
	Where	ACC_KIND_CODE = AR_ACC_KIND_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SUM_ACC_GROUP_D
(
	AR_ACC_KIND_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SUM_ACC_GROUP_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SUM_ACC_GROUP 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_PAY_SUM_ACC_GROUP
	Where	ACC_KIND_CODE = AR_ACC_KIND_CODE;
End;
/
