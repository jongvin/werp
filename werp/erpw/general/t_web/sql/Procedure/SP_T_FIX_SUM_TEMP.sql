Create Or Replace Procedure SP_T_FIX_SUM_TEMP_I
(
	AR_WORK_SEQ                                NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SUM_CNT                                 NUMBER,
	AR_START_ASSET_AMT                         NUMBER,
	AR_CURR_ASSET_INC_AMT                      NUMBER,
	AR_CURR_ASSET_SUB_AMT                      NUMBER,
	AR_START_APPROP_AMT                        NUMBER,
	AR_CURR_APPROP_SUB_AMT                     NUMBER,
	AR_CURR_DEPREC_AMT                         NUMBER,
	AR_DEPREC_RAT                              NUMBER,
	AR_BEFORE_WORK_SEQ                         NUMBER,
	AR_BEFORE_ASSET_CNT                        NUMBER,
	AR_BEFORE_BASE_AMT                         NUMBER,
	AR_BEFORE_OLD_DEPREC_AMT                   NUMBER,
	AR_BEFORE_DEPREC_FINISH                    VARCHAR2,
	AR_BEFORE_INC_SUM_AMT                      NUMBER,
	AR_BEFORE_SUB_SUM_AMT                      NUMBER,
	AR_BASE_AMT                                NUMBER,
	AR_OLD_DEPREC_AMT                          NUMBER,
	AR_DEPREC_FINISH                           VARCHAR2,
	AR_INC_SUM_AMT                             NUMBER,
	AR_SUB_SUM_AMT                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_SUM_TEMP_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_SUM_TEMP 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-08)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIX_SUM_TEMP
	(
		WORK_SEQ,
		FIX_ASSET_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SUM_CNT,
		START_ASSET_AMT,
		CURR_ASSET_INC_AMT,
		CURR_ASSET_SUB_AMT,
		START_APPROP_AMT,
		CURR_APPROP_SUB_AMT,
		CURR_DEPREC_AMT,
		DEPREC_RAT,
		BEFORE_WORK_SEQ,
		BEFORE_ASSET_CNT,
		BEFORE_BASE_AMT,
		BEFORE_OLD_DEPREC_AMT,
		BEFORE_DEPREC_FINISH,
		BEFORE_INC_SUM_AMT,
		BEFORE_SUB_SUM_AMT,
		BASE_AMT,
		OLD_DEPREC_AMT,
		DEPREC_FINISH,
		INC_SUM_AMT,
		SUB_SUM_AMT
	)
	Values
	(
		AR_WORK_SEQ,
		AR_FIX_ASSET_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SUM_CNT,
		AR_START_ASSET_AMT,
		AR_CURR_ASSET_INC_AMT,
		AR_CURR_ASSET_SUB_AMT,
		AR_START_APPROP_AMT,
		AR_CURR_APPROP_SUB_AMT,
		AR_CURR_DEPREC_AMT,
		AR_DEPREC_RAT,
		AR_BEFORE_WORK_SEQ,
		AR_BEFORE_ASSET_CNT,
		AR_BEFORE_BASE_AMT,
		AR_BEFORE_OLD_DEPREC_AMT,
		AR_BEFORE_DEPREC_FINISH,
		AR_BEFORE_INC_SUM_AMT,
		AR_BEFORE_SUB_SUM_AMT,
		AR_BASE_AMT,
		AR_OLD_DEPREC_AMT,
		AR_DEPREC_FINISH,
		AR_INC_SUM_AMT,
		AR_SUB_SUM_AMT
	);
End;
/
Create Or Replace Procedure SP_T_FIX_SUM_TEMP_U
(
	AR_WORK_SEQ                                NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_SUM_CNT                                 NUMBER,
	AR_START_ASSET_AMT                         NUMBER,
	AR_CURR_ASSET_INC_AMT                      NUMBER,
	AR_CURR_ASSET_SUB_AMT                      NUMBER,
	AR_START_APPROP_AMT                        NUMBER,
	AR_CURR_APPROP_SUB_AMT                     NUMBER,
	AR_CURR_DEPREC_AMT                         NUMBER,
	AR_DEPREC_RAT                              NUMBER,
	AR_BEFORE_WORK_SEQ                         NUMBER,
	AR_BEFORE_ASSET_CNT                        NUMBER,
	AR_BEFORE_BASE_AMT                         NUMBER,
	AR_BEFORE_OLD_DEPREC_AMT                   NUMBER,
	AR_BEFORE_DEPREC_FINISH                    VARCHAR2,
	AR_BEFORE_INC_SUM_AMT                      NUMBER,
	AR_BEFORE_SUB_SUM_AMT                      NUMBER,
	AR_BASE_AMT                                NUMBER,
	AR_OLD_DEPREC_AMT                          NUMBER,
	AR_DEPREC_FINISH                           VARCHAR2,
	AR_INC_SUM_AMT                             NUMBER,
	AR_SUB_SUM_AMT                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_SUM_TEMP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_SUM_TEMP 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-08)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIX_SUM_TEMP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SUM_CNT = AR_SUM_CNT,
		START_ASSET_AMT = AR_START_ASSET_AMT,
		CURR_ASSET_INC_AMT = AR_CURR_ASSET_INC_AMT,
		CURR_ASSET_SUB_AMT = AR_CURR_ASSET_SUB_AMT,
		START_APPROP_AMT = AR_START_APPROP_AMT,
		CURR_APPROP_SUB_AMT = AR_CURR_APPROP_SUB_AMT,
		CURR_DEPREC_AMT = AR_CURR_DEPREC_AMT,
		DEPREC_RAT = AR_DEPREC_RAT,
		BEFORE_WORK_SEQ = AR_BEFORE_WORK_SEQ,
		BEFORE_ASSET_CNT = AR_BEFORE_ASSET_CNT,
		BEFORE_BASE_AMT = AR_BEFORE_BASE_AMT,
		BEFORE_OLD_DEPREC_AMT = AR_BEFORE_OLD_DEPREC_AMT,
		BEFORE_DEPREC_FINISH = AR_BEFORE_DEPREC_FINISH,
		BEFORE_INC_SUM_AMT = AR_BEFORE_INC_SUM_AMT,
		BEFORE_SUB_SUM_AMT = AR_BEFORE_SUB_SUM_AMT,
		BASE_AMT = AR_BASE_AMT,
		OLD_DEPREC_AMT = AR_OLD_DEPREC_AMT,
		DEPREC_FINISH = AR_DEPREC_FINISH,
		INC_SUM_AMT = AR_INC_SUM_AMT,
		SUB_SUM_AMT = AR_SUB_SUM_AMT
	Where	WORK_SEQ = AR_WORK_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIX_SUM_TEMP_D
(
	AR_WORK_SEQ                                NUMBER,
	AR_FIX_ASSET_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_SUM_TEMP_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_SUM_TEMP 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-08)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIX_FURNI_SUM_TEMP
	Where	WORK_SEQ = AR_WORK_SEQ
	And	      FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
	
	Delete T_FIX_SUM_TEMP
	Where	WORK_SEQ = AR_WORK_SEQ
	And	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
