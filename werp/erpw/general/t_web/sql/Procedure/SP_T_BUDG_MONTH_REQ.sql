Create Or Replace Procedure SP_T_BUDG_MONTH_REQ_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER,
	AR_BUDG_YM                                 VARCHAR2,
	AR_SEQ                           		   NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_REASON_CODE                             VARCHAR2,
	AR_BUDG_MONTH_REQ_AMT                      NUMBER,
	AR_CHG_AMT                                 NUMBER,
	AR_BUDG_MONTH_ASSIGN_AMT                   NUMBER,
	AR_CONFIRM_KIND                            VARCHAR2,
	AR_TAG                           		   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_MONTH_REQ_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_MONTH_REQ 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrParent							T_BUDG_DEPT_H%RowType;
Begin
	Select
		*
	Into
		lrParent
	From	T_BUDG_DEPT_H
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	
	If to_date(AR_BUDG_YM,'YYYY-MM') < lrParent.BUDG_APPLY_YM Then
		Raise_Application_Error(-20009,'예산변경 적용시작월 보다 작은 예산월은 입력하실 수 없습니다.');
	End If;
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ);
	SP_T_BUDG_CHECK_REQUEST(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ,AR_TAG);
	Insert Into T_BUDG_MONTH_REQ
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CHG_SEQ,
		BUDG_CODE_NO,
		RESERVED_SEQ,
		BUDG_YM,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		REASON_CODE,
		BUDG_MONTH_REQ_AMT,
		CHG_AMT,
		BUDG_MONTH_ASSIGN_AMT,
		CONFIRM_KIND
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CHG_SEQ,
		AR_BUDG_CODE_NO,
		AR_RESERVED_SEQ,
		to_date(AR_BUDG_YM,'YYYY-MM'),
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_REASON_CODE,
		AR_BUDG_MONTH_REQ_AMT,
		AR_CHG_AMT,
		AR_BUDG_MONTH_ASSIGN_AMT,
		AR_CONFIRM_KIND
	);
End;
/
Create Or Replace Procedure SP_T_BUDG_MONTH_REQ_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER,
	AR_BUDG_YM                                 VARCHAR2,
	AR_SEQ						               NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_REASON_CODE                             VARCHAR2,
	AR_BUDG_MONTH_REQ_AMT                      NUMBER,
	AR_CHG_AMT                                 NUMBER,
	AR_BUDG_MONTH_ASSIGN_AMT                   NUMBER,
	AR_CONFIRM_KIND                            VARCHAR2,
	AR_TAG                           		   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_MONTH_REQ_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_MONTH_REQ 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrParent							T_BUDG_DEPT_H%RowType;
Begin
	Select
		*
	Into
		lrParent
	From	T_BUDG_DEPT_H
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	
	If to_date(AR_BUDG_YM,'YYYY-MM') < lrParent.BUDG_APPLY_YM Then
		Raise_Application_Error(-20009,'예산변경 적용시작월 보다 작은 예산월은 입력하실 수 없습니다.');
	End If;
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ);
	SP_T_BUDG_CHECK_CONFIRM_KIND(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_BUDG_CODE_NO, AR_RESERVED_SEQ,  AR_BUDG_YM);
	SP_T_BUDG_CHECK_REQUEST(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_TAG);
	Update T_BUDG_MONTH_REQ
	Set
		REASON_CODE = AR_REASON_CODE,
		BUDG_MONTH_REQ_AMT = AR_BUDG_MONTH_REQ_AMT,
		CHG_AMT = AR_CHG_AMT,
		BUDG_MONTH_ASSIGN_AMT = AR_BUDG_MONTH_ASSIGN_AMT,
		CONFIRM_KIND = AR_CONFIRM_KIND
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ = AR_RESERVED_SEQ
	And	BUDG_YM =TO_DATE(AR_BUDG_YM,'YYYY-MM')
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_BUDG_MONTH_REQ_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_BUDG_CODE_NO                            NUMBER,
	AR_RESERVED_SEQ                            NUMBER,
	AR_BUDG_YM                                 VARCHAR2,
	AR_SEQ							NUMBER,
	AR_TAG                           		      VARCHAR2
	
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_MONTH_REQ_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_MONTH_REQ 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ);
	SP_T_BUDG_CHECK_CONFIRM_KIND(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_BUDG_CODE_NO, AR_RESERVED_SEQ,  AR_BUDG_YM);
	SP_T_BUDG_CHECK_REQUEST(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_DEPT_CODE,  AR_CHG_SEQ, AR_TAG);
	Delete T_BUDG_MONTH_REQ_DETAIL
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ = AR_RESERVED_SEQ
	And	BUDG_YM =TO_DATE(AR_BUDG_YM,'YYYY-MM')
	And	SEQ = AR_SEQ;
	
	Delete T_BUDG_MONTH_REQ
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	CHG_SEQ = AR_CHG_SEQ
	And	BUDG_CODE_NO = AR_BUDG_CODE_NO
	And	RESERVED_SEQ = AR_RESERVED_SEQ
	And	BUDG_YM =TO_DATE(AR_BUDG_YM,'YYYY-MM')
	And	SEQ = AR_SEQ;
End;
/
