Create Or Replace Procedure SP_T_BUDG_DEPT_CONFIRM
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_DEPT_CODE					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_CONFIRM						Varchar2,
	Ar_CRTUSERNO					Varchar2
)
Is
	ls_CONFIRM_TAG					T_BUDG_DEPT_H.CONFIRM_TAG%Type;
	ls_BUDG_CODE_NAME				T_BUDG_CODE.BUDG_CODE_NAME%Type;
	lb_Found						Boolean;
Begin
	Select	CONFIRM_TAG
	Into	ls_CONFIRM_TAG
	From	T_BUDG_DEPT_H a
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		CHG_SEQ = AR_CHG_SEQ;

	If ls_CONFIRM_TAG = Ar_CONFIRM Then
		If ls_CONFIRM_TAG = 'T' Then
			Raise_Application_Error(-20009,'해당 예산은 이미 확정되어 있습니다.');
		Else
			Raise_Application_Error(-20009,'해당 예산은 확정되어 있지 않습니다.');
		End If;
	End If;

	
	If Ar_CONFIRM = 'T' Then
		SP_T_BUDG_DEPT_CONFIRM_Y(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_CHG_SEQ,Ar_CRTUSERNO);
	Else
		SP_T_BUDG_DEPT_CONFIRM_N(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_CHG_SEQ,Ar_CRTUSERNO);
	End If;
End;
/

--exec SP_T_BUDG_DEPT_CONFIRM('A0','2004','A01325',0,'T',0);

exec SP_T_BUDG_DEPT_CONFIRM('A0','2004','A01325',0,'F',0);