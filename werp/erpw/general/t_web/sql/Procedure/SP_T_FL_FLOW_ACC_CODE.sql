Create Or Replace Procedure SP_T_FL_FLOW_ACC_CODE_I
(
	AR_FLOW_CODE                               NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_REMARKS                                 VARCHAR2,
	AR_SUM_MTHD_TAG                            VARCHAR2,
	AR_SETOFF_ACC_CODE                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_SUM_MTHD_TAG Is Null Then
		Raise_Application_Error(-20009,'집계방법을 입력하여 주십시오.');
	End If;
	If AR_SUM_MTHD_TAG = '3' Then	--만약 상계라면
		If AR_SETOFF_ACC_CODE Is Null Then
			Raise_Application_Error(-20009,'상계추적 방법을 사용하실 경우는 반드시 상계계정을 입력하여 주십시오.');
		End If;
	End If;
	Insert Into T_FL_FLOW_ACC_CODE
	(
		FLOW_CODE,
		APPLY_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_CODE,
		SIGN_TAG,
		SLIP_SUM_MTHD_TAG,
		REMARKS,
		SUM_MTHD_TAG,
		SETOFF_ACC_CODE
	)
	Values
	(
		AR_FLOW_CODE,
		AR_APPLY_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_CODE,
		AR_SIGN_TAG,
		AR_SLIP_SUM_MTHD_TAG,
		AR_REMARKS,
		AR_SUM_MTHD_TAG,
		AR_SETOFF_ACC_CODE
	);
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_ACC_CODE_U
(
	AR_FLOW_CODE                               NUMBER,
	AR_APPLY_SEQ                               NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_SIGN_TAG                                VARCHAR2,
	AR_SLIP_SUM_MTHD_TAG                       VARCHAR2,
	AR_REMARKS                                 VARCHAR2,
	AR_SUM_MTHD_TAG                            VARCHAR2,
	AR_SETOFF_ACC_CODE                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_SUM_MTHD_TAG Is Null Then
		Raise_Application_Error(-20009,'집계방법을 입력하여 주십시오.');
	End If;
	If AR_SUM_MTHD_TAG = '3' Then	--만약 상계라면
		If AR_SETOFF_ACC_CODE Is Null Then
			Raise_Application_Error(-20009,'상계추적 방법을 사용하실 경우는 반드시 상계계정을 입력하여 주십시오.');
		End If;
	End If;
	Update T_FL_FLOW_ACC_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_CODE = AR_ACC_CODE,
		SIGN_TAG = AR_SIGN_TAG,
		SLIP_SUM_MTHD_TAG = AR_SLIP_SUM_MTHD_TAG,
		REMARKS = AR_REMARKS,
		SUM_MTHD_TAG = AR_SUM_MTHD_TAG,
		SETOFF_ACC_CODE = AR_SETOFF_ACC_CODE
	Where	FLOW_CODE = AR_FLOW_CODE
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
Create Or Replace Procedure SP_T_FL_FLOW_ACC_CODE_D
(
	AR_FLOW_CODE                               NUMBER,
	AR_APPLY_SEQ                               NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FL_FLOW_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FL_FLOW_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-04)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FL_FLOW_ACC_CODE
	Where	FLOW_CODE = AR_FLOW_CODE
	And	APPLY_SEQ = AR_APPLY_SEQ;
End;
/
