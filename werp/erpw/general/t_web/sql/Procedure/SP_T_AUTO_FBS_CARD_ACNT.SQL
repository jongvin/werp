Create Or Replace Procedure SP_T_AUTO_FBS_CARD_ACNT_I
(
	AR_SEQ                                     NUMBER,
	AR_CARDNUMBER                              NUMBER,
	AR_ADJUSTYEARMONTH                         VARCHAR2,
	AR_ACCTSUBSEQ                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_FBS_CARD_ACNT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_FBS_CARD_ACNT 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_FBS_CARD_ACNT
	(
		SEQ,
		CARDNUMBER,
		ADJUSTYEARMONTH,
		ACCTSUBSEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_SEQ,
		AR_CARDNUMBER,
		AR_ADJUSTYEARMONTH,
		AR_ACCTSUBSEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_FBS_CARD_ACNT_U
(
	AR_SEQ                                     NUMBER,
	AR_CARDNUMBER                              NUMBER,
	AR_ADJUSTYEARMONTH                         VARCHAR2,
	AR_ACCTSUBSEQ                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_FBS_CARD_ACNT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_FBS_CARD_ACNT 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_AUTO_FBS_CARD_ACNT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	SEQ = AR_SEQ
	And	CARDNUMBER = AR_CARDNUMBER
	And	ADJUSTYEARMONTH = AR_ADJUSTYEARMONTH
	And	ACCTSUBSEQ = AR_ACCTSUBSEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_FBS_CARD_ACNT_D
(
	AR_SEQ                                     NUMBER,
	AR_CARDNUMBER                              NUMBER,
	AR_ADJUSTYEARMONTH                         VARCHAR2,
	AR_ACCTSUBSEQ                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_FBS_CARD_ACNT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_FBS_CARD_ACNT 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_AUTO_FBS_CARD_ACNT
	Where	SEQ = AR_SEQ
	And	CARDNUMBER = AR_CARDNUMBER
	And	ADJUSTYEARMONTH = AR_ADJUSTYEARMONTH
	And	ACCTSUBSEQ = AR_ACCTSUBSEQ;
End;
/
