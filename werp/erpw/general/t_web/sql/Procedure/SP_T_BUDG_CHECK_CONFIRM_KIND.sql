CREATE OR REPLACE Procedure SP_T_BUDG_CHECK_CONFIRM_KIND
(
	AR_COMP_CODE                            VARCHAR2,
	AR_CLSE_ACC_ID                          VARCHAR2,
	AR_DEPT_CODE                            VARCHAR2,
	AR_CHG_SEQ                              NUMBER,
	AR_BUDG_CODE_NO							NUMBER,
	AR_RESERVED_SEQ							NUMBER,
	AR_BUDG_YM								VARCHAR2
)
Is
	ls_CONFIRM_KIND					T_BUDG_MONTH_REQ.CONFIRM_KIND%Type;
Begin
	Select	CONFIRM_KIND
	Into	ls_CONFIRM_KIND
	From	T_BUDG_MONTH_REQ a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ
	And		BUDG_CODE_NO = AR_BUDG_CODE_NO
	And		RESERVED_SEQ = AR_RESERVED_SEQ
	And		BUDG_YM = to_date(AR_BUDG_YM,'YYYY-MM');
	--If ls_CONFIRM_KIND = '1' or ls_CONFIRM_KIND = '2' or ls_CONFIRM_KIND = '3' Then
	--	Raise_Application_Error(-20009,'예산 신청은 승인처리되어 수정이 불가능합니다.');
	--End If;
End;
/
