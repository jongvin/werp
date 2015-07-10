Create Or Replace Procedure SP_T_EMPNO_AUTH_I
(
	AR_EMPNO                                   VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_SLIP_TRANS_CLS                          VARCHAR2 Default 'F',
	AR_DEPT_CHG_CLS                            VARCHAR2 Default 'F',
	AR_ALL_DEPT_CLS                            VARCHAR2 Default 'F'
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMPNO_AUTH_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMPNO_AUTH 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_EMPNO_AUTH
	(
		EMPNO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		SLIP_TRANS_CLS,
		DEPT_CHG_CLS,
		ALL_DEPT_CLS
	)
	Values
	(
		AR_EMPNO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		SubStrb(AR_SLIP_TRANS_CLS,1,1),
		SubStrb(AR_DEPT_CHG_CLS,1,1),
		SubStrb(AR_ALL_DEPT_CLS,1,1)
	);
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_U
(
	AR_EMPNO                                   VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_SLIP_TRANS_CLS                          VARCHAR2 Default 'F',
	AR_DEPT_CHG_CLS                            VARCHAR2 Default 'F',
	AR_ALL_DEPT_CLS                            VARCHAR2 Default 'F'
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMPNO_AUTH_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMPNO_AUTH 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_EMPNO_AUTH
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		SLIP_TRANS_CLS = SubStrb(AR_SLIP_TRANS_CLS,1,1),
		DEPT_CHG_CLS = SubStrb(AR_DEPT_CHG_CLS,1,1),
		ALL_DEPT_CLS = SubStrb(AR_ALL_DEPT_CLS,1,1)
	Where	EMPNO = AR_EMPNO;
End;
/
Create Or Replace Procedure SP_T_EMPNO_AUTH_D
(
	AR_EMPNO                                   VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_EMPNO_AUTH_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_EMPNO_AUTH 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_EMPNO_AUTH
	Where	EMPNO = AR_EMPNO;
End;
/
