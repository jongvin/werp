CREATE OR REPLACE Procedure SP_T_FIX_SHEET_I
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_ITEM_NM_CODE                            VARCHAR2,
	AR_FIX_ASSET_NO                            NUMBER,
	AR_ASSET_MNG_NO                            VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_GET_DT                                  VARCHAR2,
	AR_ASSET_NAME                              VARCHAR2,
	AR_ASSET_SIZE                              VARCHAR2,
	AR_PRODUCTION                              VARCHAR2,
	AR_CUST_SEQ                                NUMBER,
	AR_USAGE                                   VARCHAR2,
	AR_GET_CLS                                 VARCHAR2,
	AR_DEPREC_CLS                              VARCHAR2,
	AR_SRVLIFE                                 NUMBER,
	AR_ASSET_CNT                               NUMBER,
	AR_BASE_AMT                                NUMBER,
	AR_OLD_DEPREC_AMT                          NUMBER,
	AR_GET_COST_AMT                            NUMBER,
	AR_INC_SUM_AMT                             NUMBER,
	AR_SUB_SUM_AMT                             NUMBER,
	AR_NEW_OLD_ASSET                           VARCHAR2,
	AR_INCNTRY_OUTCNTRY_CLS                    VARCHAR2,
	AR_FIXED_CLS                               VARCHAR2,
	AR_FIXTURES_CLS                            VARCHAR2,
	AR_ETC_ASSET_TAG                           VARCHAR2,
	AR_DISPOSE_YEAR                            NUMBER,
	AR_DEPREC_FINISH                           VARCHAR2,
	AR_CAPITAL_OUT_AMT                         NUMBER,
	AR_GAIN_OUT_AMT                            NUMBER,
	AR_USE_REMARK                              VARCHAR2,
	AR_MNG_DEPT_CODE                           VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_ITEM_NM_SEQ                             NUMBER,
	AR_CHG_GET_AMT                             NUMBER,
	AR_SALE_DT                                 VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_WORK_SEQ                                NUMBER,
	AR_START_ASSET_AMT                         NUMBER,
	AR_CURR_ASSET_INC_AMT                      NUMBER,
	AR_CURR_ASSET_SUB_AMT                      NUMBER,
	AR_START_APPROP_AMT                        NUMBER,
	AR_CURR_APPROP_SUB_AMT                     NUMBER,
	AR_CURR_DEPREC_AMT                         NUMBER,
	AR_REMARK                                  VARCHAR2,
	AR_CUST_SEQ2				NUMBER,
	AR_ESTIMATE_AMT1			NUMBER,
	AR_ESTIMATE_AMT2			NUMBER,
	AR_FOREIGN_AMT				NUMBER,
	AR_MONEY_CLS				VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_SHEET_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_SHEET 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
ln_move_seq								       NUMBER;	
lsErrm										   Varchar2(2000);
lnErrNo										   Number;									
Begin
	Insert Into T_FIX_SHEET
	(
		FIX_ASSET_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ASSET_CLS_CODE,
		ITEM_CODE,
		ITEM_NM_CODE,
		FIX_ASSET_NO,
		ASSET_MNG_NO,
		COMP_CODE,
		GET_DT,
		ASSET_NAME,
		ASSET_SIZE,
		PRODUCTION,
		CUST_SEQ,
		USAGE,
		GET_CLS,
		DEPREC_CLS,
		SRVLIFE,
		ASSET_CNT,
		BASE_AMT,
		OLD_DEPREC_AMT,
		GET_COST_AMT,
		INC_SUM_AMT,
		SUB_SUM_AMT,
		NEW_OLD_ASSET,
		INCNTRY_OUTCNTRY_CLS,
		FIXED_CLS,
		FIXTURES_CLS,
		ETC_ASSET_TAG,
		DISPOSE_YEAR,
		DEPREC_FINISH,
		CAPITAL_OUT_AMT,
		GAIN_OUT_AMT,
		USE_REMARK,
		MNG_DEPT_CODE,
		DEPT_CODE,
		ITEM_NM_SEQ,
		CHG_GET_AMT,
		SALE_DT,
		SLIP_ID,
		SLIP_IDSEQ,
		WORK_SEQ,
		START_ASSET_AMT,
		CURR_ASSET_INC_AMT,
		CURR_ASSET_SUB_AMT,
		START_APPROP_AMT,
		CURR_APPROP_SUB_AMT,
		CURR_DEPREC_AMT,
		REMARK,
		CUST_SEQ2,				
		ESTIMATE_AMT1,			
		ESTIMATE_AMT2,			
		FOREIGN_AMT,				
		MONEY_CLS				
	)
	Values
	(
		AR_FIX_ASSET_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ASSET_CLS_CODE,
		AR_ITEM_CODE,
		AR_ITEM_NM_CODE,
		AR_FIX_ASSET_NO,
		AR_ASSET_MNG_NO,
		AR_COMP_CODE,
		F_T_StringToDate(AR_GET_DT),
		AR_ASSET_NAME,
		AR_ASSET_SIZE,
		AR_PRODUCTION,
		AR_CUST_SEQ,
		AR_USAGE,
		AR_GET_CLS,
		AR_DEPREC_CLS,
		AR_SRVLIFE,
		AR_ASSET_CNT,
		AR_BASE_AMT,
		AR_OLD_DEPREC_AMT,
		AR_GET_COST_AMT,
		AR_INC_SUM_AMT,
		AR_SUB_SUM_AMT,
		AR_NEW_OLD_ASSET,
		AR_INCNTRY_OUTCNTRY_CLS,
		AR_FIXED_CLS,
		AR_FIXTURES_CLS,
		AR_ETC_ASSET_TAG,
		AR_DISPOSE_YEAR,
		AR_DEPREC_FINISH,
		AR_CAPITAL_OUT_AMT,
		AR_GAIN_OUT_AMT,
		AR_USE_REMARK,
		AR_MNG_DEPT_CODE,
		AR_DEPT_CODE,
		AR_ITEM_NM_SEQ,
		AR_CHG_GET_AMT,
		F_T_StringToDate(AR_SALE_DT),
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_WORK_SEQ,
		AR_START_ASSET_AMT,
		AR_CURR_ASSET_INC_AMT,
		AR_CURR_ASSET_SUB_AMT,
		AR_START_APPROP_AMT,
		AR_CURR_APPROP_SUB_AMT,
		AR_CURR_DEPREC_AMT,
		AR_REMARK,
		AR_CUST_SEQ2,				
		AR_ESTIMATE_AMT1,			
		AR_ESTIMATE_AMT2,		
		AR_FOREIGN_AMT,			
		AR_MONEY_CLS	
	);
	
	
	SELECT SQ_T_FIX_MOVE.NEXTVAL MOVE_SEQ
	Into   ln_move_seq
	FROM   DUAL;
		
	Insert into T_FIX_MOVE
	(
	 	FIX_ASSET_SEQ,
		MOVE_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MOVE_DT_FROM,
		MOVE_DT_TO,
		DEPT_CODE,
		EMP_NO,
		MNG_MAIN,
		MNG_SUB,
		REAL_MOVE_SEQ
	) values
	(
	  	AR_FIX_ASSET_SEQ,
		ln_move_seq,
		AR_CRTUSERNO,
		sysdate,
		null,
		null,
		AR_GET_DT,
		null,
		AR_DEPT_CODE,
		null,
		null,
		null,
		0
	);
	Exception When Others Then
			lsErrm := SqlErrm;
			lnErrNo:= SQLCODE;
			lsErrm := Replace(lsErrm,'ORA-20009:','');
			Raise_Application_Error(-20009,'기본자산정보' ||ln_move_seq||'등록에러'||chr(10) || lnErrNo || ':' || lsErrm);  
End;
/

Create Or Replace Procedure SP_T_FIX_SHEET_U
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ASSET_CLS_CODE                          VARCHAR2,
	AR_ITEM_CODE                               VARCHAR2,
	AR_ITEM_NM_CODE                            VARCHAR2,
	AR_FIX_ASSET_NO                            NUMBER,
	AR_ASSET_MNG_NO                            VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_GET_DT                                  VARCHAR2,
	AR_ASSET_NAME                              VARCHAR2,
	AR_ASSET_SIZE                              VARCHAR2,
	AR_PRODUCTION                              VARCHAR2,
	AR_CUST_SEQ                                NUMBER,
	AR_USAGE                                   VARCHAR2,
	AR_GET_CLS                                 VARCHAR2,
	AR_DEPREC_CLS                              VARCHAR2,
	AR_SRVLIFE                                 NUMBER,
	AR_ASSET_CNT                               NUMBER,
	AR_BASE_AMT                                NUMBER,
	AR_OLD_DEPREC_AMT                          NUMBER,
	AR_GET_COST_AMT                            NUMBER,
	AR_INC_SUM_AMT                             NUMBER,
	AR_SUB_SUM_AMT                             NUMBER,
	AR_NEW_OLD_ASSET                           VARCHAR2,
	AR_INCNTRY_OUTCNTRY_CLS                    VARCHAR2,
	AR_FIXED_CLS                               VARCHAR2,
	AR_FIXTURES_CLS                            VARCHAR2,
	AR_ETC_ASSET_TAG                           VARCHAR2,
	AR_DISPOSE_YEAR                            NUMBER,
	AR_DEPREC_FINISH                           VARCHAR2,
	AR_CAPITAL_OUT_AMT                         NUMBER,
	AR_GAIN_OUT_AMT                            NUMBER,
	AR_USE_REMARK                              VARCHAR2,
	AR_MNG_DEPT_CODE                           VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_ITEM_NM_SEQ                             NUMBER,
	AR_CHG_GET_AMT                             NUMBER,
	AR_SALE_DT                                 VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_WORK_SEQ                                NUMBER,
	AR_START_ASSET_AMT                         NUMBER,
	AR_CURR_ASSET_INC_AMT                      NUMBER,
	AR_CURR_ASSET_SUB_AMT                      NUMBER,
	AR_START_APPROP_AMT                        NUMBER,
	AR_CURR_APPROP_SUB_AMT                     NUMBER,
	AR_CURR_DEPREC_AMT                         NUMBER,
	AR_REMARK                                  VARCHAR2,
	AR_CUST_SEQ2				NUMBER,
	AR_ESTIMATE_AMT1			NUMBER,
	AR_ESTIMATE_AMT2			NUMBER,
	AR_FOREIGN_AMT				NUMBER,
	AR_MONEY_CLS				VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_SHEET_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_SHEET 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIX_SHEET
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ASSET_CLS_CODE = AR_ASSET_CLS_CODE,
		ITEM_CODE = AR_ITEM_CODE,
		ITEM_NM_CODE = AR_ITEM_NM_CODE,
		FIX_ASSET_NO = AR_FIX_ASSET_NO,
		ASSET_MNG_NO = AR_ASSET_MNG_NO,
		COMP_CODE = AR_COMP_CODE,
		GET_DT = F_T_StringToDate(AR_GET_DT),
		ASSET_NAME = AR_ASSET_NAME,
		ASSET_SIZE = AR_ASSET_SIZE,
		PRODUCTION = AR_PRODUCTION,
		CUST_SEQ = AR_CUST_SEQ,
		USAGE = AR_USAGE,
		GET_CLS = AR_GET_CLS,
		DEPREC_CLS = AR_DEPREC_CLS,
		SRVLIFE = AR_SRVLIFE,
		ASSET_CNT = AR_ASSET_CNT,
		BASE_AMT = AR_BASE_AMT,
		OLD_DEPREC_AMT = AR_OLD_DEPREC_AMT,
		GET_COST_AMT = AR_GET_COST_AMT,
		INC_SUM_AMT = AR_INC_SUM_AMT,
		SUB_SUM_AMT = AR_SUB_SUM_AMT,
		NEW_OLD_ASSET = AR_NEW_OLD_ASSET,
		INCNTRY_OUTCNTRY_CLS = AR_INCNTRY_OUTCNTRY_CLS,
		FIXED_CLS = AR_FIXED_CLS,
		FIXTURES_CLS = AR_FIXTURES_CLS,
		ETC_ASSET_TAG = AR_ETC_ASSET_TAG,
		DISPOSE_YEAR = AR_DISPOSE_YEAR,
		DEPREC_FINISH = AR_DEPREC_FINISH,
		CAPITAL_OUT_AMT = AR_CAPITAL_OUT_AMT,
		GAIN_OUT_AMT = AR_GAIN_OUT_AMT,
		USE_REMARK = AR_USE_REMARK,
		MNG_DEPT_CODE = AR_MNG_DEPT_CODE,
		DEPT_CODE = AR_DEPT_CODE,
		ITEM_NM_SEQ = AR_ITEM_NM_SEQ,
		CHG_GET_AMT = AR_CHG_GET_AMT,
		SALE_DT = F_T_StringToDate(AR_SALE_DT),
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		WORK_SEQ = AR_WORK_SEQ,
		START_ASSET_AMT = AR_START_ASSET_AMT,
		CURR_ASSET_INC_AMT = AR_CURR_ASSET_INC_AMT,
		CURR_ASSET_SUB_AMT = AR_CURR_ASSET_SUB_AMT,
		START_APPROP_AMT = AR_START_APPROP_AMT,
		CURR_APPROP_SUB_AMT = AR_CURR_APPROP_SUB_AMT,
		CURR_DEPREC_AMT = AR_CURR_DEPREC_AMT,
		REMARK = AR_REMARK,
		CUST_SEQ2 = AR_CUST_SEQ2,
		ESTIMATE_AMT1 =AR_ESTIMATE_AMT1,
		ESTIMATE_AMT2 =AR_ESTIMATE_AMT2,
		FOREIGN_AMT = AR_FOREIGN_AMT,
		MONEY_CLS = AR_MONEY_CLS
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIX_SHEET_D
(
	AR_FIX_ASSET_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_SHEET_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_SHEET 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIX_SHEET
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
