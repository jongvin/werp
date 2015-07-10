Create Or Replace Procedure SP_T_LOV_ARGS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_ARG_SEQ                                 NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TYPE                                    VARCHAR2,
	AR_DEFAULT_VALUE                           VARCHAR2,
	AR_SESSION_TAG                             VARCHAR2,
	AR_SESSION_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_ARGS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_ARGS 테이블 Insert
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_LOV_ARGS
	(
		LOV_NO,
		ARG_SEQ,
		DIS_SEQ,
		NAME,
		TYPE,
		DEFAULT_VALUE,
		SESSION_TAG,
		SESSION_NAME
	)
	Values
	(
		AR_LOV_NO,
		AR_ARG_SEQ,
		AR_DIS_SEQ,
		AR_NAME,
		AR_TYPE,
		AR_DEFAULT_VALUE,
		AR_SESSION_TAG,
		AR_SESSION_NAME
	);
End;
/
Create Or Replace Procedure SP_T_LOV_ARGS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_ARG_SEQ                                 NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TYPE                                    VARCHAR2,
	AR_DEFAULT_VALUE                           VARCHAR2,
	AR_SESSION_TAG                             VARCHAR2,
	AR_SESSION_NAME                            VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_ARGS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_ARGS 테이블 Update
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update	T_LOV_ARGS
	Set		DIS_SEQ = AR_DIS_SEQ,
			NAME = AR_NAME,
			TYPE = AR_TYPE,
			DEFAULT_VALUE = AR_DEFAULT_VALUE,
			SESSION_TAG = AR_SESSION_TAG,
			SESSION_NAME = AR_SESSION_NAME
	Where	LOV_NO = AR_LOV_NO
	 And	ARG_SEQ = AR_ARG_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_ARGS_D
(
	AR_LOV_NO                                  NUMBER,
	AR_ARG_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_ARGS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_ARGS 테이블 Delete
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete	T_LOV_ARGS
	Where	LOV_NO = AR_LOV_NO
	 And	ARG_SEQ = AR_ARG_SEQ;
End;
/
