Create Or Replace Procedure SP_T_SHEET_SUM_HEAD_ALL_D
(
	AR_SHEET_CODE                              VARCHAR2,
	AR_COMPANY_CODE                            VARCHAR2
)
Is
/***************************************************/
/* �� ���α׷��� �뺸�ý���(��) �� ����Դϴ�.
/* �����ۼ��� : �����
/* �����ۼ��� : 2004-12-05
/* ���������� :
/* ���������� :
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
