Create Or Replace Procedure SP_T_PROGRAM_REQUEST_I
(
	AR_MENU_NO                                 NUMBER,
	AR_PROGRAM_NO                              NUMBER,
	AR_REQ_NO                                  NUMBER,
	AR_REQ_USER_NAME                           VARCHAR2,
	AR_REQ_CONTENTS                            VARCHAR2,
	AR_REQ_DT                                  VARCHAR2,
	AR_PROCESS_DT                              VARCHAR2,
	AR_PROCESS_TAG                             VARCHAR2,
	AR_CONFIRM_DT                              VARCHAR2,
	AR_CONFIRM_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PROGRAM_REQUEST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PROGRAM_REQUEST 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Insert Into T_PROGRAM_REQUEST
	(
		MENU_NO,
		PROGRAM_NO,
		REQ_NO,
		REQ_USER_NAME,
		REQ_CONTENTS,
		REQ_DT,
		PROCESS_DT,
		PROCESS_TAG,
		CONFIRM_DT,
		CONFIRM_TAG
	)
	Values
	(
		AR_MENU_NO,
		AR_PROGRAM_NO,
		AR_REQ_NO,
		AR_REQ_USER_NAME,
		AR_REQ_CONTENTS,
		F_T_StringToDate(AR_REQ_DT),
		F_T_StringToDate(AR_PROCESS_DT),
		AR_PROCESS_TAG,
		F_T_StringToDate(AR_CONFIRM_DT),
		AR_CONFIRM_TAG
	);
End;
/
Create Or Replace Procedure SP_T_PROGRAM_REQUEST_U
(
	AR_MENU_NO                                 NUMBER,
	AR_PROGRAM_NO                              NUMBER,
	AR_REQ_NO                                  NUMBER,
	AR_REQ_USER_NAME                           VARCHAR2,
	AR_REQ_CONTENTS                            VARCHAR2,
	AR_REQ_DT                                  VARCHAR2,
	AR_PROCESS_DT                              VARCHAR2,
	AR_PROCESS_TAG                             VARCHAR2,
	AR_CONFIRM_DT                              VARCHAR2,
	AR_CONFIRM_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PROGRAM_REQUEST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PROGRAM_REQUEST 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Update T_PROGRAM_REQUEST
	Set
		REQ_USER_NAME = AR_REQ_USER_NAME,
		REQ_CONTENTS = AR_REQ_CONTENTS,
		REQ_DT = F_T_StringToDate(AR_REQ_DT),
		PROCESS_DT = F_T_StringToDate(AR_PROCESS_DT),
		PROCESS_TAG = AR_PROCESS_TAG,
		CONFIRM_DT = F_T_StringToDate(AR_CONFIRM_DT),
		CONFIRM_TAG = AR_CONFIRM_TAG
	Where	MENU_NO = AR_MENU_NO
	And	PROGRAM_NO = AR_PROGRAM_NO
	And	REQ_NO = AR_REQ_NO;
End;
/
Create Or Replace Procedure SP_T_PROGRAM_REQUEST_D
(
	AR_MENU_NO                                 NUMBER,
	AR_PROGRAM_NO                              NUMBER,
	AR_REQ_NO                                  NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PROGRAM_REQUEST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PROGRAM_REQUEST 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-06)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
Begin
	Delete T_PROGRAM_REQUEST
	Where	MENU_NO = AR_MENU_NO
	And	PROGRAM_NO = AR_PROGRAM_NO
	And	REQ_NO = AR_REQ_NO;
End;
/
