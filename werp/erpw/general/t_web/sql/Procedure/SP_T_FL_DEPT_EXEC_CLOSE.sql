Create Or Replace Procedure SP_T_FL_DEPT_EXEC_CLOSE_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_EXEC_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DEPT_EXEC_CLOSE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DEPT_EXEC_CLOSE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FL_DEPT_EXEC_CLOSE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		WORK_YM,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		EXEC_CONFIRM_TAG,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_DEPT_CODE,
		AR_WORK_YM,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_EXEC_CONFIRM_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_EXEC_CLOSE_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_EXEC_CONFIRM_TAG                        VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DEPT_EXEC_CLOSE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DEPT_EXEC_CLOSE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FL_DEPT_EXEC_CLOSE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		EXEC_CONFIRM_TAG = AR_EXEC_CONFIRM_TAG,
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	WORK_YM = AR_WORK_YM;
End;
/
Create Or Replace Procedure SP_T_FL_DEPT_EXEC_CLOSE_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_WORK_YM                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_DEPT_EXEC_CLOSE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_DEPT_EXEC_CLOSE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_DEPT_EXEC_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID
	And	DEPT_CODE = AR_DEPT_CODE
	And	WORK_YM = AR_WORK_YM;
End;
/
