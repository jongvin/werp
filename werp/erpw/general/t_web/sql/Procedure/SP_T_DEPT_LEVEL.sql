Create Or Replace Procedure SP_T_DEPT_LEVEL_I
(
	AR_DEPT_KIND_TAG                           VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DEPT_KIND_NAME                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_LEVEL_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_LEVEL 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_DEPT_LEVEL
	(
		DEPT_KIND_TAG,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DEPT_KIND_NAME
	)
	Values
	(
		AR_DEPT_KIND_TAG,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DEPT_KIND_NAME
	);
End;
/
Create Or Replace Procedure SP_T_DEPT_LEVEL_U
(
	AR_DEPT_KIND_TAG                           VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DEPT_KIND_NAME                          VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_LEVEL_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_LEVEL 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_DEPT_LEVEL
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DEPT_KIND_NAME = AR_DEPT_KIND_NAME
	Where	DEPT_KIND_TAG = AR_DEPT_KIND_TAG;
End;
/
Create Or Replace Procedure SP_T_DEPT_LEVEL_D
(
	AR_DEPT_KIND_TAG                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_DEPT_LEVEL_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_DEPT_LEVEL 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_DEPT_LEVEL
	Where	DEPT_KIND_TAG = AR_DEPT_KIND_TAG;
End;
/
