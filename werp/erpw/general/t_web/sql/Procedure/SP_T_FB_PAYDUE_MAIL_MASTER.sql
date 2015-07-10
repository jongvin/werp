Create Or Replace Procedure SP_T_FB_PAYDUE_MAIL_MASTER_I
(
	AR_MAIL_SEQ                                NUMBER,
	AR_PAY_DUE_YMD                             VARCHAR2,
	AR_VAT_REGISTRATION_NUM                    VARCHAR2,
	AR_VENDOR_NAME                             VARCHAR2,
	AR_MAIL_SEND_DATE                          VARCHAR2,
	AR_MAIL_SEND_YN                            VARCHAR2,
	AR_MAIL_SEND_RESULT_MSG                    VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_TR_MANAGER_NAME                         VARCHAR2,
	AR_TR_MANAGER_EMAIL                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FB_PAYDUE_MAIL_MASTER_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_PAYDUE_MAIL_MASTER 테이블 Insert
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Insert Into T_FB_PAYDUE_MAIL_MASTER
	(
		MAIL_SEQ,
		PAY_DUE_YMD,
		VAT_REGISTRATION_NUM,
		VENDOR_NAME,
		MAIL_SEND_DATE,
		MAIL_SEND_YN,
		MAIL_SEND_RESULT_MSG,
		COMP_CODE,
		CREATION_DATE,
		CREATION_EMP_NO,
		LAST_MODIFY_DATE,
		LAST_MODIFY_EMP_NO,
		ATTRIBUTE1,
		ATTRIBUTE2,
		ATTRIBUTE3,
		TR_MANAGER_NAME,
		TR_MANAGER_EMAIL
	)
	Values
	(
		AR_MAIL_SEQ,
		AR_PAY_DUE_YMD,
		AR_VAT_REGISTRATION_NUM,
		AR_VENDOR_NAME,
		F_T_StringToDate(AR_MAIL_SEND_DATE),
		AR_MAIL_SEND_YN,
		AR_MAIL_SEND_RESULT_MSG,
		AR_COMP_CODE,
		F_T_StringToDate(AR_CREATION_DATE),
		AR_CREATION_EMP_NO,
		F_T_StringToDate(AR_LAST_MODIFY_DATE),
		AR_LAST_MODIFY_EMP_NO,
		AR_ATTRIBUTE1,
		AR_ATTRIBUTE2,
		AR_ATTRIBUTE3,
		AR_TR_MANAGER_NAME,
		AR_TR_MANAGER_EMAIL
	);
End;
/
Create Or Replace Procedure SP_T_FB_PAYDUE_MAIL_MASTER_U
(
	AR_MAIL_SEQ                                NUMBER,
	AR_PAY_DUE_YMD                             VARCHAR2,
	AR_VAT_REGISTRATION_NUM                    VARCHAR2,
	AR_VENDOR_NAME                             VARCHAR2,
	AR_MAIL_SEND_DATE                          VARCHAR2,
	AR_MAIL_SEND_YN                            VARCHAR2,
	AR_MAIL_SEND_RESULT_MSG                    VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CREATION_DATE                           VARCHAR2,
	AR_CREATION_EMP_NO                         VARCHAR2,
	AR_LAST_MODIFY_DATE                        VARCHAR2,
	AR_LAST_MODIFY_EMP_NO                      VARCHAR2,
	AR_ATTRIBUTE1                              VARCHAR2,
	AR_ATTRIBUTE2                              VARCHAR2,
	AR_ATTRIBUTE3                              VARCHAR2,
	AR_TR_MANAGER_NAME                         VARCHAR2,
	AR_TR_MANAGER_EMAIL                        VARCHAR2
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FB_PAYDUE_MAIL_MASTER_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_PAYDUE_MAIL_MASTER 테이블 Update
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Update T_FB_PAYDUE_MAIL_MASTER
	Set
		PAY_DUE_YMD = AR_PAY_DUE_YMD,
		VAT_REGISTRATION_NUM = AR_VAT_REGISTRATION_NUM,
		VENDOR_NAME = AR_VENDOR_NAME,
		MAIL_SEND_DATE = F_T_StringToDate(AR_MAIL_SEND_DATE),
		MAIL_SEND_YN = AR_MAIL_SEND_YN,
		MAIL_SEND_RESULT_MSG = AR_MAIL_SEND_RESULT_MSG,
		COMP_CODE = AR_COMP_CODE,
		CREATION_DATE = F_T_StringToDate(AR_CREATION_DATE),
		CREATION_EMP_NO = AR_CREATION_EMP_NO,
		LAST_MODIFY_DATE = F_T_StringToDate(AR_LAST_MODIFY_DATE),
		LAST_MODIFY_EMP_NO = AR_LAST_MODIFY_EMP_NO,
		ATTRIBUTE1 = AR_ATTRIBUTE1,
		ATTRIBUTE2 = AR_ATTRIBUTE2,
		ATTRIBUTE3 = AR_ATTRIBUTE3,
		TR_MANAGER_NAME = AR_TR_MANAGER_NAME,
		TR_MANAGER_EMAIL = AR_TR_MANAGER_EMAIL
	Where	MAIL_SEQ = AR_MAIL_SEQ;
End;
/
Create Or Replace Procedure SP_T_FB_PAYDUE_MAIL_MASTER_D
(
	AR_MAIL_SEQ                                NUMBER
)
Is
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FB_PAYDUE_MAIL_MASTER_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_FB_PAYDUE_MAIL_MASTER 테이블 Delete
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
Begin
	Delete T_FB_PAYDUE_MAIL_DETAIL
	Where	MAIL_SEQ = AR_MAIL_SEQ;

	Delete T_FB_PAYDUE_MAIL_MASTER
	Where	MAIL_SEQ = AR_MAIL_SEQ;
End;
/
