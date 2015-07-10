Create Or Replace Procedure SP_T_FIN_EMP_PAY_LIST_I
(
	AR_WORK_SEQ                                NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_EXEC_AMT                                NUMBER,
	AR_IN_ACC_NO                               VARCHAR2,
	AR_IN_BANK_MAIN_CODE                       VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_PAY_LIST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_PAY_LIST 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lsName						Z_AUTHORITY_USER.NAME%Type;
Begin
	Begin
		Select
			Name
		Into
			lsName
		From	Z_AUTHORITY_USER
		Where	EMPNO = AR_EMP_NO;
	Exception When No_Data_Found Then
		lsName := Null;
	End;
	Insert Into T_FIN_EMP_PAY_LIST
	(
		WORK_SEQ,
		COMP_CODE,
		WORK_DT,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		EMP_NO,
		EXEC_AMT,
		IN_ACC_NO,
		IN_BANK_MAIN_CODE,
		ACCNO_OWNER,
		SLIP_ID,
		SLIP_IDSEQ
	)
	Values
	(
		AR_WORK_SEQ,
		AR_COMP_CODE,
		F_T_StringToDate(AR_WORK_DT),
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_EMP_NO,
		AR_EXEC_AMT,
		AR_IN_ACC_NO,
		AR_IN_BANK_MAIN_CODE,
		Nvl(AR_ACCNO_OWNER,lsName) ,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ
	);
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_PAY_LIST_U
(
	AR_WORK_SEQ                                NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_EMP_NO                                  VARCHAR2,
	AR_EXEC_AMT                                NUMBER,
	AR_IN_ACC_NO                               VARCHAR2,
	AR_IN_BANK_MAIN_CODE                       VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_PAY_LIST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_PAY_LIST 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_EMP_PAY_LIST
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		EMP_NO = AR_EMP_NO,
		EXEC_AMT = AR_EXEC_AMT,
		IN_ACC_NO = AR_IN_ACC_NO,
		IN_BANK_MAIN_CODE = AR_IN_BANK_MAIN_CODE,
		ACCNO_OWNER = AR_ACCNO_OWNER,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ
	Where	WORK_SEQ = AR_WORK_SEQ
	And	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_PAY_LIST_D
(
	AR_WORK_SEQ                                NUMBER,
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_DT                                 VARCHAR2,
	AR_SEQ                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_PAY_LIST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_PAY_LIST 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_EMP_PAY_LIST
	Where	WORK_SEQ = AR_WORK_SEQ
	And	COMP_CODE = AR_COMP_CODE
	And	WORK_DT = F_T_StringToDate(AR_WORK_DT)
	And	SEQ = AR_SEQ;
End;
/
