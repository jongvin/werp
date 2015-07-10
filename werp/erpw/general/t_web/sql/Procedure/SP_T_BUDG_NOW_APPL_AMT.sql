Create Or Replace Procedure SP_T_BUDG_NOW_APPL_AMT_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_ITEM_NO                                 NUMBER,
	AR_BUDG_YM                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_UNIT_COST                               NUMBER,
	AR_QTY                                     NUMBER,
	AR_AMT                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_NOW_APPL_AMT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_NOW_APPL_AMT 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_NOW_APPL_AMT
	(
		COMP_CODE,
		CLSE_ACC_ID,
		ALL_CHG_SEQ,
		DEPT_CODE,
		EMP_NO,
		BUDG_CODE_NO,
		ITEM_NO,
		BUDG_YM,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		UNIT_COST,
		QTY,
		AMT
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_ALL_CHG_SEQ,
		AR_DEPT_CODE,
		AR_EMP_NO,
		AR_BUDG_CODE_NO,
		AR_ITEM_NO,
		F_T_StringToDate(AR_BUDG_YM),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_UNIT_COST,
		AR_QTY,
		AR_AMT
	);
End;
/
Create Or Replace Procedure SP_T_BUDG_NOW_APPL_AMT_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_ITEM_NO                                 NUMBER,
	AR_BUDG_YM                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_UNIT_COST                               NUMBER,
	AR_QTY                                     NUMBER,
	AR_AMT                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_NOW_APPL_AMT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_NOW_APPL_AMT 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_BUDG_NOW_APPL_AMT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		UNIT_COST = AR_UNIT_COST,
		QTY = AR_QTY,
		AMT = AR_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ
	And	DEPT_CODE = AR_DEPT_CODE
	And	EMP_NO = AR_EMP_NO
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	ITEM_NO = AR_ITEM_NO
	And	BUDG_YM = to_Date(AR_BUDG_YM,'YYYY-MM');
End;
/
Create Or Replace Procedure SP_T_BUDG_NOW_APPL_AMT_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_ALL_CHG_SEQ                             NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_ITEM_NO                                 NUMBER,
	AR_BUDG_YM                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_NOW_APPL_AMT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_NOW_APPL_AMT 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-01-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_BUDG_NOW_APPL_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	ALL_CHG_SEQ = AR_ALL_CHG_SEQ
	And	DEPT_CODE = AR_DEPT_CODE
	And	EMP_NO = AR_EMP_NO
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	ITEM_NO = AR_ITEM_NO
	And	BUDG_YM = to_Date(AR_BUDG_YM,'YYYY-MM');
End;
/
