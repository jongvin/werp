Create Or Replace Procedure SP_T_FL_COMP_FORECAST_CLOSE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_QUARTER_YEAR                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_FORE_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_COMP_FORECAST_CLOSE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_COMP_FORECAST_CLOSE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_COMP_FORECAST_CLOSE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		QUARTER_YEAR,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		FORE_CONFIRM_TAG,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_QUARTER_YEAR,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_FORE_CONFIRM_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_COMP_FORECAST_CLOSE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_QUARTER_YEAR                            NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_FORE_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_COMP_FORECAST_CLOSE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_COMP_FORECAST_CLOSE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_COMP_FORECAST_CLOSE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		FORE_CONFIRM_TAG = AR_FORE_CONFIRM_TAG,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	QUARTER_YEAR = AR_QUARTER_YEAR;
End;
/
Create Or Replace Procedure SP_T_FL_COMP_FORECAST_CLOSE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_QUARTER_YEAR                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_COMP_FORECAST_CLOSE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_COMP_FORECAST_CLOSE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_COMP_FORECAST_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	QUARTER_YEAR = AR_QUARTER_YEAR;
End;
/
