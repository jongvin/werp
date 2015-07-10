Create Or Replace Procedure SP_T_TAX_BILL_HEAD_I
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BOOK_NO                                 NUMBER,
	AR_BOOK_SEQ                                NUMBER,
	AR_SER_NO                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_TAX_BILL_HEAD_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_TAX_BILL_HEAD 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_TAX_BILL_HEAD
	(
		SLIP_ID,
		SLIP_IDSEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BOOK_NO,
		BOOK_SEQ,
		SER_NO
	)
	Values
	(
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BOOK_NO,
		AR_BOOK_SEQ,
		AR_SER_NO
	);
End;
/
Create Or Replace Procedure SP_T_TAX_BILL_HEAD_U
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BOOK_NO                                 NUMBER,
	AR_BOOK_SEQ                                NUMBER,
	AR_SER_NO                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_TAX_BILL_HEAD_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_TAX_BILL_HEAD 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_TAX_BILL_HEAD
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BOOK_NO = AR_BOOK_NO,
		BOOK_SEQ = AR_BOOK_SEQ,
		SER_NO = AR_SER_NO
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
Create Or Replace Procedure SP_T_TAX_BILL_HEAD_D
(
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_TAX_BILL_HEAD_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_TAX_BILL_HEAD 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_TAX_BILL_HEAD
	Where	SLIP_ID = AR_SLIP_ID
	And	SLIP_IDSEQ = AR_SLIP_IDSEQ;
End;
/
