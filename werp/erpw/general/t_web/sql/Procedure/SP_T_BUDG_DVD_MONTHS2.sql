CREATE OR REPLACE Procedure SP_T_BUDG_DVD_MONTHS2
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_DEPT_CODE					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_BUDG_CODE_NO					Number,
	Ar_CRTUSERNO					Varchar2
)
Is
Begin
	If AR_CHG_SEQ = 0 Then
	   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	End If;
	Merge Into T_BUDG_MONTH_AMT_H t
	Using
	(
		Select
			a.COMP_CODE ,
			a.CLSE_ACC_ID ,
			a.DEPT_CODE ,
			a.CHG_SEQ ,
			a.BUDG_CODE_NO ,
			a.RESERVED_SEQ ,
			To_Date(a.CLSE_ACC_ID ||  b.lv||'01','YYYYMMDD') BUDG_YM,
			Ar_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			Ar_CRTUSERNO MODUSERNO,
			SysDate MODDATE,
			Decode(Row_Number() over ( Partition By a.COMP_CODE ,
														a.CLSE_ACC_ID ,
														a.DEPT_CODE ,
														a.CHG_SEQ ,
														a.BUDG_CODE_NO ,
														a.RESERVED_SEQ
													Order By
															To_Date(a.CLSE_ACC_ID ||  b.lv||'01','YYYYMMDD') ) , 12 ,
									Nvl(a.BUDG_ITEM_REQ_AMT,0) - Nvl(Sum(Trunc(a.BUDG_ITEM_REQ_AMT / 12)) over ( Partition By a.COMP_CODE ,
														a.CLSE_ACC_ID ,
														a.DEPT_CODE ,
														a.CHG_SEQ ,
														a.BUDG_CODE_NO ,
														a.RESERVED_SEQ
														Order By
															To_Date(a.CLSE_ACC_ID ||  b.lv||'01','YYYYMMDD') ),0) + Nvl(Trunc(a.BUDG_ITEM_REQ_AMT / 12),0)
									,Trunc(a.BUDG_ITEM_REQ_AMT / 12)) BUDG_MONTH_REQ_AMT,
		     Decode(Row_Number() over ( Partition By a.COMP_CODE ,
														a.CLSE_ACC_ID ,
														a.DEPT_CODE ,
														a.CHG_SEQ ,
														a.BUDG_CODE_NO ,
														a.RESERVED_SEQ
													Order By
															To_Date(a.CLSE_ACC_ID ||  b.lv||'01','YYYYMMDD') ) , 12 ,
									Nvl(a.BUDG_ITEM_ASSIGN_AMT,0) - Nvl(Sum(Trunc(a.BUDG_ITEM_ASSIGN_AMT / 12)) over ( Partition By a.COMP_CODE ,
														a.CLSE_ACC_ID ,
														a.DEPT_CODE ,
														a.CHG_SEQ ,
														a.BUDG_CODE_NO ,
														a.RESERVED_SEQ
														Order By
															To_Date(a.CLSE_ACC_ID ||  b.lv||'01','YYYYMMDD') ),0) + Nvl(Trunc(a.BUDG_ITEM_ASSIGN_AMT / 12),0)
									,Trunc(a.BUDG_ITEM_ASSIGN_AMT / 12)) BUDG_MONTH_ASSIGN_AMT
		From	T_BUDG_DEPT_ITEM_H a,
				(
					Select
						To_Char(Level,'fm00') LV
					From	Dual
					Connect By
						Level <=12
				) b
		Where	a.COMP_CODE = Ar_COMP_CODE
		And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		a.DEPT_CODE = Ar_DEPT_CODE
		And		a.CHG_SEQ = Ar_CHG_SEQ
		And		a.BUDG_CODE_NO = Ar_BUDG_CODE_NO
		Order by
			a.COMP_CODE ,
			a.CLSE_ACC_ID ,
			a.DEPT_CODE ,
			a.CHG_SEQ ,
			a.BUDG_CODE_NO ,
			a.RESERVED_SEQ ,
			To_Date(a.CLSE_ACC_ID ||  b.lv||'01','YYYYMMDD')
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
	Set	t.BUDG_MONTH_REQ_AMT = f.BUDG_MONTH_REQ_AMT,
	t.BUDG_MONTH_ASSIGN_AMT = f.BUDG_MONTH_ASSIGN_AMT
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
		t.MODUSERNO,
		t.MODDATE,
		t.BUDG_MONTH_REQ_AMT,
		t.BUDG_MONTH_ASSIGN_AMT
	)
	Values
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
		f.MODUSERNO,
		f.MODDATE,
		f.BUDG_MONTH_REQ_AMT,
		f.BUDG_MONTH_ASSIGN_AMT
	);
End;
/
