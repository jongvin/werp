Create Or Replace Procedure SP_T_PROGRAM_STATUS_I
(
	AR_MENU_NO                                 NUMBER,
	AR_PROGRAM_NO                              NUMBER,
	AR_MAKE_PROGRAMMER                         VARCHAR2,
	AR_TEST_USER_NAME_1                        VARCHAR2,
	AR_TEST_USER_NAME_2                        VARCHAR2,
	AR_COMFIRM_USER_NAME                       VARCHAR2,
	AR_CHANGE_PROGRAMMER                       VARCHAR2,
	AR_MAKE_DT                                 VARCHAR2,
	AR_CHANGE_DT                               VARCHAR2,
	AR_CONFIRM_DT                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PROGRAM_STATUS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PROGRAM_STATUS 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_PROGRAM_STATUS
	(
		MENU_NO,
		PROGRAM_NO,
		MAKE_PROGRAMMER,
		TEST_USER_NAME_1,
		TEST_USER_NAME_2,
		COMFIRM_USER_NAME,
		CHANGE_PROGRAMMER,
		MAKE_DT,
		CHANGE_DT,
		CONFIRM_DT
	)
	Values
	(
		AR_MENU_NO,
		AR_PROGRAM_NO,
		AR_MAKE_PROGRAMMER,
		AR_TEST_USER_NAME_1,
		AR_TEST_USER_NAME_2,
		AR_COMFIRM_USER_NAME,
		AR_CHANGE_PROGRAMMER,
		F_T_StringToDate(AR_MAKE_DT),
		F_T_StringToDate(AR_CHANGE_DT),
		F_T_StringToDate(AR_CONFIRM_DT)
	);
End;
/
Create Or Replace Procedure SP_T_PROGRAM_STATUS_U
(
	AR_MENU_NO                                 NUMBER,
	AR_PROGRAM_NO                              NUMBER,
	AR_MAKE_PROGRAMMER                         VARCHAR2,
	AR_TEST_USER_NAME_1                        VARCHAR2,
	AR_TEST_USER_NAME_2                        VARCHAR2,
	AR_COMFIRM_USER_NAME                       VARCHAR2,
	AR_CHANGE_PROGRAMMER                       VARCHAR2,
	AR_MAKE_DT                                 VARCHAR2,
	AR_CHANGE_DT                               VARCHAR2,
	AR_CONFIRM_DT                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PROGRAM_STATUS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PROGRAM_STATUS 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_PROGRAM_STATUS
	Set
		MAKE_PROGRAMMER = AR_MAKE_PROGRAMMER,
		TEST_USER_NAME_1 = AR_TEST_USER_NAME_1,
		TEST_USER_NAME_2 = AR_TEST_USER_NAME_2,
		COMFIRM_USER_NAME = AR_COMFIRM_USER_NAME,
		CHANGE_PROGRAMMER = AR_CHANGE_PROGRAMMER,
		MAKE_DT = F_T_StringToDate(AR_MAKE_DT),
		CHANGE_DT = F_T_StringToDate(AR_CHANGE_DT),
		CONFIRM_DT = F_T_StringToDate(AR_CONFIRM_DT)
	Where	MENU_NO = AR_MENU_NO
	And	PROGRAM_NO = AR_PROGRAM_NO;
End;
/
Create Or Replace Procedure SP_T_PROGRAM_STATUS_D
(
	AR_MENU_NO                                 NUMBER,
	AR_PROGRAM_NO                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PROGRAM_STATUS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PROGRAM_STATUS 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_PROGRAM_STATUS
	Where	MENU_NO = AR_MENU_NO
	And	PROGRAM_NO = AR_PROGRAM_NO;
End;
/
