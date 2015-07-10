Create Or Replace Procedure SP_T_FIN_NP_ITR_TAR_SEC_I
(
	AR_WORK_NO                                 NUMBER,
	AR_SECU_NO                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ITR_CALC_NO                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_NP_ITR_TAR_SEC_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_NP_ITR_TAR_SEC 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_NP_ITR_TAR_SEC
	(
		WORK_NO,
		SECU_NO,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ITR_CALC_NO
	)
	Values
	(
		AR_WORK_NO,
		AR_SECU_NO,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ITR_CALC_NO
	);
End;
/
Create Or Replace Procedure SP_T_FIN_NP_ITR_TAR_SEC_U
(
	AR_WORK_NO                                 NUMBER,
	AR_SECU_NO                                 NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_ITR_CALC_NO                             NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_NP_ITR_TAR_SEC_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_NP_ITR_TAR_SEC 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIN_NP_ITR_TAR_SEC
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ITR_CALC_NO = AR_ITR_CALC_NO
	Where	WORK_NO = AR_WORK_NO
	And	SECU_NO = AR_SECU_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_NP_ITR_TAR_SEC_D
(
	AR_WORK_NO                                 NUMBER,
	AR_SECU_NO                                 NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_NP_ITR_TAR_SEC_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_NP_ITR_TAR_SEC 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-27)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	lrRec									T_FIN_NP_ITR_TAR_SEC%RowType;
Begin
	Select
		*
	Into
		lrRec
	From	T_FIN_NP_ITR_TAR_SEC
	Where	WORK_NO = AR_WORK_NO
	And		SECU_NO = AR_SECU_NO;

	Delete T_FIN_NP_ITR_TAR_SEC
	Where	WORK_NO = AR_WORK_NO
	And	SECU_NO = AR_SECU_NO;

	Delete	T_FIN_SEC_ITR_AMT
	Where	SECU_NO = lrRec.SECU_NO
	And		ITR_CALC_NO = lrRec.ITR_CALC_NO;
End;
/
