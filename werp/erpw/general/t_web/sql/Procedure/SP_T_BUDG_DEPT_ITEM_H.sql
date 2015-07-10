CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_ITEM_H_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_TARGET_DEPT_CODE                        VARCHAR2,
	AR_BUDG_ADD_AMT                            NUMBER,
	AR_BUDG_ITEM_REQ_AMT                       NUMBER,
	AR_BUDG_ITEM_ASSIGN_AMT                    NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_ITEM_H_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_ITEM_H 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If;
	SP_T_BUDG_DEPT_ITEM_PARENT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,AR_CHG_SEQ,AR_CRTUSERNO);
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,AR_CHG_SEQ);
	Insert Into T_BUDG_DEPT_ITEM_H
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		TARGET_DEPT_CODE,
		BUDG_ADD_AMT,
		BUDG_ITEM_REQ_AMT,
		BUDG_ITEM_ASSIGN_AMT,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CHG_SEQ,
		AR_BUDG_CODE_NO,
		AR_RESERVED_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_TARGET_DEPT_CODE,
		AR_BUDG_ADD_AMT,
		AR_BUDG_ITEM_REQ_AMT,
		AR_BUDG_ITEM_ASSIGN_AMT,
		AR_REMARKS
	);
	
End;
/

Create Or Replace Procedure SP_T_BUDG_DEPT_ITEM_H_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_TARGET_DEPT_CODE                        VARCHAR2,
	AR_BUDG_ADD_AMT                            NUMBER,
	AR_BUDG_ITEM_REQ_AMT                       NUMBER,
	AR_BUDG_ITEM_ASSIGN_AMT                    NUMBER,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_ITEM_H_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_ITEM_H 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If;
	SP_T_BUDG_DEPT_ITEM_PARENT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,AR_CHG_SEQ,AR_MODUSERNO);
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,AR_CHG_SEQ);
	Update T_BUDG_DEPT_ITEM_H
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		TARGET_DEPT_CODE = AR_TARGET_DEPT_CODE,
		BUDG_ADD_AMT = AR_BUDG_ADD_AMT,
		BUDG_ITEM_REQ_AMT = AR_BUDG_ITEM_REQ_AMT,
		BUDG_ITEM_ASSIGN_AMT = AR_BUDG_ITEM_ASSIGN_AMT,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ = AR_RESERVED_SEQ;
End;
/
Create Or Replace Procedure SP_T_BUDG_DEPT_ITEM_H_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_ITEM_H_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_ITEM_H 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-30)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If;
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,AR_CHG_SEQ);
	Delete	T_BUDG_MONTH_AMT_H
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ = AR_RESERVED_SEQ;
	
	Delete T_BUDG_DEPT_ITEM_H
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ = AR_RESERVED_SEQ;
End;
/
