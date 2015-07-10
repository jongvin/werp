Create Or Replace Procedure SP_T_ACC_CODE_EXT01_I
(
	AR_ACC_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SALEBUY_CLS                             VARCHAR2,
	AR_RCPTBILL_CLS                            VARCHAR2,
	AR_SUBTR_CLS                               VARCHAR2,
	AR_VATOCCUR_CLS                            VARCHAR2,
	AR_SLIP_DETAIL_LIST                        VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_CODE_EXT01_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_CODE_EXT01 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-14)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_ACC_CODE_EXT01
	(
		ACC_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SALEBUY_CLS,
		RCPTBILL_CLS,
		SUBTR_CLS,
		VATOCCUR_CLS,
		SLIP_DETAIL_LIST,
		REMARK
	)
	Values
	(
		AR_ACC_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SALEBUY_CLS,
		AR_RCPTBILL_CLS,
		AR_SUBTR_CLS,
		AR_VATOCCUR_CLS,
		AR_SLIP_DETAIL_LIST,
		AR_REMARK
	);
End;
/
Create Or Replace Procedure SP_T_ACC_CODE_EXT01_U
(
	AR_ACC_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SALEBUY_CLS                             VARCHAR2,
	AR_RCPTBILL_CLS                            VARCHAR2,
	AR_SUBTR_CLS                               VARCHAR2,
	AR_VATOCCUR_CLS                            VARCHAR2,
	AR_SLIP_DETAIL_LIST                        VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_CODE_EXT01_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_CODE_EXT01 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-14)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_ACC_CODE_EXT01
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SALEBUY_CLS = AR_SALEBUY_CLS,
		RCPTBILL_CLS = AR_RCPTBILL_CLS,
		SUBTR_CLS = AR_SUBTR_CLS,
		VATOCCUR_CLS = AR_VATOCCUR_CLS,
		SLIP_DETAIL_LIST = AR_SLIP_DETAIL_LIST,
		REMARK = AR_REMARK
	Where	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_ACC_CODE_EXT01_D
(
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_CODE_EXT01_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_CODE_EXT01 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-14)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_ACC_CODE_EXT01
	Where	ACC_CODE = AR_ACC_CODE;
End;
/
