CREATE OR REPLACE Procedure SP_T_FIX_INCREDU_I
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_INCREDU_SEQ                             NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_INCREDU_DT                              VARCHAR2,
	AR_INCREDU_CLS                             VARCHAR2,
	AR_INCSUB_CNT                              NUMBER,
	AR_INCSUB_AMT                              NUMBER,
	AR_INCREDU_REMARK                          VARCHAR2,
	AR_APPROP_SUBAMT                           NUMBER,
	AR_ST_CUST_SEQ                           NUMBER,
	AR_EMP_NO                        		   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_INCREDU_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_INCREDU 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Insert Into T_FIX_INCREDU
	(
		FIX_ASSET_SEQ,
		INCREDU_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		INCREDU_DT,
		INCREDU_CLS,
		INCSUB_CNT,
		INCSUB_AMT,
		INCREDU_REMARK,
		APPROP_SUBAMT,
		ST_CUST_SEQ,
		ST_EMP_NO
	)
	Values
	(
		AR_FIX_ASSET_SEQ,
		AR_INCREDU_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_INCREDU_DT),
		AR_INCREDU_CLS,
		AR_INCSUB_CNT,
		AR_INCSUB_AMT,
		AR_INCREDU_REMARK,
		AR_APPROP_SUBAMT,
		AR_ST_CUST_SEQ,
		AR_EMP_NO

	);
	
	--매각, 폐기시 고정자산 상각 완료 변경 
	If AR_INCREDU_CLS = '3' Or AR_INCREDU_CLS ='4' Then
	   SP_T_FIX_SHEET_PRC(AR_FIX_ASSET_SEQ,AR_INCREDU_DT, AR_INCREDU_CLS);
	End If;
End;
/
Create Or Replace Procedure SP_T_FIX_INCREDU_U
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_INCREDU_SEQ                             NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_INCREDU_DT                              VARCHAR2,
	AR_INCREDU_CLS                             VARCHAR2,
	AR_INCSUB_CNT                              NUMBER,
	AR_INCSUB_AMT                              NUMBER,
	AR_INCREDU_REMARK                          VARCHAR2,
	AR_APPROP_SUBAMT                           NUMBER,
	AR_ST_CUST_SEQ                           NUMBER,
	AR_EMP_NO                        		   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_INCREDU_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_INCREDU 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIX_INCREDU
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		INCREDU_DT = F_T_StringToDate(AR_INCREDU_DT),
		INCREDU_CLS = AR_INCREDU_CLS,
		INCSUB_CNT = AR_INCSUB_CNT,
		INCSUB_AMT = AR_INCSUB_AMT,
		INCREDU_REMARK = AR_INCREDU_REMARK,
		APPROP_SUBAMT = AR_APPROP_SUBAMT,
		ST_CUST_SEQ = AR_ST_CUST_SEQ,
		EMP_NO = AR_EMP_NO
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And	INCREDU_SEQ = AR_INCREDU_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIX_INCREDU_D
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_INCREDU_SEQ                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_INCREDU_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_INCREDU 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-01-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIX_INCREDU
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ
	And	INCREDU_SEQ = AR_INCREDU_SEQ;
End;
/
