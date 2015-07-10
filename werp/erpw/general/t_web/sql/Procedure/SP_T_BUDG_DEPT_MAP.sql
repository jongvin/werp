Create Or Replace Procedure SP_T_BUDG_DEPT_MAP_I
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CHK_DEPT_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_MAP_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_MAP 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_DEPT_MAP
	(
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHK_DEPT_CODE
	)
	Values
	(
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHK_DEPT_CODE
	);
Exception When Dup_Val_On_Index Then
	Update	T_BUDG_DEPT_MAP
	Set		MODUSERNO = AR_CRTUSERNO,
			MODDATE = SysDate,
			CHK_DEPT_CODE = AR_CHK_DEPT_CODE
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_BUDG_DEPT_MAP_U
(
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CHK_DEPT_CODE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_MAP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_MAP 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_DEPT_MAP
	(
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHK_DEPT_CODE
	)
	Values
	(
		AR_DEPT_CODE,
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHK_DEPT_CODE
	);
Exception When Dup_Val_On_Index Then
	Update	T_BUDG_DEPT_MAP
	Set		MODUSERNO = AR_MODUSERNO,
			MODDATE = SysDate,
			CHK_DEPT_CODE = AR_CHK_DEPT_CODE
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
Create Or Replace Procedure SP_T_BUDG_DEPT_MAP_D
(
	AR_DEPT_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_DEPT_MAP_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_DEPT_MAP 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_BUDG_DEPT_MAP
	Where	DEPT_CODE = AR_DEPT_CODE;
End;
/
