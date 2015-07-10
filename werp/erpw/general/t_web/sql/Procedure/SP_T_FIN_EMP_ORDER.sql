Create Or Replace Procedure SP_T_FIN_EMP_ORDER_I
(
	AR_EMP_NO                                  VARCHAR2,
	AR_ORDER_SEQ                               NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_ORDER_DT                                VARCHAR2,
	AR_SAFE_MNG_TAG                            VARCHAR2,
	AR_WORK_TAG                                VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_ORDER_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_ORDER 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_EMP_ORDER
	(
		EMP_NO,
		ORDER_SEQ,
		DEPT_CODE,
		ORDER_DT,
		SAFE_MNG_TAG,
		WORK_TAG,
		REMARKS
	)
	Values
	(
		AR_EMP_NO,
		AR_ORDER_SEQ,
		AR_DEPT_CODE,
		F_T_StringToDate(AR_ORDER_DT),
		AR_SAFE_MNG_TAG,
		AR_WORK_TAG,
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_ORDER_U
(
	AR_EMP_NO                                  VARCHAR2,
	AR_ORDER_SEQ                               NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_ORDER_DT                                VARCHAR2,
	AR_SAFE_MNG_TAG                            VARCHAR2,
	AR_WORK_TAG                                VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_ORDER_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_ORDER 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_EMP_ORDER
	Set
		DEPT_CODE = AR_DEPT_CODE,
		ORDER_DT = F_T_StringToDate(AR_ORDER_DT),
		SAFE_MNG_TAG = AR_SAFE_MNG_TAG,
		WORK_TAG = AR_WORK_TAG,
		REMARKS = AR_REMARKS
	Where	EMP_NO = AR_EMP_NO
	And	ORDER_SEQ = AR_ORDER_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_ORDER_D
(
	AR_EMP_NO                                  VARCHAR2,
	AR_ORDER_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_ORDER_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_ORDER 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_EMP_ORDER
	Where	EMP_NO = AR_EMP_NO
	And	ORDER_SEQ = AR_ORDER_SEQ;
End;
/
