CREATE OR REPLACE Procedure SP_T_BUDG_DEPT_ITEM_H_ALL2
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2,
	Ar_CHG_SEQ						Number,
	Ar_BUDG_CODE_NO				Varchar2,
	Ar_CRTUSERNO					Varchar2
)
Is
	Type T_DEPT Is Table Of T_BUDG_DEPT_H.DEPT_CODE%Type
		Index By Binary_Integer;
	Type T_DEPT_NAME Is Table Of T_DEPT_CODE.DEPT_NAME%Type
		Index By Binary_Integer;
	lt_T_DEPT						T_DEPT;
	lt_T_DEPT_NAME					T_DEPT_NAME;
	ls_Tag							Varchar2(1);
	liStart							Number;
	liEnd								Number;
	lsErrm							Varchar2(2000);
Begin
	
	Select
		a.DEPT_CODE,
		a.DEPT_NAME
	Bulk Collect Into
		lt_T_DEPT,
		lt_T_DEPT_NAME
	from  t_dept_code a
	where budg_cls='T'
	and   a.dept_code not in ( select b.dept_code
		  			  	  	   from t_budg_dept_item_h b
		  			  	  	   where b.comp_code = Ar_COMP_CODE
		  			  	  	   and   b.clse_acc_id = Ar_CLSE_ACC_ID 
		  			  	  	   and   b.chg_seq = Ar_CHG_SEQ
		  			  	  	   and   b.budg_code_no = Ar_BUDG_CODE_NO
		  			  	  	   and   b.RESERVED_SEQ = 1
		  			  	  	 );
	
	If lt_T_DEPT.Count < 1 Then
		Raise_Application_Error(-20009,'등록할 대상이 없습니다.');
	End If;
	liStart := lt_T_DEPT.First;
	liEnd := lt_T_DEPT.Last;
	For liI In liStart..liEnd Loop
		Begin
			If AR_CHG_SEQ = 0 Then
			   SP_T_BUDG_CHECK_REQ_CLSE_DT(AR_COMP_CODE,AR_CLSE_ACC_ID,lt_T_DEPT(liI));
			End If; 
			SP_T_BUDG_DEPT_ITEM_H_I(Ar_COMP_CODE, Ar_CLSE_ACC_ID, lt_T_DEPT(liI), 0, Ar_BUDG_CODE_NO, 1,  Ar_CRTUSERNO, '', 0, 0, 0, '');
			SP_T_BUDG_DVD_MONTHS2(Ar_COMP_CODE, Ar_CLSE_ACC_ID, lt_T_DEPT(liI), 0, Ar_BUDG_CODE_NO, Ar_CRTUSERNO);
		Exception When Others Then
			lsErrm := SqlErrm;
			lsErrm := Replace(lsErrm,'ORA-20009:','');
			Raise_Application_Error(-20009,'부서/현장 :' ||lt_T_DEPT_NAME(liI)||'의 예산신청부서 등록 에러'||chr(10)||lsErrm);
		End;
	End Loop;
End;
/
