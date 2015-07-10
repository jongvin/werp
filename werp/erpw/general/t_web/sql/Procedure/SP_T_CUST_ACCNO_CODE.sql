Create Or Replace Procedure SP_T_CUST_ACCNO_CODE_I
(
	AR_CUST_SEQ                                NUMBER,
	AR_ACCNO                                   VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2,
	AR_ACCNO_CLS                               VARCHAR2,
	AR_USE_TG                                  VARCHAR2,
	AR_OUT_ACCNO                               VARCHAR2,
	AR_CLOSE_DT                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CUST_ACCNO_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CUST_ACCNO_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_ACCNO_CLS = '3' Then	--구매자금인 경우
		If AR_OUT_ACCNO Is Null Then
			Raise_Application_Error(-20009,'구매자금의 경우는 당사 인출계좌를 입력하여 주십시오.');
		End If;
	End If;
	Insert Into T_CUST_ACCNO_CODE
	(
		CUST_SEQ,
		ACCNO,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		BANK_MAIN_CODE,
		ACCNO_OWNER,
		ACCNO_CLS,
		USE_TG,
		OUT_ACCNO,
		CLOSE_DT
	)
	Values
	(
		AR_CUST_SEQ,
		AR_ACCNO,
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_BANK_MAIN_CODE,
		AR_ACCNO_OWNER,
		AR_ACCNO_CLS,
		AR_USE_TG,
		AR_OUT_ACCNO,
		F_T_StringToDate(AR_CLOSE_DT)
	);
End;
/
Create Or Replace Procedure SP_T_CUST_ACCNO_CODE_U
(
	AR_CUST_SEQ                                NUMBER,
	AR_ACCNO                                   VARCHAR2,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_BANK_MAIN_CODE                          VARCHAR2,
	AR_ACCNO_OWNER                             VARCHAR2,
	AR_ACCNO_CLS                               VARCHAR2,
	AR_USE_TG                                  VARCHAR2,
	AR_OUT_ACCNO                               VARCHAR2,
	AR_CLOSE_DT                                VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CUST_ACCNO_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CUST_ACCNO_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	If AR_ACCNO_CLS = '3' Then	--구매자금인 경우
		If AR_OUT_ACCNO Is Null Then
			Raise_Application_Error(-20009,'구매자금의 경우는 당사 인출계좌를 입력하여 주십시오.');
		End If;
	End If;
	Update T_CUST_ACCNO_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		BANK_MAIN_CODE = AR_BANK_MAIN_CODE,
		ACCNO_OWNER = AR_ACCNO_OWNER,
		ACCNO_CLS = AR_ACCNO_CLS,
		USE_TG = AR_USE_TG,
		OUT_ACCNO = AR_OUT_ACCNO,
		CLOSE_DT = F_T_StringToDate(AR_CLOSE_DT)
	Where	CUST_SEQ = AR_CUST_SEQ
	And	ACCNO = AR_ACCNO
	And	SEQ = AR_SEQ;
End;
/
Create Or Replace Procedure SP_T_CUST_ACCNO_CODE_D
(
	AR_CUST_SEQ                                NUMBER,
	AR_ACCNO                                   VARCHAR2,
	AR_SEQ                                     NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CUST_ACCNO_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CUST_ACCNO_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-03-02)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_CUST_ACCNO_CODE
	Where	CUST_SEQ = AR_CUST_SEQ
	And	ACCNO = AR_ACCNO
	And	SEQ = AR_SEQ;
End;
/
