Create Or Replace Procedure SP_T_PL_MA_ITEM_ACC_CODE_I
(
	AR_ITEM_NO                                 NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_DVD_TAG                                 VARCHAR2,
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_DVD_TAR_CODE                            VARCHAR2,
	AR_DVD_CODE                                VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_ITEM_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_ITEM_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_MA_ITEM_ACC_CODE
	(
		ITEM_NO,
		APPLY_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		SIGN_TAG,
		SLIP_SUM_MTHD_TAG,
		DVD_TAG,
		SUM_TAR_CODE,
		DVD_TAR_CODE,
		DVD_CODE,
		REMARKS
	)
	Values
	(
		AR_ITEM_NO,
		AR_APPLY_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE,
		AR_SIGN_TAG,
		AR_SLIP_SUM_MTHD_TAG,
		AR_DVD_TAG,
		AR_SUM_TAR_CODE,
		AR_DVD_TAR_CODE,
		AR_DVD_CODE,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_PL_MA_ITEM_ACC_CODE_U
(
	AR_ITEM_NO                                 NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_DVD_TAG                                 VARCHAR2,
	AR_SUM_TAR_CODE                            VARCHAR2,
	AR_DVD_TAR_CODE                            VARCHAR2,
	AR_DVD_CODE                                VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_ITEM_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_ITEM_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_MA_ITEM_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE,
		SIGN_TAG = AR_SIGN_TAG,
		SLIP_SUM_MTHD_TAG = AR_SLIP_SUM_MTHD_TAG,
		DVD_TAG = AR_DVD_TAG,
		SUM_TAR_CODE = AR_SUM_TAR_CODE,
		DVD_TAR_CODE = AR_DVD_TAR_CODE,
		DVD_CODE = AR_DVD_CODE,
		REMARKS = AR_REMARKS
	Where	ITEM_NO = AR_ITEM_NO
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
Create Or Replace Procedure SP_T_PL_MA_ITEM_ACC_CODE_D
(
	AR_ITEM_NO                                 NUMBER,
	AR_APPLY_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_ITEM_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_ITEM_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PL_MA_ITEM_ACC_CODE
	Where	ITEM_NO = AR_ITEM_NO
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
