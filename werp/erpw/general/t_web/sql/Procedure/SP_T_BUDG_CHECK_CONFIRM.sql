/*
배정확정여부 검증
*/
Create Or Replace Procedure SP_T_BUDG_CHECK_CONFIRM
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
	ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
Begin
	Select	CONFIRM_TAG
	Into	ls_CONFIRM_TAG
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	If ls_CONFIRM_TAG = 'T' Then
		Raise_Application_Error(-20009,'해당 예산은 이미 확정되어 수정이 불가능 합니다.');
	End If;
End;
/
