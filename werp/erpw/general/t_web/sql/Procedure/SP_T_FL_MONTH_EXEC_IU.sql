Create Or Replace Procedure SP_T_FL_MONTH_EXEC_IU
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_FLOW_CODE                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SUM_EXEC_AMT                            NUMBER,
	AR_MOD_EXEC_AMT                            NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_MONTH_PLAN_EXEC_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_MONTH_PLAN_EXEC 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_MONTH_PLAN_EXEC
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		WORK_YM,
		FLOW_CODE,
		CRTUSERNO,
		CRTDATE,
		EXEC_AMT,
		SUM_EXEC_AMT,
		MOD_EXEC_AMT
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_WORK_YM,
		AR_FLOW_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		Nvl(AR_SUM_EXEC_AMT,0) + Nvl(AR_MOD_EXEC_AMT,0) ,
		AR_SUM_EXEC_AMT,
		AR_MOD_EXEC_AMT
	);
Exception When Dup_Val_On_Index Then
	Update T_FL_MONTH_PLAN_EXEC
	Set
		MODUSERNO = AR_CRTUSERNO,
		MODDATE = SYSDATE,
		EXEC_AMT = Nvl(AR_SUM_EXEC_AMT,0) + Nvl(AR_MOD_EXEC_AMT,0),
		SUM_EXEC_AMT = AR_SUM_EXEC_AMT,
		MOD_EXEC_AMT = AR_MOD_EXEC_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	WORK_YM = AR_WORK_YM
	And	FLOW_CODE = AR_FLOW_CODE;
End;
/
