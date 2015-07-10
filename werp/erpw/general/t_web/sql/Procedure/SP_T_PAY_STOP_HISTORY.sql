Create Or Replace Procedure SP_T_PAY_STOP_HISTORY_I
(
	AR_CUST_SEQ                                NUMBER,
	AR_PAY_STOP_SEQ                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_PAY_STOP_CLS                            VARCHAR2,
	AR_PAY_STOPSTR_DT                          VARCHAR2,
	AR_PAY_STOPEND_DT                          VARCHAR2,
	AR_PAY_STOPSTR_MEMO                        VARCHAR2,
	AR_PAY_STOPEND_MEMO                        VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_PAY_STOP_AMT                            Number
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PAY_STOP_HISTORY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PAY_STOP_HISTORY 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-11-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PAY_STOP_HISTORY
	(
		CUST_SEQ,
		PAY_STOP_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		PAY_STOP_CLS,
		PAY_STOPSTR_DT,
		PAY_STOPEND_DT,
		PAY_STOPSTR_MEMO,
		PAY_STOPEND_MEMO,
		DEPT_CODE,
		PAY_STOP_AMT
	)
	Values
	(
		AR_CUST_SEQ,
		AR_PAY_STOP_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_PAY_STOP_CLS,
		F_T_StringToDate(AR_PAY_STOPSTR_DT),
		F_T_StringToDate(AR_PAY_STOPEND_DT),
		AR_PAY_STOPSTR_MEMO,
		AR_PAY_STOPEND_MEMO,
		AR_DEPT_CODE,
		AR_PAY_STOP_AMT
	);
End;
/
Create Or Replace Procedure SP_T_PAY_STOP_HISTORY_U
(
	AR_CUST_SEQ                                NUMBER,
	AR_PAY_STOP_SEQ                            NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_PAY_STOP_CLS                            VARCHAR2,
	AR_PAY_STOPSTR_DT                          VARCHAR2,
	AR_PAY_STOPEND_DT                          VARCHAR2,
	AR_PAY_STOPSTR_MEMO                        VARCHAR2,
	AR_PAY_STOPEND_MEMO                        VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_PAY_STOP_AMT                            Number
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PAY_STOP_HISTORY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PAY_STOP_HISTORY 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-11-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PAY_STOP_HISTORY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		PAY_STOP_CLS = AR_PAY_STOP_CLS,
		PAY_STOPSTR_DT = F_T_StringToDate(AR_PAY_STOPSTR_DT),
		PAY_STOPEND_DT = F_T_StringToDate(AR_PAY_STOPEND_DT),
		PAY_STOPSTR_MEMO = AR_PAY_STOPSTR_MEMO,
		PAY_STOPEND_MEMO = AR_PAY_STOPEND_MEMO,
		DEPT_CODE = AR_DEPT_CODE,
		PAY_STOP_AMT = AR_PAY_STOP_AMT
	Where	CUST_SEQ = AR_CUST_SEQ
	And	PAY_STOP_SEQ = AR_PAY_STOP_SEQ;
End;
/
Create Or Replace Procedure SP_T_PAY_STOP_HISTORY_D
(
	AR_CUST_SEQ                                NUMBER,
	AR_PAY_STOP_SEQ                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PAY_STOP_HISTORY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PAY_STOP_HISTORY 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-11-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PAY_STOP_HISTORY
	Where	CUST_SEQ = AR_CUST_SEQ
	And	PAY_STOP_SEQ = AR_PAY_STOP_SEQ;
End;
/
