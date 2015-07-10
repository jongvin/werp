CREATE OR REPLACE Procedure	SP_T_BUDG_DEPT_ITEM_H_ALL
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_DEPT_CODE					Varchar2,
	Ar_MAKE_DEPT					Varchar2,
	Ar_CRTUSERNO					Varchar2
)
Is
	Type T_BUDG_CODE_NO	 Is	Table Of T_BUDG_CODE.BUDG_CODE_NO%Type
		Index By Binary_Integer;
	Type T_BUDG_CODE_NAME Is Table Of T_BUDG_CODE.BUDG_CODE_NAME%Type
		Index By Binary_Integer;
	lt_T_BUDG_CODE_NO					T_BUDG_CODE_NO;
	lt_T_BUDG_CODE_NAME					T_BUDG_CODE_NAME;
	liStart							Number;
	liEnd							Number;
	lsErrm							Varchar2(2000);
Begin
	Select
		a.BUDG_CODE_NO,
		a.BUDG_CODE_NAME
	Bulk Collect Into
		lt_T_BUDG_CODE_NO,
		lt_T_BUDG_CODE_NAME
	From	T_BUDG_CODE	a
	Where	 a.MAKE_DEPT = Ar_MAKE_DEPT
	And BUDG_CODE_NO not in 	
							(select 
									BUDG_CODE_NO
							 FROM  T_BUDG_DEPT_ITEM_H B
							 WHERE B.COMP_CODE = Ar_COMP_CODE
							 AND   B.CLSE_ACC_ID = Ar_CLSE_ACC_ID
							 AND   B.DEPT_CODE = Ar_DEPT_CODE
							 AND   B.CHG_SEQ = 0 
							 AND   B.RESERVED_SEQ = 1
							  );
	--If lt_T_DEPT.Count < 1 Then
		--Raise_Application_Error(-20009,'이미 모든부서가 등록되었습니다.');
	--End If;
	If lt_T_BUDG_CODE_NO.Count > 0 Then
		liStart	:= lt_T_BUDG_CODE_NO.First;
		liEnd	:= lt_T_BUDG_CODE_NO.Last;
		For	liI	In liStart..liEnd Loop
			Begin
				SP_T_BUDG_DEPT_ITEM_H_I(Ar_COMP_CODE, Ar_CLSE_ACC_ID, AR_DEPT_CODE,	0, lt_T_BUDG_CODE_NO(liI), 1,  Ar_CRTUSERNO, '', 0,	0, 0, '');
			Exception When Others Then
				lsErrm := SqlErrm;
				lsErrm := Replace(lsErrm,'ORA-20009:','');
				Raise_Application_Error(-20009,'예산항목 :'	||lt_T_BUDG_CODE_NAME(liI)||'의	예산항목 등록  에러'||chr(10)||lsErrm);
			End;
		End	Loop;
	End If;
End;