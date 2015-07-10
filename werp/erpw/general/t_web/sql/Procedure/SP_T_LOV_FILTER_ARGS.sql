Create Or Replace Procedure SP_T_LOV_FILTER_ARGS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER,
	AR_FILTER_ARG_SEQ                          NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_TYPE                                    VARCHAR2,
	AR_FILTER_ARG_NAME                         VARCHAR2,
	AR_DEFAULT_VALUE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_FILTER_ARGS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_FILTER_ARGS 테이블 Insert
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_LOV_FILTER_ARGS
	(
		LOV_NO,
		FILTER_SEQ,
		FILTER_ARG_SEQ,
		DIS_SEQ,
		TYPE,
		FILTER_ARG_NAME,
		DEFAULT_VALUE
	)
	Values
	(
		AR_LOV_NO,
		AR_FILTER_SEQ,
		AR_FILTER_ARG_SEQ,
		AR_DIS_SEQ,
		AR_TYPE,
		AR_FILTER_ARG_NAME,
		AR_DEFAULT_VALUE
	);
End;
/
Create Or Replace Procedure SP_T_LOV_FILTER_ARGS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER,
	AR_FILTER_ARG_SEQ                          NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_TYPE                                    VARCHAR2,
	AR_FILTER_ARG_NAME                         VARCHAR2,
	AR_DEFAULT_VALUE                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_FILTER_ARGS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_FILTER_ARGS 테이블 Update
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_LOV_FILTER_ARGS
	Set
		DIS_SEQ = AR_DIS_SEQ,
		TYPE = AR_TYPE,
		FILTER_ARG_NAME = AR_FILTER_ARG_NAME,
		DEFAULT_VALUE = AR_DEFAULT_VALUE
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_SEQ = AR_FILTER_SEQ
	And	FILTER_ARG_SEQ = AR_FILTER_ARG_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_FILTER_ARGS_D
(
	AR_LOV_NO                                  NUMBER,
	AR_FILTER_SEQ                              NUMBER,
	AR_FILTER_ARG_SEQ                          NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_FILTER_ARGS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_FILTER_ARGS 테이블 Delete
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-23)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_LOV_FILTER_ARGS
	Where	LOV_NO = AR_LOV_NO
	And	FILTER_SEQ = AR_FILTER_SEQ
	And	FILTER_ARG_SEQ = AR_FILTER_ARG_SEQ;
End;
/
