Create Or Replace Procedure SP_T_FB_LOOKUP_VALUES_I
(
	AR_LOOKUP_TYPE                             VARCHAR2,
	AR_LOOKUP_CODE                             VARCHAR2,
	AR_LOOKUP_VALUE                            VARCHAR2,
	AR_USE_YN                                  VARCHAR2,
	AR_DESCRIPTION                             VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_ATTRIBUTE4                              VARCHAR2,
	AR_ATTRIBUTE5                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FB_LOOKUP_VALUES_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_LOOKUP_VALUES 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FB_LOOKUP_VALUES
	(
		LOOKUP_TYPE,
		LOOKUP_CODE,
		LOOKUP_VALUE,
		USE_YN,
		DESCRIPTION,
		CREATION_DATE,
		CREATION_EMP_NO,
		LAST_MODIFY_DATE,
		LAST_MODIFY_EMP_NO,
		ATTRIBUTE1,
		ATTRIBUTE2,
		ATTRIBUTE3,
		ATTRIBUTE4,
		ATTRIBUTE5
	)
	Values
	(
		AR_LOOKUP_TYPE,
		AR_LOOKUP_CODE,
		AR_LOOKUP_VALUE,
		Decode(AR_USE_YN,'T','Y','F','N'),
		AR_DESCRIPTION,
		SysDate,
		AR_CREATION_EMP_NO,
		Null,
		Null,
		AR_ATTRIBUTE1,
		AR_ATTRIBUTE2,
		AR_ATTRIBUTE3,
		AR_ATTRIBUTE4,
		AR_ATTRIBUTE5
	);
End;
/
Create Or Replace Procedure SP_T_FB_LOOKUP_VALUES_U
(
	AR_LOOKUP_TYPE                             VARCHAR2,
	AR_LOOKUP_CODE                             VARCHAR2,
	AR_LOOKUP_VALUE                            VARCHAR2,
	AR_USE_YN                                  VARCHAR2,
	AR_DESCRIPTION                             VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_ATTRIBUTE4                              VARCHAR2,
	AR_ATTRIBUTE5                              VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FB_LOOKUP_VALUES_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_LOOKUP_VALUES 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FB_LOOKUP_VALUES
	Set
		LOOKUP_VALUE = AR_LOOKUP_VALUE,
		USE_YN = Decode(AR_USE_YN,'T','Y','F','N'),
		DESCRIPTION = AR_DESCRIPTION,
		LAST_MODIFY_DATE = SysDate,
		LAST_MODIFY_EMP_NO = AR_LAST_MODIFY_EMP_NO,
		ATTRIBUTE1 = AR_ATTRIBUTE1,
		ATTRIBUTE2 = AR_ATTRIBUTE2,
		ATTRIBUTE3 = AR_ATTRIBUTE3,
		ATTRIBUTE4 = AR_ATTRIBUTE4,
		ATTRIBUTE5 = AR_ATTRIBUTE5
	Where	LOOKUP_TYPE = AR_LOOKUP_TYPE
	And	LOOKUP_CODE = AR_LOOKUP_CODE;
End;
/
Create Or Replace Procedure SP_T_FB_LOOKUP_VALUES_D
(
	AR_LOOKUP_TYPE                             VARCHAR2,
	AR_LOOKUP_CODE                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FB_LOOKUP_VALUES_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_LOOKUP_VALUES 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-19)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FB_LOOKUP_VALUES
	Where	LOOKUP_TYPE = AR_LOOKUP_TYPE
	And	LOOKUP_CODE = AR_LOOKUP_CODE;
End;
/
