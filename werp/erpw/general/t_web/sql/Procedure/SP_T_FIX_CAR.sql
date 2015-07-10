Create Or Replace Procedure SP_T_FIX_CAR_I
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_CAR_NO                                  VARCHAR2,
	AR_CAR_BODY_NO                             VARCHAR2,
	AR_CAR_YEAR                                VARCHAR2,
	AR_CAR_LENGTH                              VARCHAR2,
	AR_CAR_WIDTH                               VARCHAR2,
	AR_CAR_HEIGHT                              VARCHAR2,
	AR_CAR_WEIGHT                              VARCHAR2,
	AR_CAR_CC                                  VARCHAR2,
	AR_CAR_CYLINDER                            VARCHAR2,
	AR_CAR_FORM_NO                             VARCHAR2,
	AR_CAR_OIL                                 VARCHAR2,
	AR_CAR_USE                                 VARCHAR2,
	AR_CAR_USER                                VARCHAR2,
	AR_REGULAR_CHECK_START                     VARCHAR2,
	AR_REGULAR_CHECK_END                       VARCHAR2,
	AR_GET_TAX                                 NUMBER,
	AR_REG_TAX                                 NUMBER,
	AR_VAT_TAX                                 NUMBER,
	AR_INSURANCE_START                         VARCHAR2,
	AR_INSURANCE_END                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_CAR_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_CAR 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FIX_CAR
	(
		FIX_ASSET_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CAR_NO,
		CAR_BODY_NO,
		CAR_YEAR,
		CAR_LENGTH,
		CAR_WIDTH,
		CAR_HEIGHT,
		CAR_WEIGHT,
		CAR_CC,
		CAR_CYLINDER,
		CAR_FORM_NO,
		CAR_OIL,
		CAR_USE,
		CAR_USER,
		REGULAR_CHECK_START,
		REGULAR_CHECK_END,
		GET_TAX,
		REG_TAX,
		VAT_TAX,
		INSURANCE_START,
		INSURANCE_END
	)
	Values
	(
		AR_FIX_ASSET_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_CAR_NO,
		AR_CAR_BODY_NO,
		AR_CAR_YEAR,
		AR_CAR_LENGTH,
		AR_CAR_WIDTH,
		AR_CAR_HEIGHT,
		AR_CAR_WEIGHT,
		AR_CAR_CC,
		AR_CAR_CYLINDER,
		AR_CAR_FORM_NO,
		AR_CAR_OIL,
		AR_CAR_USE,
		AR_CAR_USER,
		F_T_StringToDate(AR_REGULAR_CHECK_START),
		F_T_StringToDate(AR_REGULAR_CHECK_END),
		AR_GET_TAX,
		AR_REG_TAX,
		AR_VAT_TAX,
		F_T_StringToDate(AR_INSURANCE_START),
		F_T_StringToDate(AR_INSURANCE_END)
	);
End;
/
Create Or Replace Procedure SP_T_FIX_CAR_U
(
	AR_FIX_ASSET_SEQ                           NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_CAR_NO                                  VARCHAR2,
	AR_CAR_BODY_NO                             VARCHAR2,
	AR_CAR_YEAR                                VARCHAR2,
	AR_CAR_LENGTH                              VARCHAR2,
	AR_CAR_WIDTH                               VARCHAR2,
	AR_CAR_HEIGHT                              VARCHAR2,
	AR_CAR_WEIGHT                              VARCHAR2,
	AR_CAR_CC                                  VARCHAR2,
	AR_CAR_CYLINDER                            VARCHAR2,
	AR_CAR_FORM_NO                             VARCHAR2,
	AR_CAR_OIL                                 VARCHAR2,
	AR_CAR_USE                                 VARCHAR2,
	AR_CAR_USER                                VARCHAR2,
	AR_REGULAR_CHECK_START                     VARCHAR2,
	AR_REGULAR_CHECK_END                       VARCHAR2,
	AR_GET_TAX                                 NUMBER,
	AR_REG_TAX                                 NUMBER,
	AR_VAT_TAX                                 NUMBER,
	AR_INSURANCE_START                         VARCHAR2,
	AR_INSURANCE_END                           VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_CAR_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_CAR 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FIX_CAR
	Set
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		CAR_NO = AR_CAR_NO,
		CAR_BODY_NO = AR_CAR_BODY_NO,
		CAR_YEAR = AR_CAR_YEAR,
		CAR_LENGTH = AR_CAR_LENGTH,
		CAR_WIDTH = AR_CAR_WIDTH,
		CAR_HEIGHT = AR_CAR_HEIGHT,
		CAR_WEIGHT = AR_CAR_WEIGHT,
		CAR_CC = AR_CAR_CC,
		CAR_CYLINDER = AR_CAR_CYLINDER,
		CAR_FORM_NO = AR_CAR_FORM_NO,
		CAR_OIL = AR_CAR_OIL,
		CAR_USE = AR_CAR_USE,
		CAR_USER = AR_CAR_USER,
		REGULAR_CHECK_START = F_T_StringToDate(AR_REGULAR_CHECK_START),
		REGULAR_CHECK_END = F_T_StringToDate(AR_REGULAR_CHECK_END),
		GET_TAX = AR_GET_TAX,
		REG_TAX = AR_REG_TAX,
		VAT_TAX = AR_VAT_TAX,
		INSURANCE_START = F_T_StringToDate(AR_INSURANCE_START),
		INSURANCE_END = F_T_StringToDate(AR_INSURANCE_END)
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
Create Or Replace Procedure SP_T_FIX_CAR_D
(
	AR_FIX_ASSET_SEQ                           NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIX_CAR_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FIX_CAR 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2006-01-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FIX_CAR
	Where	FIX_ASSET_SEQ = AR_FIX_ASSET_SEQ;
End;
/
