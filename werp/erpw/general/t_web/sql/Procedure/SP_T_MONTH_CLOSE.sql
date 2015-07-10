Create Or Replace Procedure SP_T_MONTH_CLOSE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CLSE_CLS                                VARCHAR2,
	AR_CLSE_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_MONTH_CLOSE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_MONTH_CLOSE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_MONTH_CLOSE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CLSE_MONTH,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CLSE_CLS,
		CLSE_DT
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		REPLACE(AR_CLSE_MONTH, '-', NULL),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CLSE_CLS,
		F_T_StringToDate(AR_CLSE_DT)
	);
End;
/
Create Or Replace Procedure SP_T_MONTH_CLOSE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CLSE_CLS                                VARCHAR2,
	AR_CLSE_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_MONTH_CLOSE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_MONTH_CLOSE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_MONTH_CLOSE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CLSE_CLS = AR_CLSE_CLS,
		CLSE_DT = F_T_StringToDate(AR_CLSE_DT)
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	CLSE_MONTH = AR_CLSE_MONTH;
End;
/
Create Or Replace Procedure SP_T_MONTH_CLOSE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CLSE_MONTH                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_MONTH_CLOSE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_MONTH_CLOSE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_DAY_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	CLSE_MONTH = AR_CLSE_MONTH;
	
	Delete T_MONTH_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	CLSE_MONTH = AR_CLSE_MONTH;
End;
/
