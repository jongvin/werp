Create Or Replace Procedure SP_T_FL_DEPT_FLOW_MA_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_PLAN_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DEPT_FLOW_MA_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DEPT_FLOW_MA 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_DEPT_FLOW_MA
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		PLAN_CONFIRM_TAG,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_PLAN_CONFIRM_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_FLOW_MA_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_PLAN_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DEPT_FLOW_MA_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DEPT_FLOW_MA 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_DEPT_FLOW_MA
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		PLAN_CONFIRM_TAG = AR_PLAN_CONFIRM_TAG,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_FLOW_MA_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DEPT_FLOW_MA_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DEPT_FLOW_MA 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lnCnt					Number;
	Function	GetDeptName
	Return Varchar2
	Is
		lsDeptName						T_DEPT_CODE_ORG.DEPT_NAME%Type;
	Begin
		Select
			DEPT_NAME
		Into
			lsDeptName
		From	T_DEPT_CODE_ORG
		Where	DEPT_CODE = AR_DEPT_CODE;
		Return lsDeptName;
	Exception When No_Data_Found Then
		Return '알 수 없는 현장';
	End;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_FL_MONTH_PLAN_EXEC
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	RowNum < 2;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'해당현장('||GetDeptName||')은 이미 현장별 자금수지작업이 이루어져 삭제가 불가능합니다. 만약 삭제하시려면 먼저 현장별자금수지 내역을 삭제하십시오.');
	End If;
	Select
		Count(*)
	Into
		lnCnt
	From	T_FL_MONTH_PLAN_EXEC_PROJ_B
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	RowNum < 2;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'해당현장('||GetDeptName||')은 이미 본사자금수지의 현장별 작업이 이루어져 삭제가 불가능합니다. 만약 삭제하시려면 먼저 본사자금수지의 현장별 작업 내역을 삭제하십시오.');
	End If;
	Delete T_FL_DEPT_FLOW_MA
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE;
End;
/
