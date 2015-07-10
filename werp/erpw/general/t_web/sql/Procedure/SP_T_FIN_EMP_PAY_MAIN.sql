Create Or Replace Procedure SP_T_FIN_EMP_PAY_MAIN_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_OUT_ACC_NO                              VARCHAR2,
	AR_COST_ACC_CODE                           VARCHAR2,
	AR_PAY_ACC_CODE                            VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_PAY_MAIN_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_PAY_MAIN 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_EMP_PAY_MAIN
	(
		COMP_CODE,
		WORK_DT,
		WORK_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CONTENTS,
		OUT_ACC_NO,
		COST_ACC_CODE,
		PAY_ACC_CODE,
		CHARGE_PERS,
		FBS_TAG
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_WORK_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CONTENTS,
		AR_OUT_ACC_NO,
		AR_COST_ACC_CODE,
		AR_PAY_ACC_CODE,
		AR_CHARGE_PERS,
		'F'
	);
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_PAY_MAIN_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_WORK_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CONTENTS                                VARCHAR2,
	AR_OUT_ACC_NO                              VARCHAR2,
	AR_COST_ACC_CODE                           VARCHAR2,
	AR_PAY_ACC_CODE                            VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_PAY_MAIN_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_PAY_MAIN 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_EMP_PAY_MAIN
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CONTENTS = AR_CONTENTS,
		OUT_ACC_NO = AR_OUT_ACC_NO,
		COST_ACC_CODE = AR_COST_ACC_CODE,
		PAY_ACC_CODE = AR_PAY_ACC_CODE,
		CHARGE_PERS = AR_CHARGE_PERS
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	WORK_SEQ = AR_WORK_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_PAY_MAIN_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_WORK_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_PAY_MAIN_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_PAY_MAIN 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_EMP_PAY_MAIN
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	WORK_SEQ = AR_WORK_SEQ;
End;
/
