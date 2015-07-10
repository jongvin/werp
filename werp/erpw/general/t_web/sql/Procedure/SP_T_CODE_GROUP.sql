Create Or Replace Procedure SP_T_CODE_GROUP_I
(
	AR_CODE_GROUP_NO                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CODE_GROUP_ID                           VARCHAR2,
	AR_CODE_GROUP_NAME                         VARCHAR2,
	AR_FLEX_FIELD                              VARCHAR2,
	AR_OPEN_TAG                                VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CODE_GROUP_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CODE_GROUP 테이블 Insert
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_CODE_GROUP
	(
		CODE_GROUP_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CODE_GROUP_ID,
		CODE_GROUP_NAME,
		FLEX_FIELD,
		OPEN_TAG,
		REMARK
	)
	Values
	(
		AR_CODE_GROUP_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CODE_GROUP_ID,
		AR_CODE_GROUP_NAME,
		AR_FLEX_FIELD,
		AR_OPEN_TAG,
		AR_REMARK
	);
End;
/
Create Or Replace Procedure SP_T_CODE_GROUP_U
(
	AR_CODE_GROUP_NO                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CODE_GROUP_ID                           VARCHAR2,
	AR_CODE_GROUP_NAME                         VARCHAR2,
	AR_FLEX_FIELD                              VARCHAR2,
	AR_OPEN_TAG                                VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CODE_GROUP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CODE_GROUP 테이블 Update
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_CODE_GROUP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CODE_GROUP_ID = AR_CODE_GROUP_ID,
		CODE_GROUP_NAME = AR_CODE_GROUP_NAME,
		FLEX_FIELD = AR_FLEX_FIELD,
		OPEN_TAG = AR_OPEN_TAG,
		REMARK = AR_REMARK
	Where	CODE_GROUP_NO = AR_CODE_GROUP_NO;
End;
/
Create Or Replace Procedure SP_T_CODE_GROUP_D
(
	AR_CODE_GROUP_NO                           NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CODE_GROUP_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CODE_GROUP 테이블 Delete
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_CODE_GROUP
	Where	CODE_GROUP_NO = AR_CODE_GROUP_NO;
End;
/
