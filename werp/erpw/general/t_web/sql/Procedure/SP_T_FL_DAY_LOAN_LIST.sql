Create Or Replace Procedure SP_T_FL_DAY_LOAN_LIST_I
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_LOAN_LIMIT_AMT                          NUMBER,
	AR_LOAN_USE_AMT                            NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DAY_LOAN_LIST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DAY_LOAN_LIST 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_DAY_LOAN_LIST
	(
		FL_LOAN_KIND_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		LOAN_LIMIT_AMT,
		LOAN_USE_AMT,
		REMARKS
	)
	Values
	(
		AR_FL_LOAN_KIND_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_LOAN_LIMIT_AMT,
		AR_LOAN_USE_AMT,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_DAY_LOAN_LIST_U
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_LOAN_LIMIT_AMT                          NUMBER,
	AR_LOAN_USE_AMT                            NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DAY_LOAN_LIST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DAY_LOAN_LIST 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_DAY_LOAN_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		LOAN_LIMIT_AMT = AR_LOAN_LIMIT_AMT,
		LOAN_USE_AMT = AR_LOAN_USE_AMT,
		REMARKS = AR_REMARKS
	Where	FL_LOAN_KIND_CODE = AR_FL_LOAN_KIND_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
Create Or Replace Procedure SP_T_FL_DAY_LOAN_LIST_D
(
	AR_FL_LOAN_KIND_CODE                       VARCHAR2,
	AR_WORK_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DAY_LOAN_LIST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DAY_LOAN_LIST 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_DAY_LOAN_LIST
	Where	FL_LOAN_KIND_CODE = AR_FL_LOAN_KIND_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
