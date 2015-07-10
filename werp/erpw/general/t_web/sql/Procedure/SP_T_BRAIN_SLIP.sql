Create Or Replace Procedure SP_T_BRAIN_SLIP_I
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BRAIN_SLIP_NAME1                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BRAIN_SLIP_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BRAIN_SLIP 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_BRAIN_SLIP
	(
		BRAIN_SLIP_SEQ1,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BRAIN_SLIP_NAME1
	)
	Values
	(
		AR_BRAIN_SLIP_SEQ1,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BRAIN_SLIP_NAME1
	);
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_U
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BRAIN_SLIP_NAME1                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BRAIN_SLIP_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BRAIN_SLIP 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_BRAIN_SLIP
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BRAIN_SLIP_NAME1 = AR_BRAIN_SLIP_NAME1
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1;
End;
/
Create Or Replace Procedure SP_T_BRAIN_SLIP_D
(
	AR_BRAIN_SLIP_SEQ1                         NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_BRAIN_SLIP_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_BRAIN_SLIP 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_BRAIN_SLIP
	Where	BRAIN_SLIP_SEQ1 = AR_BRAIN_SLIP_SEQ1;
End;
/
