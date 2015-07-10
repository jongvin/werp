Create Or Replace Procedure SP_T_FL_M_MARKET_I
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITR_RATIO                               NUMBER,
	AR_P_D_UD_TAG                              VARCHAR2,
	AR_P_D_UD_POS                              NUMBER,
	AR_P_M_UD_TAG                              VARCHAR2,
	AR_P_M_UD_POS                              NUMBER,
	AR_P_Y_UD_TAG                              VARCHAR2,
	AR_P_Y_UD_POS                              NUMBER,
	AR_P_ML_RATIO                              NUMBER,
	AR_P_YL_RATIO                              NUMBER,
	AR_P_D_RATIO                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_M_MARKET_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_M_MARKET 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Insert Into T_FL_M_MARKET
	(
		M_MARKET_STAT_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITR_RATIO,
		P_D_UD_TAG,
		P_D_UD_POS,
		P_M_UD_TAG,
		P_M_UD_POS,
		P_Y_UD_TAG,
		P_Y_UD_POS,
		P_ML_RATIO,
		P_YL_RATIO,
		P_D_RATIO
	)
	Values
	(
		AR_M_MARKET_STAT_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITR_RATIO,
		AR_P_D_UD_TAG,
		AR_P_D_UD_POS,
		AR_P_M_UD_TAG,
		AR_P_M_UD_POS,
		AR_P_Y_UD_TAG,
		AR_P_Y_UD_POS,
		AR_P_ML_RATIO,
		AR_P_YL_RATIO,
		AR_P_D_RATIO
	);
End;
/
Create Or Replace Procedure SP_T_FL_M_MARKET_U
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITR_RATIO                               NUMBER,
	AR_P_D_UD_TAG                              VARCHAR2,
	AR_P_D_UD_POS                              NUMBER,
	AR_P_M_UD_TAG                              VARCHAR2,
	AR_P_M_UD_POS                              NUMBER,
	AR_P_Y_UD_TAG                              VARCHAR2,
	AR_P_Y_UD_POS                              NUMBER,
	AR_P_ML_RATIO                              NUMBER,
	AR_P_YL_RATIO                              NUMBER,
	AR_P_D_RATIO                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_M_MARKET_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_M_MARKET 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Update T_FL_M_MARKET
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITR_RATIO = AR_ITR_RATIO,
		P_D_UD_TAG = AR_P_D_UD_TAG,
		P_D_UD_POS = AR_P_D_UD_POS,
		P_M_UD_TAG = AR_P_M_UD_TAG,
		P_M_UD_POS = AR_P_M_UD_POS,
		P_Y_UD_TAG = AR_P_Y_UD_TAG,
		P_Y_UD_POS = AR_P_Y_UD_POS,
		P_ML_RATIO = AR_P_ML_RATIO,
		P_YL_RATIO = AR_P_YL_RATIO,
		P_D_RATIO = AR_P_D_RATIO
	Where	M_MARKET_STAT_CODE = AR_M_MARKET_STAT_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
Create Or Replace Procedure SP_T_FL_M_MARKET_D
(
	AR_M_MARKET_STAT_CODE                      VARCHAR2,
	AR_WORK_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_M_MARKET_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_M_MARKET 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-04-21)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Delete T_FL_M_MARKET
	Where	M_MARKET_STAT_CODE = AR_M_MARKET_STAT_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
