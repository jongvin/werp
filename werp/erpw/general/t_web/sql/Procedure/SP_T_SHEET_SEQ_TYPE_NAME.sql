Create Or Replace Procedure SP_T_SHEET_SEQ_TYPE_NAME_I
(
	AR_SEQ_TYPE                                VARCHAR2,
	AR_SEQ_SEQ                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SEQ_TYPE_NAME                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_SEQ_TYPE_NAME_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_SEQ_TYPE_NAME 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_SHEET_SEQ_TYPE_NAME
	(
		SEQ_TYPE,
		SEQ_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SEQ_TYPE_NAME
	)
	Values
	(
		AR_SEQ_TYPE,
		AR_SEQ_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_SEQ_TYPE_NAME
	);
End;
/
Create Or Replace Procedure SP_T_SHEET_SEQ_TYPE_NAME_U
(
	AR_SEQ_TYPE                                VARCHAR2,
	AR_SEQ_SEQ                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_SEQ_TYPE_NAME                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_SEQ_TYPE_NAME_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_SEQ_TYPE_NAME 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_SHEET_SEQ_TYPE_NAME
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SEQ_TYPE_NAME = AR_SEQ_TYPE_NAME
	Where	SEQ_TYPE = AR_SEQ_TYPE
	And	SEQ_SEQ = AR_SEQ_SEQ;
End;
/
Create Or Replace Procedure SP_T_SHEET_SEQ_TYPE_NAME_D
(
	AR_SEQ_TYPE                                VARCHAR2,
	AR_SEQ_SEQ                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_SHEET_SEQ_TYPE_NAME_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_SHEET_SEQ_TYPE_NAME 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_SHEET_SEQ_TYPE_NAME
	Where	SEQ_TYPE = AR_SEQ_TYPE
	And	SEQ_SEQ = AR_SEQ_SEQ;
End;
/
