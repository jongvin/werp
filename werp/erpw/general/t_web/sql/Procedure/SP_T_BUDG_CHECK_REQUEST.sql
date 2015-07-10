CREATE OR REPLACE Procedure SP_T_BUDG_CHECK_REQUEST
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                  NUMBER,
	AR_TAG						   VARCHAR2
)
Is
	ls_REQUEST_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
Begin
	If AR_TAG = 'T' Then
		Select	REQUEST_TAG
		Into	ls_REQUEST_TAG
		From	T_BUDG_DEPT_H a
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		CHG_SEQ = AR_CHG_SEQ;
		If ls_REQUEST_TAG = 'T' Then
			Raise_Application_Error(-20009,'해당 예산은 이미 신청완료되어 수정이 불가능 합니다.');
		End If;
	End If;
End;