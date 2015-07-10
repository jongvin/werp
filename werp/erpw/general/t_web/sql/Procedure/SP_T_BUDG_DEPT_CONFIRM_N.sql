Create Or Replace Procedure SP_T_BUDG_DEPT_CONFIRM_N
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_DEPT_CODE					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_CRTUSERNO					Varchar2
)
Is
	ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
	ln_Count						Number;
Begin
	--만약 자기보다 더 높은 차수가 확정된 거가 있으면 확정 해제 불가.
	Select
		Count(*)
	Into
		ln_Count
	From	T_BUDG_DEPT_H
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ > AR_CHG_SEQ
	And		CONFIRM_TAG = 'T';
	If ln_Count > 0 Then
		Raise_Application_Error(-20009,'현재 확정 취소하려는 예산 보다 더 나중에 편성되어 확정된 예산 변경차수가 있으므로 확정 해제가 안됩니다.');
	End If;
	
	Update	T_BUDG_DEPT_H
	Set		CONFIRM_TAG = 'F',
			MODUSERNO = Ar_CRTUSERNO,
			MODDATE = Sysdate
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;
	
	SP_T_BUDG_LAST_CONFIRM(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_CRTUSERNO);
End;
/
