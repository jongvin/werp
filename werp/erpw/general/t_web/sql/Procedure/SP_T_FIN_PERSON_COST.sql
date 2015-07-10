Create Or Replace Procedure SP_T_FIN_PERSON_COST_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_ACCNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PERSON_COST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PERSON_COST 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_PERSON_COST
	(
		COMP_CODE,
		WORK_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		WORK_DT,
		CONTENTS,
		ACCNO
	)
	Values
	(
		AR_COMP_CODE,
		AR_WORK_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_StringToDate(AR_WORK_DT),
		AR_CONTENTS,
		AR_ACCNO
	);
End;
/
Create Or Replace Procedure SP_T_FIN_PERSON_COST_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_ACCNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PERSON_COST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PERSON_COST 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_PERSON_COST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		WORK_DT = F_T_StringToDate(AR_WORK_DT),
		CONTENTS = AR_CONTENTS,
		ACCNO = AR_ACCNO
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_PERSON_COST_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PERSON_COST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_PERSON_COST 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_PERSON_COST_LIST
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO;
	Delete T_FIN_PERSON_COST
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_NO = AR_WORK_NO;
End;
/
