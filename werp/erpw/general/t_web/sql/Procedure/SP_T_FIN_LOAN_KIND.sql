Create Or Replace Procedure SP_T_FIN_LOAN_KIND_I
(
	AR_LOAN_KIND_CODE                          VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_LOAN_KIND_NAME                          VARCHAR2,
	AR_LOAN_ACC_CODE                           VARCHAR2,
	AR_ITR_ACC_CODE                            VARCHAR2,
	AR_PE_ITR_ACC_CODE                         VARCHAR2,
	AR_AE_ITR_ACC_CODE                         VARCHAR2,
	AR_LOAN_TAG                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_KIND_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_KIND 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-20)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_LOAN_KIND
	(
		LOAN_KIND_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		LOAN_KIND_NAME,
		LOAN_ACC_CODE,
		ITR_ACC_CODE,
		PE_ITR_ACC_CODE,
		AE_ITR_ACC_CODE,
		LOAN_TAG
	)
	Values
	(
		AR_LOAN_KIND_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_LOAN_KIND_NAME,
		AR_LOAN_ACC_CODE,
		AR_ITR_ACC_CODE,
		AR_PE_ITR_ACC_CODE,
		AR_AE_ITR_ACC_CODE,
		AR_LOAN_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_KIND_U
(
	AR_LOAN_KIND_CODE                          VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_LOAN_KIND_NAME                          VARCHAR2,
	AR_LOAN_ACC_CODE                           VARCHAR2,
	AR_ITR_ACC_CODE                            VARCHAR2,
	AR_PE_ITR_ACC_CODE                         VARCHAR2,
	AR_AE_ITR_ACC_CODE                         VARCHAR2,
	AR_LOAN_TAG                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_KIND_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_KIND 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-20)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_LOAN_KIND
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		LOAN_KIND_NAME = AR_LOAN_KIND_NAME,
		LOAN_ACC_CODE = AR_LOAN_ACC_CODE,
		ITR_ACC_CODE = AR_ITR_ACC_CODE,
		PE_ITR_ACC_CODE = AR_PE_ITR_ACC_CODE,
		AE_ITR_ACC_CODE = AR_AE_ITR_ACC_CODE,
		LOAN_TAG = AR_LOAN_TAG
	Where	LOAN_KIND_CODE = AR_LOAN_KIND_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_LOAN_KIND_D
(
	AR_LOAN_KIND_CODE                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_LOAN_KIND_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_LOAN_KIND 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-20)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lnCnt			Number;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_FIN_BILL_KIND
	Where	REL_LOAN_KIND_CODE = AR_LOAN_KIND_CODE;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'해당 차입종류코드와 관련이 있는 지급어음 구분이 있으므로 삭제가 불가능 합니다.');
	End If;
	Delete T_FIN_LOAN_KIND
	Where	LOAN_KIND_CODE = AR_LOAN_KIND_CODE;
End;
/
