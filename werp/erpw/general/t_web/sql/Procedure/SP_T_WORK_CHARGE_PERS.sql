Create Or Replace Procedure SP_T_WORK_CHARGE_PERS_I
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_CHARGE_PERS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_CHARGE_PERS 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-01)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_WORK_CHARGE_PERS
	(
		WORK_CODE,
		COMP_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CHARGE_PERS
	)
	Values
	(
		AR_WORK_CODE,
		AR_COMP_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CHARGE_PERS
	);
End;
/
Create Or Replace Procedure SP_T_WORK_CHARGE_PERS_U
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_CHARGE_PERS                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_CHARGE_PERS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_CHARGE_PERS 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-01)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_WORK_CHARGE_PERS
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CHARGE_PERS = AR_CHARGE_PERS
	Where	WORK_CODE = AR_WORK_CODE
	And	COMP_CODE = AR_COMP_CODE;
End;
/
Create Or Replace Procedure SP_T_WORK_CHARGE_PERS_D
(
	AR_WORK_CODE                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_CHARGE_PERS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_CHARGE_PERS 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-01)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_WORK_CHARGE_PERS
	Where	WORK_CODE = AR_WORK_CODE
	And	COMP_CODE = AR_COMP_CODE;
End;
/
