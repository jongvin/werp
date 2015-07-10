Create Or Replace Procedure SP_T_USER_REPORT_REQUEST_I
(
	AR_REPORT_REQUEST_NO                       NUMBER,
	AR_USER_NO                                 VARCHAR2,
	AR_REPORT_NO                               NUMBER,
	AR_SYS_ID                                  NUMBER,
	AR_REQUEST_NAME                            VARCHAR2,
	AR_REQUEST_FILE_NAME                       VARCHAR2,
	AR_STATE                                   VARCHAR2
)
Is
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-01-10
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/
Begin
	Insert Into T_USER_REPORT_REQUEST
	(
		REPORT_REQUEST_NO,
		USER_NO,
		REPORT_NO,
		SYS_ID,
		REQUEST_NAME,
		REQUEST_DATE,
		REQUEST_FILE_NAME,
		DELETE_EXPECT_DATE,
		STATE
	)
	Values
	(
		AR_REPORT_REQUEST_NO,
		AR_USER_NO,
		AR_REPORT_NO,
		AR_SYS_ID,
		AR_REQUEST_NAME,
		sysdate,
		AR_REQUEST_FILE_NAME,
		sysdate+2,
		AR_STATE
	);
End;
/
Create Or Replace Procedure SP_T_USER_REPORT_REQUEST_U
(
	AR_REPORT_REQUEST_NO                       NUMBER,
	AR_USER_NO                                 VARCHAR2,
	AR_REPORT_NO                               NUMBER,
	AR_STATE                                   VARCHAR2,
	AR_REMARK                                  VARCHAR2
)
Is
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-01-10
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/
Begin
	Update T_USER_REPORT_REQUEST
	Set
		COMPLETE_DATE = sysdate,
		STATE = AR_STATE,
		REMARK = AR_REMARK
	Where	REPORT_REQUEST_NO = AR_REPORT_REQUEST_NO
	 And	USER_NO = AR_USER_NO
	 And	REPORT_NO = AR_REPORT_NO;
End;
/
Create Or Replace Procedure SP_T_USER_REPORT_REQUEST_D
(
	AR_REPORT_REQUEST_NO                       NUMBER,
	AR_USER_NO                                 VARCHAR2,
	AR_REPORT_NO                               NUMBER
)
Is
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-01-10
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/
Begin
	Delete T_USER_REPORT_REQUEST
	Where	REPORT_REQUEST_NO = AR_REPORT_REQUEST_NO
	 And	USER_NO = AR_USER_NO
	 And	REPORT_NO = AR_REPORT_NO;
End;
/
