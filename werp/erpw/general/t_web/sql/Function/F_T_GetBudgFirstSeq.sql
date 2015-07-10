Create Or Replace Function F_T_GetBudgFirstSeq
(
	Ar_COMP_CODE				Varchar2,
	Ar_DEPT_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_CRTUSERNO				Varchar2
)
Return Number
Is
	Pragma Autonomous_transaction;
	lnSeq						Number;
Begin
	Lock Table T_BUDG_DEPT_H In Exclusive Mode ;
	Begin
		Select
			Min(CHG_SEQ)
		Into
			lnSeq
		From	T_BUDG_DEPT_H
		Where	COMP_CODE = Ar_COMP_CODE
		And		DEPT_CODE = Ar_DEPT_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID;
	Exception When No_Data_Found Then
		lnSeq := Null;
	End;
	If lnSeq Is Null Then
		Begin
			Insert Into T_BUDG_DEPT
			(
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				LAST_CONFIRMED_SEQ,
				LAST_WORK_SEQ,
				FIRST_SEQ
			)
			Values
			(
				Ar_COMP_CODE,
				Ar_CLSE_ACC_ID,
				Ar_DEPT_CODE,
				Ar_CRTUSERNO,
				SysDate,
				Null,
				Null,
				Null,
				Null,
				Null
			);
		Exception When Dup_Val_On_Index Then
			Null;
		End;
		Insert Into T_BUDG_DEPT_H
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			CHG_SEQ,
			CRTUSERNO,
			CRTDATE,
			MODUSERNO,
			MODDATE,
			CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_DEPT_CODE,
			0,
			Ar_CRTUSERNO,
			SysDate,
			Null,
			Null,
			'F'
		)
		Returning CHG_SEQ Into lnSeq;
		Update	T_BUDG_DEPT
		Set		LAST_WORK_SEQ = lnSeq,
				FIRST_SEQ = lnSeq
		Where	COMP_CODE = Ar_COMP_CODE
		And		DEPT_CODE = Ar_DEPT_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID;
	End If;
	Commit;
	Return lnSeq;
Exception When Others Then
	Rollback;
	Raise;
End;
/
