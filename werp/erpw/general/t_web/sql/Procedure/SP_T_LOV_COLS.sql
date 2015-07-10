Create Or Replace Procedure SP_T_LOV_COLS_I
(
	AR_LOV_NO                                  NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TITLE                                   VARCHAR2,
	AR_WIDTH                                   NUMBER,
	AR_ALIGN                                   VARCHAR2,
	AR_MASK                                    VARCHAR2,
	AR_VISIBLE                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_COLS_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_COLS 테이블 Insert
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_LOV_COLS
	(
		LOV_NO,
		COL_SEQ,
		DIS_SEQ,
		NAME,
		TITLE,
		WIDTH,
		ALIGN,
		MASK,
		VISIBLE
	)
	Values
	(
		AR_LOV_NO,
		SQ_T_LOV_COLS.nextval,
		AR_DIS_SEQ,
		AR_NAME,
		AR_TITLE,
		AR_WIDTH,
		AR_ALIGN,
		AR_MASK,
		AR_VISIBLE
	);
End;
/
Create Or Replace Procedure SP_T_LOV_COLS_U
(
	AR_LOV_NO                                  NUMBER,
	AR_COL_SEQ                                 NUMBER,
	AR_DIS_SEQ                                 NUMBER,
	AR_NAME                                    VARCHAR2,
	AR_TITLE                                   VARCHAR2,
	AR_WIDTH                                   NUMBER,
	AR_ALIGN                                   VARCHAR2,
	AR_MASK                                    VARCHAR2,
	AR_VISIBLE                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_COLS_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_COLS 테이블 Update
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update	T_LOV_COLS
	Set		TITLE = AR_TITLE,
			WIDTH = AR_WIDTH,
			ALIGN = AR_ALIGN,
			MASK = AR_MASK,
			VISIBLE = AR_VISIBLE
	Where	LOV_NO = AR_LOV_NO
	 And	COL_SEQ = AR_COL_SEQ;
End;
/
Create Or Replace Procedure SP_T_LOV_COLS_D
(
	AR_LOV_NO                                  NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_LOV_COLS_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_LOV_COLS 테이블 Delete
/* 4. 변  경  이  력 : 강덕율 작성(2005-11-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete	T_LOV_COLS
	Where	LOV_NO = AR_LOV_NO;
End;
/
