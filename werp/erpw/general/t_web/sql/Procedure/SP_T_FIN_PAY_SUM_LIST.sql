Create Or Replace Procedure SP_T_FIN_PAY_SUM_LIST_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CONTENTS                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SUM_LIST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SUM_LIST 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_PAY_SUM_LIST
	(
		COMP_CODE,
		WORK_DT,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CONTENTS
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CONTENTS
	);
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SUM_LIST_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CONTENTS                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SUM_LIST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SUM_LIST 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_PAY_SUM_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CONTENTS = AR_CONTENTS
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
Create Or Replace Procedure SP_T_FIN_PAY_SUM_LIST_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_SUM_LIST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PAY_SUM_LIST 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-13)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete	T_FIN_PAY_TARGET_SLIP_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = F_T_StringToDate(AR_WORK_DT);
	Delete	T_FIN_PAY_SUM_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And		WORK_DT = F_T_StringToDate(AR_WORK_DT);
End;
/
