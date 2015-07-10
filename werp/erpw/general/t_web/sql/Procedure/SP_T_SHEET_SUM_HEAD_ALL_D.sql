Create Or Replace Procedure SP_T_SHEET_SUM_HEAD_ALL_D
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_COMPANY_CODE                            VARCHAR2
)
Is
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-12-05
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
Begin
	Delete T_SHEET_SUM_BODY
	Where	SHEET_CODE = AR_SHEET_CODE
	And	COMP_CODE = AR_COMPANY_CODE;
	Delete T_SHEET_SUM_HEAD
	Where	SHEET_CODE = AR_SHEET_CODE
	And		COMP_CODE = AR_COMPANY_CODE;
End;
/
