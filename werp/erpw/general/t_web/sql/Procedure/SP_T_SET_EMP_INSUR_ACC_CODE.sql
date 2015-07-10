Create Or Replace Procedure SP_T_SET_EMP_INSUR_ACC_CODE_I
(
	AR_ACC_CODE                                VARCHAR2,
	AR_S_AMT_TAG                               VARCHAR2,
	AR_T_DFLT_TAG                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_EMP_INSUR_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_EMP_INSUR_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SET_EMP_INSUR_ACC_CODE
	(
		ACC_CODE,
		S_AMT_TAG,
		T_DFLT_TAG
	)
	Values
	(
		AR_ACC_CODE,
		AR_S_AMT_TAG,
		AR_T_DFLT_TAG
	);
End;
/
Create Or Replace Procedure SP_T_SET_EMP_INSUR_ACC_CODE_U
(
	AR_ACC_CODE                                VARCHAR2,
	AR_S_AMT_TAG                               VARCHAR2,
	AR_T_DFLT_TAG                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_EMP_INSUR_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_EMP_INSUR_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update	T_SET_EMP_INSUR_ACC_CODE
	Set		S_AMT_TAG = AR_S_AMT_TAG,
			T_DFLT_TAG = AR_T_DFLT_TAG
	Where	ACC_CODE = AR_ACC_CODE;
End;
/
Create Or Replace Procedure SP_T_SET_EMP_INSUR_ACC_CODE_D
(
	AR_ACC_CODE                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SET_EMP_INSUR_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SET_EMP_INSUR_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_SET_EMP_INSUR_ACC_CODE
	Where	ACC_CODE = AR_ACC_CODE;
End;
/
