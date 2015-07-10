CREATE OR REPLACE Procedure SP_T_BUDG_COPY_PREV_YEAR
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
Is
	ls_Last_Acc_Id							T_BUDG_YEAR.CLSE_ACC_ID%Type;
	lnCnt									Number;
Begin
	SP_T_BUDG_DEPT_ITEM_PARENT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,0,AR_CRTUSERNO);
	SP_T_BUDG_CHECK_CONFIRM(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,0);
	Begin
		Select
			Max(CLSE_ACC_ID)
		Into
			ls_Last_Acc_Id
		From	T_BUDG_YEAR
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID < AR_CLSE_ACC_ID;
	Exception When No_Data_Found Then
		ls_Last_Acc_Id := Null;
	End;
	If ls_Last_Acc_Id Is Null Then
		Raise_Application_Error(-20009,'전년도 예산을 찾을 수 없습니다.');
	End If;
	Select
		Count(*)
	Into
		lnCnt
	From	T_BUDG_DEPT_ITEM
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = ls_Last_Acc_Id
	And		DEPT_CODE = AR_DEPT_CODE;
	If lnCnt < 1 Then
		Raise_Application_Error(-20009,'전년도의 확정된 예산을 찾을 수 없습니다.');
	End If;
	Merge Into T_BUDG_DEPT_ITEM_H t
	Using
	(
		Select
			a.COMP_CODE COMP_CODE,
			AR_CLSE_ACC_ID CLSE_ACC_ID,
			a.DEPT_CODE DEPT_CODE,
			0 CHG_SEQ,
			a.BUDG_CODE_NO BUDG_CODE_NO,
			a.RESERVED_SEQ RESERVED_SEQ,
			AR_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			AR_CRTUSERNO MODUSERNO,
			SysDate MODDATE,
			a.TARGET_DEPT_CODE TARGET_DEPT_CODE,
			a.BUDG_ITEM_ASSIGN_AMT BUDG_ITEM_REQ_AMT
		From	T_BUDG_DEPT_ITEM a,
				T_BUDG_CODE b
		where   a.budg_code_no = b.budg_code_no
		and		MAKE_DEPT is null
		and  	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = ls_Last_Acc_Id
		And		DEPT_CODE = AR_DEPT_CODE
	) f
	On
	(
			f.COMP_CODE = t.COMP_CODE
		And	f.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	f.DEPT_CODE = t.DEPT_CODE
		And	f.CHG_SEQ = t.CHG_SEQ
		And	f.BUDG_CODE_NO = t.BUDG_CODE_NO
		And	f.RESERVED_SEQ = t.RESERVED_SEQ
	)
	When Matched Then
	Update
	set
		t.BUDG_ITEM_REQ_AMT = f.BUDG_ITEM_REQ_AMT,
		t.MODUSERNO = f.MODUSERNO,
		t.MODDATE = f.MODDATE
	When Not Matched Then
	Insert
	(
		t.COMP_CODE,
		t.CLSE_ACC_ID,
		t.DEPT_CODE,
		t.CHG_SEQ,
		t.BUDG_CODE_NO,
		t.RESERVED_SEQ,
		t.CRTUSERNO,
		t.CRTDATE,
		t.TARGET_DEPT_CODE,
		t.BUDG_ITEM_REQ_AMT
	)
	Values
	(
		f.COMP_CODE,
		f.CLSE_ACC_ID,
		f.DEPT_CODE,
		f.CHG_SEQ,
		f.BUDG_CODE_NO,
		f.RESERVED_SEQ,
		f.CRTUSERNO,
		f.CRTDATE,
		f.TARGET_DEPT_CODE,
		f.BUDG_ITEM_REQ_AMT
	);
	Merge Into T_BUDG_MONTH_AMT_H t
	Using
	(
		Select
			a.COMP_CODE COMP_CODE,
			AR_CLSE_ACC_ID CLSE_ACC_ID,
			a.DEPT_CODE DEPT_CODE,
			0 CHG_SEQ,
			a.BUDG_CODE_NO BUDG_CODE_NO,
			a.RESERVED_SEQ RESERVED_SEQ,
			(to_number(to_char(a.BUDG_YM,'YYYY')) +1) ||  '-' || to_char(a.BUDG_YM,'MM-DD') BUDG_YM,
			AR_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			AR_CRTUSERNO MODUSERNO,
			SysDate MODDATE,
			a.BUDG_MONTH_ASSIGN_AMT BUDG_MONTH_REQ_AMT
		From	T_BUDG_MONTH_AMT a,
				T_BUDG_CODE b
		where   a.budg_code_no = b.budg_code_no
		and		MAKE_DEPT is null
		and	    COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = ls_Last_Acc_Id
		And		DEPT_CODE = AR_DEPT_CODE
	) f
	On
	(
			f.COMP_CODE = t.COMP_CODE
		And	f.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	f.DEPT_CODE = t.DEPT_CODE
		And	f.CHG_SEQ = t.CHG_SEQ
		And	f.BUDG_CODE_NO = t.BUDG_CODE_NO
		And	f.RESERVED_SEQ = t.RESERVED_SEQ
		And	f.BUDG_YM = t.BUDG_YM
	)
	When Matched Then
	Update
	set
		t.BUDG_MONTH_REQ_AMT = f.BUDG_MONTH_REQ_AMT,
		t.MODUSERNO = f.MODUSERNO,
		t.MODDATE = f.MODDATE
	When Not Matched Then
	Insert
	(
		t.COMP_CODE,
		t.CLSE_ACC_ID,
		t.DEPT_CODE,
		t.CHG_SEQ,
		t.BUDG_CODE_NO,
		t.RESERVED_SEQ,
		t.BUDG_YM,
		t.CRTUSERNO,
		t.CRTDATE,
		t.BUDG_MONTH_REQ_AMT
	)
	values
	(
		f.COMP_CODE,
		f.CLSE_ACC_ID,
		f.DEPT_CODE,
		f.CHG_SEQ,
		f.BUDG_CODE_NO,
		f.RESERVED_SEQ,
		f.BUDG_YM,
		f.CRTUSERNO,
		f.CRTDATE,
		f.BUDG_MONTH_REQ_AMT
	);
End;
/
