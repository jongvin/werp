Create Or Replace Procedure SP_T_FL_DAY_FUND_IN_OUT_I
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_AMT                                     NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DAY_FUND_IN_OUT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DAY_FUND_IN_OUT 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_DAY_FUND_IN_OUT
	(
		ITEM_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		AMT,
		REMARKS
	)
	Values
	(
		AR_ITEM_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_AMT,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_DAY_FUND_IN_OUT_U
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_AMT                                     NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DAY_FUND_IN_OUT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DAY_FUND_IN_OUT 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_DAY_FUND_IN_OUT
	(
		ITEM_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		AMT,
		REMARKS
	)
	Values
	(
		AR_ITEM_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_AMT,
		AR_REMARKS
	);
Exception When Dup_Val_On_Index Then
	Update T_FL_DAY_FUND_IN_OUT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		AMT = AR_AMT,
		REMARKS = AR_REMARKS
	Where	ITEM_CODE = AR_ITEM_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
Create Or Replace Procedure SP_T_FL_DAY_FUND_IN_OUT_D
(
	AR_ITEM_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DAY_FUND_IN_OUT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DAY_FUND_IN_OUT 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_DAY_FUND_IN_OUT
	Where	ITEM_CODE = AR_ITEM_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
