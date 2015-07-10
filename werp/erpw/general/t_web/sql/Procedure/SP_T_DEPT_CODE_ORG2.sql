Create Or Replace Procedure SP_T_DEPT_CODE_ORG2_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DEPT_NAME                               VARCHAR2,
	AR_DEPT_SHORT_NAME                         VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_TAX_COMP_CODE                           VARCHAR2,
	AR_BUDG_CLS                                VARCHAR2,
	AR_GROUP_DEPT_CODE                         VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_INPUT_DT_F                              VARCHAR2,
	AR_INPUT_DT_T                              VARCHAR2,
	AR_ACC_GRP_CODE                            NUMBER,
	AR_LEGA_DEPT                               VARCHAR2,
	AR_SAUP_TAX_TAG                            VARCHAR2,
	AR_EMP_CLASS_CODE                          VARCHAR2,
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_P_DEPT_CODE                             VARCHAR2,
	AR_DEPT_KIND_TAG                           VARCHAR2,
	AR_ACC_CLOSE_DT                            VARCHAR2,
	AR_ACC_CLOST_DT_SYS                        VARCHAR2,
	AR_CONS_AMT                                NUMBER,
	AR_BUDG_AMT                                NUMBER,
	AR_BUDG_APPL_DT                            VARCHAR2,
	AR_AS_AMT                                  NUMBER,
	AR_COST_DESC_TAG                           VARCHAR2,
	AR_COST_GUESS_AMT                          NUMBER,
	AR_F_CONS_AMT                              NUMBER,
	AR_F_BUDG_AMT                              NUMBER,
	AR_CHARGE_PERS                             VARCHAR2,
	AR_TAX_MNG_OFFICE                          VARCHAR2,
	AR_NP_PRT_TAG                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CODE_ORG2_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CODE_ORG 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Insert Into T_DEPT_CODE_ORG
	(
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DEPT_NAME,
		DEPT_SHORT_NAME,
		COMP_CODE,
		TAX_COMP_CODE,
		BUDG_CLS,
		GROUP_DEPT_CODE,
		COST_DEPT_KND_TAG,
		INPUT_DT_F,
		INPUT_DT_T,
		ACC_GRP_CODE,
		LEGA_DEPT,
		SAUP_TAX_TAG,
		EMP_CLASS_CODE,
		COST_CONV_CODE,
		P_DEPT_CODE,
		DEPT_KIND_TAG,
		ACC_CLOSE_DT,
		ACC_CLOST_DT_SYS,
		CONS_AMT,
		BUDG_AMT,
		BUDG_APPL_DT,
		AS_AMT,
		COST_DESC_TAG,
		COST_GUESS_AMT,
		F_CONS_AMT,
		F_BUDG_AMT,
		CHARGE_PERS,
		TAX_MNG_OFFICE,
		NP_PRT_TAG
	)
	Values
	(
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DEPT_NAME,
		AR_DEPT_SHORT_NAME,
		AR_COMP_CODE,
		AR_TAX_COMP_CODE,
		AR_BUDG_CLS,
		AR_GROUP_DEPT_CODE,
		AR_COST_DEPT_KND_TAG,
		F_T_StringToDate(AR_INPUT_DT_F),
		F_T_StringToDate(AR_INPUT_DT_T),
		AR_ACC_GRP_CODE,
		AR_LEGA_DEPT,
		AR_SAUP_TAX_TAG,
		AR_EMP_CLASS_CODE,
		AR_COST_CONV_CODE,
		AR_P_DEPT_CODE,
		AR_DEPT_KIND_TAG,
		F_T_StringToDate(AR_ACC_CLOSE_DT),
		F_T_StringToDate(AR_ACC_CLOST_DT_SYS),
		AR_CONS_AMT,
		AR_BUDG_AMT,
		F_T_StringToDate(AR_BUDG_APPL_DT),
		AR_AS_AMT,
		AR_COST_DESC_TAG,
		AR_COST_GUESS_AMT,
		AR_F_CONS_AMT,
		AR_F_BUDG_AMT,
		AR_CHARGE_PERS,
		AR_TAX_MNG_OFFICE,
		AR_NP_PRT_TAG
	);
End;
/
Create Or Replace Procedure SP_T_DEPT_CODE_ORG2_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DEPT_NAME                               VARCHAR2,
	AR_DEPT_SHORT_NAME                         VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_TAX_COMP_CODE                           VARCHAR2,
	AR_BUDG_CLS                                VARCHAR2,
	AR_GROUP_DEPT_CODE                         VARCHAR2,
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_INPUT_DT_F                              VARCHAR2,
	AR_INPUT_DT_T                              VARCHAR2,
	AR_ACC_GRP_CODE                            NUMBER,
	AR_LEGA_DEPT                               VARCHAR2,
	AR_SAUP_TAX_TAG                            VARCHAR2,
	AR_EMP_CLASS_CODE                          VARCHAR2,
	AR_COST_CONV_CODE                          VARCHAR2,
	AR_P_DEPT_CODE                             VARCHAR2,
	AR_DEPT_KIND_TAG                           VARCHAR2,
	AR_ACC_CLOSE_DT                            VARCHAR2,
	AR_ACC_CLOST_DT_SYS                        VARCHAR2,
	AR_CONS_AMT                                NUMBER,
	AR_BUDG_AMT                                NUMBER,
	AR_BUDG_APPL_DT                            VARCHAR2,
	AR_AS_AMT                                  NUMBER,
	AR_COST_DESC_TAG                           VARCHAR2,
	AR_COST_GUESS_AMT                          NUMBER,
	AR_F_CONS_AMT                              NUMBER,
	AR_F_BUDG_AMT                              NUMBER,
	AR_CHARGE_PERS                             VARCHAR2,
	AR_TAX_MNG_OFFICE                          VARCHAR2,
	AR_NP_PRT_TAG                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CODE_ORG2_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CODE_ORG 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Update T_DEPT_CODE_ORG
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DEPT_NAME = AR_DEPT_NAME,
		DEPT_SHORT_NAME = AR_DEPT_SHORT_NAME,
		COMP_CODE = AR_COMP_CODE,
		TAX_COMP_CODE = AR_TAX_COMP_CODE,
		BUDG_CLS = AR_BUDG_CLS,
		GROUP_DEPT_CODE = AR_GROUP_DEPT_CODE,
		COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG,
		INPUT_DT_F = F_T_StringToDate(AR_INPUT_DT_F),
		INPUT_DT_T = F_T_StringToDate(AR_INPUT_DT_T),
		ACC_GRP_CODE = AR_ACC_GRP_CODE,
		LEGA_DEPT = AR_LEGA_DEPT,
		SAUP_TAX_TAG = AR_SAUP_TAX_TAG,
		EMP_CLASS_CODE = AR_EMP_CLASS_CODE,
		COST_CONV_CODE = AR_COST_CONV_CODE,
		P_DEPT_CODE = AR_P_DEPT_CODE,
		DEPT_KIND_TAG = AR_DEPT_KIND_TAG,
		ACC_CLOSE_DT = F_T_StringToDate(AR_ACC_CLOSE_DT),
		ACC_CLOST_DT_SYS = F_T_StringToDate(AR_ACC_CLOST_DT_SYS),
		CONS_AMT = AR_CONS_AMT,
		BUDG_AMT = AR_BUDG_AMT,
		BUDG_APPL_DT = F_T_StringToDate(AR_BUDG_APPL_DT),
		AS_AMT = AR_AS_AMT,
		COST_DESC_TAG = AR_COST_DESC_TAG,
		COST_GUESS_AMT = AR_COST_GUESS_AMT,
		F_CONS_AMT = AR_F_CONS_AMT,
		F_BUDG_AMT = AR_F_BUDG_AMT,
		CHARGE_PERS = AR_CHARGE_PERS,
		TAX_MNG_OFFICE = AR_TAX_MNG_OFFICE,
		NP_PRT_TAG = AR_NP_PRT_TAG
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_DEPT_CODE_ORG2_D
(
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CODE_ORG2_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CODE_ORG 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-19)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Delete T_DEPT_CODE_ORG
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
