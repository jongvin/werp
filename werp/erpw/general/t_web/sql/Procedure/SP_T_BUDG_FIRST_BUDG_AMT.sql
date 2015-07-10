CREATE OR REPLACE Procedure SP_T_BUDG_FIRST_BUDG_AMT
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CHG_SEQ                                   NUMBER
)
Is
	ls_Last_Acc_Id							T_BUDG_YEAR.CLSE_ACC_ID%Type;
Begin
	
	Merge Into T_BUDG_DEPT_ITEM_H t
	Using
	(
		Select
				comp_code,
				clse_acc_id,
				dept_code,
				chg_seq,
				budg_code_no,
				reserved_seq,
				budg_item_assign_amt
		From	T_BUDG_DEPT_ITEM_H a
		Where  	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And	     CHG_SEQ	  = AR_CHG_SEQ
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
		t.BUDG_ITEM_REQ_AMT_A = f.BUDG_ITEM_ASSIGN_AMT
	When Not Matched Then
	Insert
	(
		t.COMP_CODE

	)
	Values
	(
		f.COMP_CODE

	);
	Merge Into T_BUDG_MONTH_AMT_H t
	Using
	(
		Select
			a.COMP_CODE COMP_CODE,
			AR_CLSE_ACC_ID CLSE_ACC_ID,
			a.DEPT_CODE DEPT_CODE,
			a.CHG_SEQ,
			a.BUDG_CODE_NO BUDG_CODE_NO,
			a.RESERVED_SEQ RESERVED_SEQ,
			--(to_number(to_char(a.BUDG_YM,'YYYY')) +1) ||  '-' || to_char(a.BUDG_YM,'MM-DD') BUDG_YM,
			budg_ym,
			a.BUDG_MONTH_ASSIGN_AMT
		From	T_BUDG_MONTH_AMT_H a
		where   COMP_CODE = AR_COMP_CODE
		And	     CLSE_ACC_ID = AR_CLSE_ACC_ID
		And	     DEPT_CODE = AR_DEPT_CODE
		And	     CHG_SEQ	  = AR_CHG_SEQ
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
		t.BUDG_MONTH_REQ_AMT_A = f.BUDG_MONTH_ASSIGN_AMT
	When Not Matched Then
	Insert
	(
		t.COMP_CODE

	)
	values
	(
		f.COMP_CODE

	);
	--commit;
End;
/
