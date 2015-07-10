Create Or Replace Procedure SP_T_FIN_PAY_SAL_LIST_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_IN_OUT_TAG                              VARCHAR2,
	AR_SUDANGCD                                VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_SAFE_MNG_TAG                            VARCHAR2,
	AR_AMT                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SAL_LIST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SAL_LIST 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_PAY_SAL_LIST
	(
		COMP_CODE,
		WORK_SEQ,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		EMP_NO,
		IN_OUT_TAG,
		SUDANGCD,
		DEPT_CODE,
		SAFE_MNG_TAG,
		AMT
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_SEQ,
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_EMP_NO,
		AR_IN_OUT_TAG,
		AR_SUDANGCD,
		AR_DEPT_CODE,
		AR_SAFE_MNG_TAG,
		AR_AMT
	);
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SAL_LIST_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_IN_OUT_TAG                              VARCHAR2,
	AR_SUDANGCD                                VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_SAFE_MNG_TAG                            VARCHAR2,
	AR_AMT                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SAL_LIST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SAL_LIST 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_PAY_SAL_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		EMP_NO = AR_EMP_NO,
		IN_OUT_TAG = AR_IN_OUT_TAG,
		SUDANGCD = AR_SUDANGCD,
		DEPT_CODE = AR_DEPT_CODE,
		SAFE_MNG_TAG = AR_SAFE_MNG_TAG,
		AMT = AR_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_SEQ = AR_WORK_SEQ
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SAL_LIST_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_SEQ                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SAL_LIST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SAL_LIST 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_PAY_SAL_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_SEQ = AR_WORK_SEQ
	And	SEQ = AR_SEQ;
End;
/
