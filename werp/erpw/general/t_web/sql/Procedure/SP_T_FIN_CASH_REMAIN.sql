Create Or Replace Procedure SP_T_FIN_CASH_REMAIN_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CASH_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_UNIT_COST                               NUMBER,
	AR_QTY                                     NUMBER,
	AR_AMT                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_CASH_REMAIN_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_CASH_REMAIN 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-08)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_CASH_REMAIN
	(
		COMP_CODE,
		WORK_DT,
		CASH_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		UNIT_COST,
		QTY,
		AMT
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CASH_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_UNIT_COST,
		AR_QTY,
		AR_AMT
	);
End;
/
Create Or Replace Procedure SP_T_FIN_CASH_REMAIN_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CASH_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_UNIT_COST                               NUMBER,
	AR_QTY                                     NUMBER,
	AR_AMT                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_CASH_REMAIN_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_CASH_REMAIN 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-08)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_CASH_REMAIN
	(
		COMP_CODE,
		WORK_DT,
		CASH_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		UNIT_COST,
		QTY,
		AMT
	)
	Values
	(
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_CASH_CODE,
		AR_MODUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_UNIT_COST,
		AR_QTY,
		AR_AMT
	);
Exception When Dup_Val_On_Index Then
	Update T_FIN_CASH_REMAIN
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		UNIT_COST = AR_UNIT_COST,
		QTY = AR_QTY,
		AMT = AR_AMT
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	CASH_CODE = AR_CASH_CODE;
End;
/
Create Or Replace Procedure SP_T_FIN_CASH_REMAIN_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_CASH_CODE                               VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_CASH_REMAIN_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_CASH_REMAIN 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-08)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_CASH_REMAIN
	Where	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	CASH_CODE = AR_CASH_CODE;
End;
/
