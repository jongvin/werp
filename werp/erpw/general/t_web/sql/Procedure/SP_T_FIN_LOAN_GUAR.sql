Create Or Replace Procedure SP_T_FIN_LOAN_GUAR_I
(
	AR_LOAN_NO                                 VARCHAR2,
	AR_GUAR_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_GUARANTOR                               VARCHAR2,
	AR_GUAR_NO                                 VARCHAR2,
	AR_GUAR_NOTE                               VARCHAR2,
	AR_GUAR_START_DT                           VARCHAR2,
	AR_GUAR_END_DT                             VARCHAR2,
	AR_GUAR_ORG_AMT                            NUMBER,
	AR_GUAR_AMT                                NUMBER,
	AR_GUAR_RATE                               NUMBER,
	AR_GUAR_PAYMENT_DT                         VARCHAR2,
	AR_GUAR_ESTAB_DT                           VARCHAR2,
	AR_GUAR_CANCEL_DT                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_GUAR_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_GUAR 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_LOAN_GUAR
	(
		LOAN_NO,
		GUAR_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		GUARANTOR,
		GUAR_NO,
		GUAR_NOTE,
		GUAR_START_DT,
		GUAR_END_DT,
		GUAR_ORG_AMT,
		GUAR_AMT,
		GUAR_RATE,
		GUAR_PAYMENT_DT,
		GUAR_ESTAB_DT,
		GUAR_CANCEL_DT
	)
	Values
	(
		AR_LOAN_NO,
		AR_GUAR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_GUARANTOR,
		AR_GUAR_NO,
		AR_GUAR_NOTE,
		F_T_StringToDate(AR_GUAR_START_DT),
		F_T_StringToDate(AR_GUAR_END_DT),
		AR_GUAR_ORG_AMT,
		AR_GUAR_AMT,
		AR_GUAR_RATE,
		F_T_StringToDate(AR_GUAR_PAYMENT_DT),
		F_T_StringToDate(AR_GUAR_ESTAB_DT),
		F_T_StringToDate(AR_GUAR_CANCEL_DT)
	);
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_GUAR_U
(
	AR_LOAN_NO                                 VARCHAR2,
	AR_GUAR_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_GUARANTOR                               VARCHAR2,
	AR_GUAR_NO                                 VARCHAR2,
	AR_GUAR_NOTE                               VARCHAR2,
	AR_GUAR_START_DT                           VARCHAR2,
	AR_GUAR_END_DT                             VARCHAR2,
	AR_GUAR_ORG_AMT                            NUMBER,
	AR_GUAR_AMT                                NUMBER,
	AR_GUAR_RATE                               NUMBER,
	AR_GUAR_PAYMENT_DT                         VARCHAR2,
	AR_GUAR_ESTAB_DT                           VARCHAR2,
	AR_GUAR_CANCEL_DT                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_GUAR_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_GUAR 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_LOAN_GUAR
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		GUARANTOR = AR_GUARANTOR,
		GUAR_NO = AR_GUAR_NO,
		GUAR_NOTE = AR_GUAR_NOTE,
		GUAR_START_DT = F_T_StringToDate(AR_GUAR_START_DT),
		GUAR_END_DT = F_T_StringToDate(AR_GUAR_END_DT),
		GUAR_ORG_AMT = AR_GUAR_ORG_AMT,
		GUAR_AMT = AR_GUAR_AMT,
		GUAR_RATE = AR_GUAR_RATE,
		GUAR_PAYMENT_DT = F_T_StringToDate(AR_GUAR_PAYMENT_DT),
		GUAR_ESTAB_DT = F_T_StringToDate(AR_GUAR_ESTAB_DT),
		GUAR_CANCEL_DT = F_T_StringToDate(AR_GUAR_CANCEL_DT)
	Where	LOAN_NO = AR_LOAN_NO
	And	GUAR_SEQ = AR_GUAR_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_GUAR_D
(
	AR_LOAN_NO                                 VARCHAR2,
	AR_GUAR_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_GUAR_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_GUAR 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_LOAN_GUAR
	Where	LOAN_NO = AR_LOAN_NO
	And	GUAR_SEQ = AR_GUAR_SEQ;
End;
/
