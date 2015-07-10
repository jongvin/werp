Create Or Replace Procedure SP_T_CUST_CODE_I
(
	AR_CUST_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CUST_CODE                               VARCHAR2,
	AR_CUST_NAME                               VARCHAR2,
	AR_BOSS_NAME                               VARCHAR2,
	AR_TRADE_CLS                               VARCHAR2,
	AR_BIZCOND                                 VARCHAR2,
	AR_BIZKND                                  VARCHAR2,
	AR_ZIPCODE                                 VARCHAR2,
	AR_ADDR1                                   VARCHAR2,
	AR_ADDR2                                   VARCHAR2,
	AR_TELNO                                   VARCHAR2,
	AR_GROUP_COMP_CLS                          VARCHAR2,
	AR_USE_CLS                                 VARCHAR2,
	AR_REPRESENT_CUST_SEQ                      NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CUST_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CUST_CODE 테이블 Insert
/* 4. 변  경  이  력 : 최언회 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	--회계 최종 요청사항에 의한 변경.
	--사업자의 경우 화면에 필요한 모든 사항을 필수로 해달라!
	If Ar_TRADE_CLS = '1' Or LengthB(F_T_CUST_UMASK(AR_CUST_CODE)) = 10 Then
		If Ar_CUST_NAME Is Null Then
			Raise_Application_Error(-20009,'거래처명은 필수사항입니다.');
		End If;
		If Ar_BIZCOND Is Null Then
			Raise_Application_Error(-20009,'업태는 필수사항입니다.');
		End If;
		If Ar_BIZKND Is Null Then
			Raise_Application_Error(-20009,'업종은 필수사항입니다.');
		End If;
		If Ar_ZIPCODE Is Null Then
			Raise_Application_Error(-20009,'우편번호는 필수사항입니다.');
		End If;
		If Ar_ADDR1 Is Null Then
			Raise_Application_Error(-20009,'주소는 필수사항입니다.');
		End If;
		If Ar_TELNO Is Null Then
			Raise_Application_Error(-20009,'전화번호는 필수사항입니다.');
		End If;
	End If;
	Insert Into T_CUST_CODE
	(
		CUST_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CUST_CODE,
		CUST_NAME,
		BOSS_NAME,
		TRADE_CLS,
		BIZCOND,
		BIZKND,
		ZIPCODE,
		ADDR1,
		ADDR2,
		TELNO,
		GROUP_COMP_CLS,
		USE_CLS,
		REPRESENT_CUST_SEQ
	)
	Values
	(
		AR_CUST_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		F_T_CUST_UMASK(AR_CUST_CODE),
		AR_CUST_NAME,
		AR_BOSS_NAME,
		AR_TRADE_CLS,
		AR_BIZCOND,
		AR_BIZKND,
		REPLACE(AR_ZIPCODE, '-', NULL),
		AR_ADDR1,
		AR_ADDR2,
		AR_TELNO,
		AR_GROUP_COMP_CLS,
		AR_USE_CLS,
		AR_REPRESENT_CUST_SEQ
	);
End;
/
Create Or Replace Procedure SP_T_CUST_CODE_U
(
	AR_CUST_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CUST_CODE                               VARCHAR2,
	AR_CUST_NAME                               VARCHAR2,
	AR_BOSS_NAME                               VARCHAR2,
	AR_TRADE_CLS                               VARCHAR2,
	AR_BIZCOND                                 VARCHAR2,
	AR_BIZKND                                  VARCHAR2,
	AR_ZIPCODE                                 VARCHAR2,
	AR_ADDR1                                   VARCHAR2,
	AR_ADDR2                                   VARCHAR2,
	AR_TELNO                                   VARCHAR2,
	AR_GROUP_COMP_CLS                          VARCHAR2,
	AR_USE_CLS                                 VARCHAR2,
	AR_REPRESENT_CUST_SEQ                      NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CUST_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CUST_CODE 테이블 Update
/* 4. 변  경  이  력 : 최언회 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	--회계 최종 요청사항에 의한 변경.
	--사업자의 경우 화면에 필요한 모든 사항을 필수로 해달라!
	If Ar_TRADE_CLS = '1' Or LengthB(F_T_CUST_UMASK(AR_CUST_CODE)) = 10 Then
		If Ar_CUST_NAME Is Null Then
			Raise_Application_Error(-20009,'거래처명은 필수사항입니다.');
		End If;
		If Ar_BIZCOND Is Null Then
			Raise_Application_Error(-20009,'업태는 필수사항입니다.');
		End If;
		If Ar_BIZKND Is Null Then
			Raise_Application_Error(-20009,'업종은 필수사항입니다.');
		End If;
		If Ar_ZIPCODE Is Null Then
			Raise_Application_Error(-20009,'우편번호는 필수사항입니다.');
		End If;
		If Ar_ADDR1 Is Null Then
			Raise_Application_Error(-20009,'주소는 필수사항입니다.');
		End If;
		If Ar_TELNO Is Null Then
			Raise_Application_Error(-20009,'전화번호는 필수사항입니다.');
		End If;
	End If;
	Update T_CUST_CODE
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CUST_CODE = F_T_CUST_UMASK(AR_CUST_CODE),
		CUST_NAME = AR_CUST_NAME,
		BOSS_NAME = AR_BOSS_NAME,
		TRADE_CLS = AR_TRADE_CLS,
		BIZCOND = AR_BIZCOND,
		BIZKND = AR_BIZKND,
		ZIPCODE = REPLACE(AR_ZIPCODE, '-', NULL),
		ADDR1 = AR_ADDR1,
		ADDR2 = AR_ADDR2,
		TELNO = AR_TELNO,
		GROUP_COMP_CLS = AR_GROUP_COMP_CLS,
		USE_CLS = AR_USE_CLS,
		REPRESENT_CUST_SEQ = AR_REPRESENT_CUST_SEQ
	Where	CUST_SEQ = AR_CUST_SEQ;
End;
/
Create Or Replace Procedure SP_T_CUST_CODE_D
(
	AR_CUST_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_CUST_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_CUST_CODE 테이블 Delete
/* 4. 변  경  이  력 : 최언회 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_CUST_CODE
	Where	CUST_SEQ = AR_CUST_SEQ;
End;
/
