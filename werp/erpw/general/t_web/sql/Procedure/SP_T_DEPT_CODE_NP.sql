Create Or Replace Procedure SP_T_DEPT_CODE_NP_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_NP_PRT_TAG                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_CODE_NP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_CODE_ORG 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_DEPT_CODE_ORG
	Set
		MODUSERNO = AR_CRTUSERNO,
		MODDATE = SYSDATE,
		NP_PRT_TAG = AR_NP_PRT_TAG
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
