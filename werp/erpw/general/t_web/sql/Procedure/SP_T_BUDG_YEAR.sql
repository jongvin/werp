Create Or Replace Procedure SP_T_BUDG_YEAR_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_MAKE_DT_F                               VARCHAR2,
	AR_MAKE_DT_T                               VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_YEAR_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_YEAR 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_YEAR
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MAKE_DT_F,
		MAKE_DT_T,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_MAKE_DT_F),
		F_T_StringToDate(AR_MAKE_DT_T),
		AR_REMARKS
	);
End;
/
Create Or Replace Procedure SP_T_BUDG_YEAR_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_MAKE_DT_F                               VARCHAR2,
	AR_MAKE_DT_T                               VARCHAR2,
	AR_REMARKS                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_YEAR_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_YEAR 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BUDG_YEAR
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		MAKE_DT_F,
		MAKE_DT_T,
		REMARKS
	)
	Values
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_MAKE_DT_F),
		F_T_StringToDate(AR_MAKE_DT_T),
		AR_REMARKS
	);
Exception When Dup_Val_On_Index Then	
	Update T_BUDG_YEAR
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		MAKE_DT_F = F_T_StringToDate(AR_MAKE_DT_F),
		MAKE_DT_T = F_T_StringToDate(AR_MAKE_DT_T),
		REMARKS = AR_REMARKS
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID;
End;
/
Create Or Replace Procedure SP_T_BUDG_YEAR_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BUDG_YEAR_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BUDG_YEAR 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_BUDG_YEAR
	Where	COMP_CODE = AR_COMP_CODE
	And	CLSE_ACC_ID = AR_CLSE_ACC_ID;
End;
/
