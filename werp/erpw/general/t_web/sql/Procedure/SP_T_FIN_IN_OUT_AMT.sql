Create Or Replace Procedure SP_T_FIN_IN_OUT_AMT_I
(
	AR_IN_NO                                   NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_IN_DT                                   VARCHAR2,
	AR_NO                                      VARCHAR2,
	AR_IN_KIND_TG                              VARCHAR2,
	AR_IN_DESCRIPTION                          VARCHAR2,
	AR_OUT_KIND_TG                             VARCHAR2,
	AR_OUT_DT                                  VARCHAR2,
	AR_OUT_DESCRIPTION                         VARCHAR2,
	AR_GET_PERSON                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_IN_OUT_AMT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_IN_OUT_AMT 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_IN_OUT_AMT
	(
		IN_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		COMP_CODE,
		IN_DT,
		NO,
		IN_KIND_TG,
		IN_DESCRIPTION,
		OUT_KIND_TG,
		OUT_DT,
		OUT_DESCRIPTION,
		GET_PERSON
	)
	Values
	(
		AR_IN_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_COMP_CODE,
		F_T_StringToDate(AR_IN_DT),
		AR_NO,
		AR_IN_KIND_TG,
		AR_IN_DESCRIPTION,
		AR_OUT_KIND_TG,
		F_T_StringToDate(AR_OUT_DT),
		AR_OUT_DESCRIPTION,
		AR_GET_PERSON
	);
End;
/
Create Or Replace Procedure SP_T_FIN_IN_OUT_AMT_U
(
	AR_IN_NO                                   NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_IN_DT                                   VARCHAR2,
	AR_NO                                      VARCHAR2,
	AR_IN_KIND_TG                              VARCHAR2,
	AR_IN_DESCRIPTION                          VARCHAR2,
	AR_OUT_KIND_TG                             VARCHAR2,
	AR_OUT_DT                                  VARCHAR2,
	AR_OUT_DESCRIPTION                         VARCHAR2,
	AR_GET_PERSON                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_IN_OUT_AMT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_IN_OUT_AMT 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_IN_OUT_AMT
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		COMP_CODE = AR_COMP_CODE,
		IN_DT = F_T_StringToDate(AR_IN_DT),
		NO = AR_NO,
		IN_KIND_TG = AR_IN_KIND_TG,
		IN_DESCRIPTION = AR_IN_DESCRIPTION,
		OUT_KIND_TG = AR_OUT_KIND_TG,
		OUT_DT = F_T_StringToDate(AR_OUT_DT),
		OUT_DESCRIPTION = AR_OUT_DESCRIPTION,
		GET_PERSON = AR_GET_PERSON
	Where	IN_NO = AR_IN_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_IN_OUT_AMT_D
(
	AR_IN_NO                                   NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_IN_OUT_AMT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_IN_OUT_AMT 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_IN_OUT_AMT
	Where	IN_NO = AR_IN_NO;
End;
/
