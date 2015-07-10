Create Or Replace Procedure SP_T_AUTO_REC_BILL_RESET_I
(
	AR_AUTO_REC_BILL_RESET_SEQ                   NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_RESET_AMT                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_REC_BILL_RESET_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_REC_BILL_RESET 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_REC_BILL_RESET
	(
		AUTO_REC_BILL_RESET_SEQ,
		SLIP_ID,
		SLIP_IDSEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		RESET_AMT
	)
	Values
	(
		AR_AUTO_REC_BILL_RESET_SEQ,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_RESET_AMT
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_REC_BILL_RESET_U
(
	AR_AUTO_REC_BILL_RESET_SEQ                   NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_RESET_AMT                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_REC_BILL_RESET_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_REC_BILL_RESET 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_AUTO_REC_BILL_RESET
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		RESET_AMT = AR_RESET_AMT
	Where	AUTO_REC_BILL_RESET_SEQ = AR_AUTO_REC_BILL_RESET_SEQ
	And	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_REC_BILL_RESET_D
(
	AR_AUTO_REC_BILL_RESET_SEQ                   NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_REC_BILL_RESET_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_REC_BILL_RESET 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_AUTO_REC_BILL_RESET
	Where	AUTO_REC_BILL_RESET_SEQ = AR_AUTO_REC_BILL_RESET_SEQ
	And	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
