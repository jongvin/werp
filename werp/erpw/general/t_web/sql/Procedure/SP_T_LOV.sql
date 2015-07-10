Create Or Replace Procedure SP_T_LOV_I
(
	AR_LOV_NO                                  NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TITLE                                   VARCHAR2,
	AR_WIDTH                                   NUMBER,
	AR_HEIGHT                                  NUMBER,
	AR_LOCATION_X                              NUMBER,
	AR_LOCATION_Y                              NUMBER,
	AR_SQL                                     VARCHAR2,
	AR_AUTO_LOAD                               VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV 테이블 Insert
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lnCount			Number;
Begin
	Select	Count(*)
	Into	lnCount
	From	T_LOV
	Where	NAME = AR_NAME
	And		RowNum < 2;
	
	If lnCount > 0 Then
		Raise_Application_Error	(-20009, '동일 이름의 LOV가 존재합니다.');
	End If;
	
	Insert Into T_LOV
	(
		LOV_NO,
		NAME,
		TITLE,
		WIDTH,
		HEIGHT,
		LOCATION_X,
		LOCATION_Y,
		SQL,
		AUTO_LOAD,
		REMARK
	)
	Values
	(
		AR_LOV_NO,
		AR_NAME,
		AR_TITLE,
		AR_WIDTH,
		AR_HEIGHT,
		AR_LOCATION_X,
		AR_LOCATION_Y,
		AR_SQL,
		AR_AUTO_LOAD,
		AR_REMARK
	);
End;
/
Create Or Replace Procedure SP_T_LOV_U
(
	AR_LOV_NO                                  NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TITLE                                   VARCHAR2,
	AR_WIDTH                                   NUMBER,
	AR_HEIGHT                                  NUMBER,
	AR_LOCATION_X                              NUMBER,
	AR_LOCATION_Y                              NUMBER,
	AR_SQL                                     VARCHAR2,
	AR_AUTO_LOAD                               VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV 테이블 Update
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_LOV
	Set
		NAME = AR_NAME,
		TITLE = AR_TITLE,
		WIDTH = AR_WIDTH,
		HEIGHT = AR_HEIGHT,
		LOCATION_X = AR_LOCATION_X,
		LOCATION_Y = AR_LOCATION_Y,
		SQL = AR_SQL,
		AUTO_LOAD = AR_AUTO_LOAD,
		REMARK = AR_REMARK
	Where	LOV_NO = AR_LOV_NO;
End;
/
Create Or Replace Procedure SP_T_LOV_D
(
	AR_LOV_NO                                  NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV 테이블 Delete
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lnCount			Number;
Begin
	Delete	T_LOV_FILTER_RELS
	Where	LOV_NO = AR_LOV_NO;

	Delete	T_LOV_FILTER_ARGS
	Where	LOV_NO = AR_LOV_NO;

	Delete	T_LOV_FILTERS
	Where	LOV_NO = AR_LOV_NO;

	Delete	T_LOV_ARGS
	Where	LOV_NO = AR_LOV_NO;
	
	Delete	T_LOV_COLS
	Where	LOV_NO = AR_LOV_NO;
	
	Delete	T_LOV
	Where	LOV_NO = AR_LOV_NO;
End;
/
