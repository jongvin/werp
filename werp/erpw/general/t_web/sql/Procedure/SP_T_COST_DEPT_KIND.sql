Create Or Replace Procedure SP_T_COST_DEPT_KIND_I
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_COST_DEPT_KND_NAME                      VARCHAR2,
	AR_PRT_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_COST_DEPT_KIND_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_COST_DEPT_KIND 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_COST_DEPT_KIND
	(
		COST_DEPT_KND_TAG,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		COST_DEPT_KND_NAME,
		PRT_SEQ
	)
	Values
	(
		AR_COST_DEPT_KND_TAG,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_COST_DEPT_KND_NAME,
		AR_PRT_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_COST_DEPT_KIND_U
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_COST_DEPT_KND_NAME                      VARCHAR2,
	AR_PRT_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_COST_DEPT_KIND_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_COST_DEPT_KIND 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_COST_DEPT_KIND
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		COST_DEPT_KND_NAME = AR_COST_DEPT_KND_NAME,
		PRT_SEQ = AR_PRT_SEQ
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
End;
/
Create Or Replace Procedure SP_T_COST_DEPT_KIND_D
(
	AR_COST_DEPT_KND_TAG                       VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_COST_DEPT_KIND_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_COST_DEPT_KIND 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lnCnt				Number;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_DEPT_CODE_ORG
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'해당 부서현장 구분은 현재 부서코드에서 사용중이므로 삭제가 불가능합니다.');
	End If;
	Select
		Count(*)
	Into
		lnCnt
	From	T_FIN_BILL_ACC_CODE
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'해당 부서현장 구분은 현재 지급어음별현장구분별계정에서 사용중이므로 삭제가 불가능합니다.');
	End If;
	Delete T_COST_DEPT_KIND
	Where	COST_DEPT_KND_TAG = AR_COST_DEPT_KND_TAG;
End;
/
