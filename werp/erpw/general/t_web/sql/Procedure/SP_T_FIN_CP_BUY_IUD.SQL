Create Or Replace Procedure SP_T_FIN_CP_BUY_I
(
	AR_CP_NO                                   VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2,
	AR_EXPR_DT                                 VARCHAR2,
	AR_DUSE_DT                                 VARCHAR2,
	AR_PUBL_AMT                                NUMBER,
	AR_INCOME_AMT                              NUMBER,
	AR_RESET_AMT                               NUMBER,
	AR_PUBL_PLACE                              VARCHAR2,
	AR_PUBL_NAME                               VARCHAR2,
	AR_INTR_RAT                                NUMBER,
	AR_CUST_SEQ                                NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_RESET_SLIP_ID                           NUMBER,
	AR_RESET_SLIP_IDSEQ                        NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_CP_BUY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_CP_BUY 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_CP_BUY
	(
		CP_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		COMP_CODE,
		PUBL_DT,
		EXPR_DT,
		DUSE_DT,
		PUBL_AMT,
		INCOME_AMT,
		RESET_AMT,
		PUBL_PLACE,
		PUBL_NAME,
		INTR_RAT,
		CUST_SEQ,
		SLIP_ID,
		SLIP_IDSEQ,
		RESET_SLIP_ID,
		RESET_SLIP_IDSEQ,
		REMARKS
	)
	Values
	(
		AR_CP_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_COMP_CODE,
		F_T_StringToDate(AR_PUBL_DT),
		F_T_StringToDate(AR_EXPR_DT),
		F_T_StringToDate(AR_DUSE_DT),
		AR_PUBL_AMT,
		AR_INCOME_AMT,
		AR_RESET_AMT,
		AR_PUBL_PLACE,
		AR_PUBL_NAME,
		AR_INTR_RAT,
		AR_CUST_SEQ,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_RESET_SLIP_ID,
		AR_RESET_SLIP_IDSEQ,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FIN_CP_BUY_U
(
	AR_CP_NO                                   VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2,
	AR_EXPR_DT                                 VARCHAR2,
	AR_DUSE_DT                                 VARCHAR2,
	AR_PUBL_AMT                                NUMBER,
	AR_INCOME_AMT                              NUMBER,
	AR_RESET_AMT                               NUMBER,
	AR_PUBL_PLACE                              VARCHAR2,
	AR_PUBL_NAME                               VARCHAR2,
	AR_INTR_RAT                                NUMBER,
	AR_CUST_SEQ                                NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_RESET_SLIP_ID                           NUMBER,
	AR_RESET_SLIP_IDSEQ                        NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_CP_BUY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_CP_BUY 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_CP_BUY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		COMP_CODE = AR_COMP_CODE,
		PUBL_DT = F_T_StringToDate(AR_PUBL_DT),
		EXPR_DT = F_T_StringToDate(AR_EXPR_DT),
		DUSE_DT = F_T_StringToDate(AR_DUSE_DT),
		PUBL_AMT = AR_PUBL_AMT,
		INCOME_AMT = AR_INCOME_AMT,
		RESET_AMT = AR_RESET_AMT,
		PUBL_PLACE = AR_PUBL_PLACE,
		PUBL_NAME = AR_PUBL_NAME,
		INTR_RAT = AR_INTR_RAT,
		CUST_SEQ = AR_CUST_SEQ,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		RESET_SLIP_ID = AR_RESET_SLIP_ID,
		RESET_SLIP_IDSEQ = AR_RESET_SLIP_IDSEQ,
		REMARKS = AR_REMARKS
	Where	CP_NO = AR_CP_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_CP_BUY_D
(
	AR_CP_NO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_CP_BUY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_CP_BUY 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_CP_BUY
	Where	CP_NO = AR_CP_NO;
End;
/
