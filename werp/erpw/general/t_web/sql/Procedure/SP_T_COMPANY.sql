Create Or Replace Procedure SP_T_COMPANY_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BIZNO                                   VARCHAR2,
	AR_COMPANY_NAME                            VARCHAR2,
	AR_HEAD_BRANCH_CLS                         VARCHAR2,
	AR_HEAD_COMP_CODE                          VARCHAR2,
	AR_BIZNO2                                  VARCHAR2,
	AR_OPEN_DT                                 VARCHAR2,
	AR_BOSS                                    VARCHAR2,
	AR_BOSS_NO                                 VARCHAR2,
	AR_BIZCOND                                 VARCHAR2,
	AR_BIZKND                                  VARCHAR2,
	AR_TELNO                                   VARCHAR2,
	AR_BIZPLACE_ZIPCODE                        VARCHAR2,
	AR_BIZPLACE_ADDR1                          VARCHAR2,
	AR_BIZPLACE_ADDR2                          VARCHAR2,
	AR_HEADOFF_ZIPCODE                         VARCHAR2,
	AR_HEADOFF_ADDR1                           VARCHAR2,
	AR_HEADOFF_ADDR2                           VARCHAR2,
	AR_TAX_OFFICE_NAME                         VARCHAR2,
	AR_BUDG_DIVERT_CLS                         VARCHAR2,
	AR_BUDG_TRANS_CLS                          VARCHAR2,
	AR_ACCOUNT_CURR                            NUMBER,
	AR_ACCOUNT_FDT                             VARCHAR2,
	AR_ACCOUNT_EDT                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_FIN_DEPT_CODE                           Varchar2 Default Null,
	AR_ACC_DEPT_CODE                           Varchar2 Default Null,
	AR_COMPANY_ACC_CODE                        Varchar2 Default Null,
	AR_VAT_RETURN_ACCNO                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_COMPANY_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_COMPANY 테이블 Insert
/* 4. 변  경  이  력 : 최언회 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_COMPANY
	(
		COMP_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BIZNO,
		COMPANY_NAME,
		HEAD_BRANCH_CLS,
		HEAD_COMP_CODE,
		BIZNO2,
		OPEN_DT,
		BOSS,
		BOSS_NO,
		BIZCOND,
		BIZKND,
		TELNO,
		BIZPLACE_ZIPCODE,
		BIZPLACE_ADDR1,
		BIZPLACE_ADDR2,
		HEADOFF_ZIPCODE,
		HEADOFF_ADDR1,
		HEADOFF_ADDR2,
		TAX_OFFICE_NAME,
		BUDG_DIVERT_CLS,
		BUDG_TRANS_CLS,
		ACCOUNT_CURR,
		ACCOUNT_FDT,
		ACCOUNT_EDT,
		DEPT_CODE,
		FIN_DEPT_CODE,
		ACC_DEPT_CODE,
		COMPANY_ACC_CODE,
		VAT_RETURN_ACCNO
	)
	Values
	(
		AR_COMP_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_Cust_UMask(AR_BIZNO),
		AR_COMPANY_NAME,
		AR_HEAD_BRANCH_CLS,
		AR_HEAD_COMP_CODE,
		F_T_Cust_UMask(AR_BIZNO2),
		F_T_StringToDate(AR_OPEN_DT),
		AR_BOSS,
		AR_BOSS_NO,
		AR_BIZCOND,
		AR_BIZKND,
		AR_TELNO,
		REPLACE(AR_BIZPLACE_ZIPCODE, '-', NULL),
		AR_BIZPLACE_ADDR1,
		AR_BIZPLACE_ADDR2,
		REPLACE(AR_HEADOFF_ZIPCODE, '-', NULL),
		AR_HEADOFF_ADDR1,
		AR_HEADOFF_ADDR2,
		AR_TAX_OFFICE_NAME,
		AR_BUDG_DIVERT_CLS,
		AR_BUDG_TRANS_CLS,
		AR_ACCOUNT_CURR,
		F_T_StringToDate(AR_ACCOUNT_FDT),
		F_T_StringToDate(AR_ACCOUNT_EDT),
		AR_DEPT_CODE,
		AR_FIN_DEPT_CODE,
		AR_ACC_DEPT_CODE,
		AR_COMPANY_ACC_CODE,
		AR_VAT_RETURN_ACCNO
	);
End;
/
Create Or Replace Procedure SP_T_COMPANY_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_BIZNO                                   VARCHAR2,
	AR_COMPANY_NAME                            VARCHAR2,
	AR_HEAD_BRANCH_CLS                         VARCHAR2,
	AR_HEAD_COMP_CODE                          VARCHAR2,
	AR_BIZNO2                                  VARCHAR2,
	AR_OPEN_DT                                 VARCHAR2,
	AR_BOSS                                    VARCHAR2,
	AR_BOSS_NO                                 VARCHAR2,
	AR_BIZCOND                                 VARCHAR2,
	AR_BIZKND                                  VARCHAR2,
	AR_TELNO                                   VARCHAR2,
	AR_BIZPLACE_ZIPCODE                        VARCHAR2,
	AR_BIZPLACE_ADDR1                          VARCHAR2,
	AR_BIZPLACE_ADDR2                          VARCHAR2,
	AR_HEADOFF_ZIPCODE                         VARCHAR2,
	AR_HEADOFF_ADDR1                           VARCHAR2,
	AR_HEADOFF_ADDR2                           VARCHAR2,
	AR_TAX_OFFICE_NAME                         VARCHAR2,
	AR_BUDG_DIVERT_CLS                         VARCHAR2,
	AR_BUDG_TRANS_CLS                          VARCHAR2,
	AR_ACCOUNT_CURR                            NUMBER,
	AR_ACCOUNT_FDT                             VARCHAR2,
	AR_ACCOUNT_EDT                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_FIN_DEPT_CODE                           Varchar2 Default Null,
	AR_ACC_DEPT_CODE                           Varchar2 Default Null,
	AR_COMPANY_ACC_CODE                        Varchar2 Default Null,
	AR_VAT_RETURN_ACCNO			 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_COMPANY_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_COMPANY 테이블 Update
/* 4. 변  경  이  력 : 최언회 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_COMPANY
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BIZNO = F_T_Cust_UMask(AR_BIZNO),
		COMPANY_NAME = AR_COMPANY_NAME,
		HEAD_BRANCH_CLS = AR_HEAD_BRANCH_CLS,
		HEAD_COMP_CODE = AR_HEAD_COMP_CODE,
		BIZNO2 = F_T_Cust_UMask(AR_BIZNO2),
		OPEN_DT = F_T_StringToDate(AR_OPEN_DT),
		BOSS = AR_BOSS,
		BOSS_NO = AR_BOSS_NO,
		BIZCOND = AR_BIZCOND,
		BIZKND = AR_BIZKND,
		TELNO = AR_TELNO,
		BIZPLACE_ZIPCODE = REPLACE(AR_BIZPLACE_ZIPCODE, '-', NULL),
		BIZPLACE_ADDR1 = AR_BIZPLACE_ADDR1,
		BIZPLACE_ADDR2 = AR_BIZPLACE_ADDR2,
		HEADOFF_ZIPCODE = REPLACE(AR_HEADOFF_ZIPCODE, '-', NULL),
		HEADOFF_ADDR1 = AR_HEADOFF_ADDR1,
		HEADOFF_ADDR2 = AR_HEADOFF_ADDR2,
		TAX_OFFICE_NAME = AR_TAX_OFFICE_NAME,
		BUDG_DIVERT_CLS = AR_BUDG_DIVERT_CLS,
		BUDG_TRANS_CLS = AR_BUDG_TRANS_CLS,
		ACCOUNT_CURR = AR_ACCOUNT_CURR,
		ACCOUNT_FDT = F_T_StringToDate(AR_ACCOUNT_FDT),
		ACCOUNT_EDT = F_T_StringToDate(AR_ACCOUNT_EDT),
		DEPT_CODE = AR_DEPT_CODE,
		FIN_DEPT_CODE = AR_FIN_DEPT_CODE,
		ACC_DEPT_CODE = AR_ACC_DEPT_CODE,
		COMPANY_ACC_CODE = AR_COMPANY_ACC_CODE,
		VAT_RETURN_ACCNO = AR_VAT_RETURN_ACCNO
	Where	COMP_CODE = AR_COMP_CODE;
End;
/
Create Or Replace Procedure SP_T_COMPANY_D
(
	AR_COMP_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_COMPANY_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_COMPANY 테이블 Delete
/* 4. 변  경  이  력 : 최언회 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_COMPANY
	Where	COMP_CODE = AR_COMP_CODE;
End;
/
