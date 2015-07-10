CREATE OR REPLACE Function F_T_Get_Month_Budg_Amt
(
	Ar_Comp_Code			Varchar2,
	Ar_Clse_Acc_Id			Varchar2,
	Ar_Budg_Code_No			Number,
	Ar_Month				Varchar2,
	Ar_Dept_Code			Varchar2
)
Return Varchar2
Is
	Type T_GRADE_CODE Is Table Of T_BUDG_MONTH_REQ.DEPT_CODE%Type
		Index By Binary_Integer;
	Type T_PERSON_CNT Is Table Of T_BUDG_MONTH_REQ.CHG_AMT%Type
		Index By Binary_Integer;
		
	
	lt_GRADE_CODE				T_GRADE_CODE;
	lt_PERSON_CNT				T_PERSON_CNT;
	lt_ITEM_NO					T_PERSON_CNT;
	lt_UNIT_COST				T_PERSON_CNT;
	lt_DAY_CALC_TAG				T_GRADE_CODE;
	lt_UNIT_TAG					T_GRADE_CODE;
	lt_GRADE_UNIT_TAG			T_GRADE_CODE;
	ln_UNIT_COST				Number;
	ln_Month_Cost				Number;
	ln_TOTAL_PERSON_CNT			Number;
	liStart						Number;
	liEnd						Number;
	li2Start					Number;
	li2End						Number;
Begin
	ln_Month_Cost := 0;
	
	select unit_cost,
	   	   item_no,
		   day_calc_tag,
		   unit_tag,
		   grade_unit_tag 
	Bulk Collect Into
	   	   lt_UNIT_COST,
		   lt_ITEM_NO,
		   lt_DAY_CALC_TAG,
		   lt_UNIT_TAG,
		   lt_GRADE_UNIT_TAG 
	from   t_budg_item_cost a
	where  a.comp_code    = Ar_Comp_Code
	and	   a.clse_acc_id  = Ar_Clse_Acc_Id
	and	   a.budg_code_no = Ar_Budg_Code_No;
	
	li2Start := lt_ITEM_NO.First;
	li2End   := lt_ITEM_NO.Last;
	
	For liI2 In li2Start..li2End Loop
	   
		IF lt_GRADE_UNIT_TAG(liI2) = 'T' Then 
		   
		   --직급별인원수(부서) *월단가(일자계산기준, 단가기준, 직급별단가, 월수(월))
		   
		   --직급별인원
		   select grade_code,
		   		  count(emp_no) 
		   Bulk Collect Into
		   	 	  lt_GRADE_CODE,
				  lt_PERSON_CNT 
		   from	  v_t_budg_dept_info a --부서정보 뷰
		   where  a.dept_code = Ar_Dept_Code
		   group  by grade_code;
		   	   
		   liStart := lt_GRADE_CODE.First;
		   liEnd   := lt_GRADE_CODE.Last;

		   For liI In liStart..liEnd Loop
		   	   --직급별단가
			   select unit_cost
			   Into   ln_unit_cost
			   from   t_budg_item_grade_cost a
			   where  a.comp_code 	 = Ar_Comp_Code
			   and	  a.clse_acc_id  = Ar_Clse_Acc_Id
			   and	  a.budg_code_no = Ar_Budg_Code_No
			   and	  a.item_no 	 = lt_ITEM_NO(liI2)
			   and	  a.grade_code   = lt_GRADE_CODE(liI);
				   
				ln_Month_Cost := ln_Month_Cost + (lt_PERSON_CNT(liI) * F_T_Get_Month_Unit_Cost( lt_DAY_CALC_TAG(liI2), lt_UNIT_TAG(liI2), ln_unit_cost, F_T_Get_Last_Days(Ar_Month)));

		   End Loop;
		   
		   
		   
		ElsIF lt_GRADE_UNIT_TAG(liI2) = 'F' Then 
		   
		   --부서별충인원
		   select sum(emp_no) 
		   Into
				  ln_TOTAL_PERSON_CNT 
		   from	  v_t_budg_dept_info a
		   where  a.dept_code = Ar_Dept_Code
		   group  by grade_code; 
    
		   --부서총인원(부서) * 월단가(일자계산기준, 단가기준, 단가, 월수(월))
		   ln_Month_Cost := ln_TOTAL_PERSON_CNT * F_T_Get_Month_Unit_Cost( lt_DAY_CALC_TAG(liI2), lt_UNIT_TAG(liI2), lt_UNIT_COST(liI2), F_T_Get_Last_Days(Ar_Month));

		     
		End If;
	End Loop;      
	Return ln_Month_Cost;
End;
/
