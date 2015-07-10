CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_ITEM_PARENT
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                 NUMBER,
	AR_CRTUSERNO                               VARCHAR2
)
Is
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If;
	Begin
		Insert Into T_BUDG_DEPT
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			CRTUSERNO,
			CRTDATE,
			LAST_CONFIRMED_SEQ,
			LAST_WORK_SEQ,
			FIRST_SEQ
		)
		Values
		(
			AR_COMP_CODE,
			AR_CLSE_ACC_ID,
			AR_DEPT_CODE,
			AR_CRTUSERNO,
			SysDate,
			Null,
			0,
			0
		);
	Exception When Dup_Val_On_Index Then
		Null;
	End;
	Begin
		Insert Into T_BUDG_DEPT_H
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			CHG_SEQ,
			CRTUSERNO,
			CRTDATE,
			CONFIRM_TAG,
			REQUEST_TAG
		)
		Values
		(
			AR_COMP_CODE,
			AR_CLSE_ACC_ID,
			AR_DEPT_CODE,
			AR_CHG_SEQ,
			AR_CRTUSERNO,
			SysDate,
			'F',
			'F'
			
		);
		Update	T_BUDG_DEPT
		Set		LAST_WORK_SEQ = AR_CHG_SEQ
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE;
	Exception When Dup_Val_On_Index Then
		Null;
	End;
End;