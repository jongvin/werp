Create Or Replace Procedure SP_T_ACC_TAX_BILL_MEDIA_D_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER,
	AR_BODY_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITEM                                    VARCHAR2,
	AR_ITEM_SIZE                               VARCHAR2,
	AR_CNT                                     NUMBER,
	AR_UCOST                                   NUMBER,
	AR_SUPAMT                                  NUMBER,
	AR_VATAMT                                  NUMBER,
	AR_REMARK                                  VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_TAX_BILL_MEDIA_D_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_TAX_BILL_MEDIA_D 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_ACC_TAX_BILL_MEDIA_D
	(
		COMP_CODE,
		WORK_NO,
		SEQ,
		BODY_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITEM,
		ITEM_SIZE,
		CNT,
		UCOST,
		SUPAMT,
		VATAMT,
		REMARK,
		PUBL_DT
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_NO,
		AR_SEQ,
		AR_BODY_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITEM,
		AR_ITEM_SIZE,
		AR_CNT,
		AR_UCOST,
		AR_SUPAMT,
		AR_VATAMT,
		AR_REMARK,
		F_T_StringToDate(AR_PUBL_DT)
	);
End;
/
Create Or Replace Procedure SP_T_ACC_TAX_BILL_MEDIA_D_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER,
	AR_BODY_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITEM                                    VARCHAR2,
	AR_ITEM_SIZE                               VARCHAR2,
	AR_CNT                                     NUMBER,
	AR_UCOST                                   NUMBER,
	AR_SUPAMT                                  NUMBER,
	AR_VATAMT                                  NUMBER,
	AR_REMARK                                  VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_TAX_BILL_MEDIA_D_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_TAX_BILL_MEDIA_D 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_ACC_TAX_BILL_MEDIA_D
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITEM = AR_ITEM,
		ITEM_SIZE = AR_ITEM_SIZE,
		CNT = AR_CNT,
		UCOST = AR_UCOST,
		SUPAMT = AR_SUPAMT,
		VATAMT = AR_VATAMT,
		REMARK = AR_REMARK,
		PUBL_DT = F_T_StringToDate(AR_PUBL_DT)
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO
	And	SEQ = AR_SEQ
	And	BODY_SEQ = AR_BODY_SEQ;
End;
/
Create Or Replace Procedure SP_T_ACC_TAX_BILL_MEDIA_D_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER,
	AR_BODY_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_TAX_BILL_MEDIA_D_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_TAX_BILL_MEDIA_D 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_ACC_TAX_BILL_MEDIA_D
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO
	And	SEQ = AR_SEQ
	And	BODY_SEQ = AR_BODY_SEQ;
End;
/
