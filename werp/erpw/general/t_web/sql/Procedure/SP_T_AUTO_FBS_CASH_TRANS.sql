Create Or Replace Procedure SP_T_AUTO_FBS_CASH_TRANS_I
(
	AR_SEQ                                     NUMBER,
	AR_TRANSFER_SEQ                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_FBS_CASH_TRANS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_FBS_CASH_TRANS 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_AUTO_FBS_CASH_TRANS
	(
		SEQ,
		TRANSFER_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	Values
	(
		AR_SEQ,
		AR_TRANSFER_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
End;
/
Create Or Replace Procedure SP_T_AUTO_FBS_CASH_TRANS_U
(
	AR_SEQ                                     NUMBER,
	AR_TRANSFER_SEQ                            NUMBER,
	AR_MODUSERNO                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_FBS_CASH_TRANS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_FBS_CASH_TRANS 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_AUTO_FBS_CASH_TRANS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	Where	SEQ = AR_SEQ
	And	TRANSFER_SEQ = AR_TRANSFER_SEQ;
End;
/
Create Or Replace Procedure SP_T_AUTO_FBS_CASH_TRANS_D
(
	AR_SEQ                                     NUMBER,
	AR_TRANSFER_SEQ                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_AUTO_FBS_CASH_TRANS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_AUTO_FBS_CASH_TRANS 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_AUTO_FBS_CASH_TRANS
	Where	SEQ = AR_SEQ
	And	TRANSFER_SEQ = AR_TRANSFER_SEQ;
End;
/
