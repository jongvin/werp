Create Or Replace Procedure SP_T_FIN_SUD_ACC_CODE_I
(
	AR_SUDANGCD                                VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_ACC_CODE2                               VARCHAR2,
	AR_INCLUDE_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SUD_ACC_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SUD_ACC_CODE 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SUD_ACC_CODE
	(
		SUDANGCD,
		ACC_CODE,
		ACC_CODE2,
		INCLUDE_TAG
	)
	Values
	(
		AR_SUDANGCD,
		AR_ACC_CODE,
		AR_ACC_CODE2,
		AR_INCLUDE_TAG
	);
End;
/
Create Or Replace Procedure SP_T_FIN_SUD_ACC_CODE_U
(
	AR_SUDANGCD                                VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_ACC_CODE2                               VARCHAR2,
	AR_INCLUDE_TAG                             VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SUD_ACC_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SUD_ACC_CODE 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIN_SUD_ACC_CODE
	(
		SUDANGCD,
		ACC_CODE,
		ACC_CODE2,
		INCLUDE_TAG
	)
	Values
	(
		AR_SUDANGCD,
		AR_ACC_CODE,
		AR_ACC_CODE2,
		AR_INCLUDE_TAG
	);
Exception When Dup_Val_on_Index Then
	Update T_FIN_SUD_ACC_CODE
	Set
		ACC_CODE = AR_ACC_CODE,
		ACC_CODE2 = AR_ACC_CODE2,
		INCLUDE_TAG = AR_INCLUDE_TAG
	Where	SUDANGCD = AR_SUDANGCD;
End;
/
Create Or Replace Procedure SP_T_FIN_SUD_ACC_CODE_D
(
	AR_SUDANGCD                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_SUD_ACC_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIN_SUD_ACC_CODE 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIN_SUD_ACC_CODE
	Where	SUDANGCD = AR_SUDANGCD;
End;
/
