CREATE OR REPLACE Procedure SP_T_PREV_CHG_BUDG_CHECK
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER
)
Is
	ln_Count					NUMBER;
Begin
	Select	COUNT(*)
	Into	ln_Count
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ > AR_CHG_SEQ;
	If ln_Count > 0 Then
		Raise_Application_Error(-20009,'최종변경차수만 확정하거나 취소할 수 있습니다.');
	End If;
End;