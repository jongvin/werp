Create Or Replace Procedure SP_T_PL_VIRTUAL_DEPT_I
(
	AR_V_DEPT_CODE                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_NAME                               VARCHAR2,
	AR_DEPT_SHORT_NAME                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_VIRTUAL_DEPT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_VIRTUAL_DEPT 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PL_VIRTUAL_DEPT
	(
		V_DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		COMP_CODE,
		DEPT_NAME,
		DEPT_SHORT_NAME
	)
	Values
	(
		AR_V_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_COMP_CODE,
		AR_DEPT_NAME,
		AR_DEPT_SHORT_NAME
	);
End;
/
Create Or Replace Procedure SP_T_PL_VIRTUAL_DEPT_U
(
	AR_V_DEPT_CODE                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_DEPT_NAME                               VARCHAR2,
	AR_DEPT_SHORT_NAME                         VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_VIRTUAL_DEPT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_VIRTUAL_DEPT 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PL_VIRTUAL_DEPT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		COMP_CODE = AR_COMP_CODE,
		DEPT_NAME = AR_DEPT_NAME,
		DEPT_SHORT_NAME = AR_DEPT_SHORT_NAME
	Where	V_DEPT_CODE = AR_V_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_PL_VIRTUAL_DEPT_D
(
	AR_V_DEPT_CODE                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_VIRTUAL_DEPT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_VIRTUAL_DEPT 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-12)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lnCnt				Number;
Begin
	Select
		Count(*)
	Into
		lnCnt
	from	T_PL_VIRTUAL_REAL_DEPT
	Where	V_DEPT_CODE = AR_V_DEPT_CODE;
	If lnCnt > 0 Then
		Raise_Application_Error(-20009,'해당 미확정현장(또는 가상현장)은 이미 실현장과 관계를 맺고 있으므로 삭제가 불가능합니다.');
	End If;
	Delete T_PL_VIRTUAL_DEPT
	Where	V_DEPT_CODE = AR_V_DEPT_CODE;
End;
/
