Create Or Replace Procedure SP_T_TAX_BILL_BODY_I
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_BODY_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2,
	AR_ITEM                                    VARCHAR2,
	AR_ITEM_SIZE                               VARCHAR2,
	AR_CNT                                     NUMBER,
	AR_UCOST                                   NUMBER,
	AR_SUPAMT                                  NUMBER,
	AR_VATAMT                                  NUMBER,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_TAX_BILL_BODY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_TAX_BILL_BODY 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_TAX_BILL_BODY
	(
		SLIP_ID,
		SLIP_IDSEQ,
		BODY_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		PUBL_DT,
		ITEM,
		ITEM_SIZE,
		CNT,
		UCOST,
		SUPAMT,
		VATAMT,
		REMARK
	)
	Values
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_BODY_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_PUBL_DT),
		AR_ITEM,
		AR_ITEM_SIZE,
		AR_CNT,
		AR_UCOST,
		AR_SUPAMT,
		AR_VATAMT,
		AR_REMARK
	);
End;
/
Create Or Replace Procedure SP_T_TAX_BILL_BODY_U
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_BODY_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2,
	AR_ITEM                                    VARCHAR2,
	AR_ITEM_SIZE                               VARCHAR2,
	AR_CNT                                     NUMBER,
	AR_UCOST                                   NUMBER,
	AR_SUPAMT                                  NUMBER,
	AR_VATAMT                                  NUMBER,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_TAX_BILL_BODY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_TAX_BILL_BODY 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_TAX_BILL_BODY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		PUBL_DT = F_T_StringToDate(AR_PUBL_DT),
		ITEM = AR_ITEM,
		ITEM_SIZE = AR_ITEM_SIZE,
		CNT = AR_CNT,
		UCOST = AR_UCOST,
		SUPAMT = AR_SUPAMT,
		VATAMT = AR_VATAMT,
		REMARK = AR_REMARK
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	BODY_SEQ = AR_BODY_SEQ;
End;
/
Create Or Replace Procedure SP_T_TAX_BILL_BODY_D
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_BODY_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_TAX_BILL_BODY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_TAX_BILL_BODY 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_TAX_BILL_BODY
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ
	And	BODY_SEQ = AR_BODY_SEQ;
End;
/
