Create Or Replace Procedure SP_T_FIN_EMP_IN_ACC_NO_I
(
	AR_ERMP_NO                                 VARCHAR2,
	AR_IN_BANK_MAIN_CODE_1                     VARCHAR2,
	AR_IN_ACC_NO_1                             VARCHAR2,
	AR_IN_BANK_MAIN_CODE_2                     VARCHAR2,
	AR_IN_ACC_NO_2                             VARCHAR2,
	AR_IN_BANK_MAIN_CODE_3                     VARCHAR2,
	AR_IN_ACC_NO_3                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_IN_ACC_NO_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_IN_ACC_NO 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-30)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_EMP_IN_ACC_NO
	(
		ERMP_NO,
		IN_BANK_MAIN_CODE_1,
		IN_ACC_NO_1,
		IN_BANK_MAIN_CODE_2,
		IN_ACC_NO_2,
		IN_BANK_MAIN_CODE_3,
		IN_ACC_NO_3
	)
	Values
	(
		AR_ERMP_NO,
		AR_IN_BANK_MAIN_CODE_1,
		AR_IN_ACC_NO_1,
		AR_IN_BANK_MAIN_CODE_2,
		AR_IN_ACC_NO_2,
		AR_IN_BANK_MAIN_CODE_3,
		AR_IN_ACC_NO_3
	);
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_IN_ACC_NO_U
(
	AR_ERMP_NO                                 VARCHAR2,
	AR_IN_BANK_MAIN_CODE_1                     VARCHAR2,
	AR_IN_ACC_NO_1                             VARCHAR2,
	AR_IN_BANK_MAIN_CODE_2                     VARCHAR2,
	AR_IN_ACC_NO_2                             VARCHAR2,
	AR_IN_BANK_MAIN_CODE_3                     VARCHAR2,
	AR_IN_ACC_NO_3                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_IN_ACC_NO_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_IN_ACC_NO 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-30)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_EMP_IN_ACC_NO
	(
		ERMP_NO,
		IN_BANK_MAIN_CODE_1,
		IN_ACC_NO_1,
		IN_BANK_MAIN_CODE_2,
		IN_ACC_NO_2,
		IN_BANK_MAIN_CODE_3,
		IN_ACC_NO_3
	)
	Values
	(
		AR_ERMP_NO,
		AR_IN_BANK_MAIN_CODE_1,
		AR_IN_ACC_NO_1,
		AR_IN_BANK_MAIN_CODE_2,
		AR_IN_ACC_NO_2,
		AR_IN_BANK_MAIN_CODE_3,
		AR_IN_ACC_NO_3
	);
Exception When Dup_val_On_index Then
	Update T_FIN_EMP_IN_ACC_NO
	Set
		IN_BANK_MAIN_CODE_1 = AR_IN_BANK_MAIN_CODE_1,
		IN_ACC_NO_1 = AR_IN_ACC_NO_1,
		IN_BANK_MAIN_CODE_2 = AR_IN_BANK_MAIN_CODE_2,
		IN_ACC_NO_2 = AR_IN_ACC_NO_2,
		IN_BANK_MAIN_CODE_3 = AR_IN_BANK_MAIN_CODE_3,
		IN_ACC_NO_3 = AR_IN_ACC_NO_3
	Where	ERMP_NO = AR_ERMP_NO;
End;
/
Create Or Replace Procedure SP_T_FIN_EMP_IN_ACC_NO_D
(
	AR_ERMP_NO                                 VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_EMP_IN_ACC_NO_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_EMP_IN_ACC_NO 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-30)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_EMP_IN_ACC_NO
	Where	ERMP_NO = AR_ERMP_NO;
End;
/
