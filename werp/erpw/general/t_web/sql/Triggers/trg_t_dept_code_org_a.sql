Create Or Replace Trigger trg_t_dept_code_org_a
After Insert Or Update Or Delete On t_dept_code_org
For Each Row
Declare
	lnCustSeq				Number;
Begin
	If Inserting Then
		Select
			sq_t_cust_seq.nextval
		Into
			lnCustSeq
		From	Dual;
		Begin
			Insert Into t_cust_code
			(
				CUST_SEQ,
				CUST_CODE,
				CUST_NAME,
				TRADE_CLS,
				USE_CLS,
				REPRESENT_CUST_SEQ
			)
			Values
			(
				lnCustSeq,
				:New.DEPT_CODE,
				:New.DEPT_NAME,
				'5',
				'T',
				lnCustSeq
			);
		Exception When Dup_Val_On_Index Then
			Update	t_cust_code
			Set		cust_name = :New.dept_name
			Where	cust_code = :New.Dept_Code;
		End;
	ElsIf Updating Then
		Update	t_cust_code
		Set		cust_name = :New.dept_name
		Where	cust_code = :Old.Dept_Code;
	Else
		Delete	t_cust_code
		Where	cust_code = :Old.Dept_Code;
	End If;
End;
/
