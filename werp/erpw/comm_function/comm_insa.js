//---------------------------------------------------------------------------------
function f_evaluator(arg_evaluator, arg_self_title, arg_self_dept, arg_self_comp, arg_degree, arg_ds_row, arg_grid_tag)
//---------------------------------------------------------------------------------
{
	// arg_evaluator	평가자 차수
	// arg_self_title	피평가자 직책
	// arg_self_dept 	피평가자 부서
	// arg_self_comp 	피평가자 사업체
	// arg_degree	 	피평가자 조직도차수
	// arg_ds_row		ds_1.RowPosition
	// arg_grid_tag	그리드지정/tx입력 여부
	
	var ls_title_evaluator	//평가자 직책
	var ls_evaluator			//평가자
	var ls_eval_tag			//평가자구분
	
	
	//피평가자의 평가자직책
	ll_cnt = f_select1_q("select  "+ arg_evaluator +" select_1          " +
			               "  from  p_code_title                          " +           
			               " where  title_code = '" + arg_self_title + "' ")
	if (ll_cnt == 1)  ls_title_evaluator = ds_select1.NameValue(1,"select_1")
	
	//평가자직책이 사장이면 조직도의 사장으로..
	if (ls_title_evaluator == '03'){			
		ll_cnt = f_select2_q("select distinct a.emp_no  select_1	" +
									"  from z_code_chg_dept_title a,    " +
									"  		 p_pers_master   b         " +
									" where a.emp_no = b.emp_no         " +
									"   and b.title_code = '03'         " +
									"   and b.service_div_code = '2'    " +
									"   and a.comp_code = b.comp_code   " +
									"   and a.comp_code = '"+ arg_self_comp +"' " +
									"   and a.degree    = '"+ arg_degree +"'	")	
	}
	//평가자직책이 본부장이면 조직도의 부서장으로..
	else if (ls_title_evaluator == '05'){			
		ll_cnt = f_select2_q("select a.emp_no	 select_1      		   			" +
									"  from z_code_chg_dept_title a,                   " +
									"  	  ( select level_code                        " +
									"			   from view_dept_code                    " +
									"			  where dept_code = '"+ arg_self_dept +"' " +
									"            and degree  = '"+ arg_degree +"') b   " +
									" where a.level_code = b.level_code       " +
									"   and a.degree     = '"+ arg_degree +"' ")						
	}
   else if (ls_title_evaluator == '06') { 	//평가자직책이 담당임원
   	
   }
	else if (ls_title_evaluator == '07' || ls_title_evaluator == '09') {		//평가자직책이 현장소장,팀장
		ll_cnt = f_select2_q("select a.emp_no   select_1					  " +
									"  from z_code_chg_dept_content a			  " +
									" where a.dept_code = '"+ arg_self_dept +"' ")
	}
	
	
	//평가자직책이 회장이면
	if (ls_title_evaluator == '01'){			
		ls_evaluator = '19830301'	//회장
	}
   else {
		if (ll_cnt == 1)  ls_evaluator = ds_select2.NameValue(1,"select_1")	//평가자
	}
	
	
	//평가자 정보
	ll_cnt = f_select3_q("select a.emp_no     select_1, " +
								"       a.emp_name   select_2, " +
								"       a.comp_code  select_3, " +
								"       a.dept_code  select_4, " +
								"       b.long_name  select_5, " +
								"       a.grade_code select_6, " +
								"       c.grade_name select_7  " +
								"  from p_pers_master a,		 " +
								"       z_code_dept   b,       " +
								"       p_code_grade  c        " +
								" where a.dept_code  = b.dept_code  " +
								"   and a.grade_code = c.grade_code " +
								"   and a.service_div_code = '2'    " +
								"   and a.emp_no     = '" + ls_evaluator + "' ")		
	 
	if (ll_cnt == 1){
		if (arg_evaluator == 'title_evaluator1') 	//1차평가자
			ls_eval_tag = 'fir'
		else if (arg_evaluator == 'title_evaluator2') 	//2차평가자
			ls_eval_tag = 'sec'
		
		if (arg_grid_tag == '1'){	//그리드 지정화면
			ds_1.NameValue(arg_ds_row, ls_eval_tag + "_evaluator") 		= ds_select3.NameValue(1,"select_1")	//1차평가자	
			ds_1.NameValue(arg_ds_row, ls_eval_tag + "_evaluator_name") = ds_select3.NameValue(1,"select_2")	//1차평가자	성명
			ds_1.NameValue(arg_ds_row, ls_eval_tag + "_comp_code") 		= ds_select3.NameValue(1,"select_3") 	//1차평가자 사업체
			ds_1.NameValue(arg_ds_row, ls_eval_tag + "_dept_code") 		= ds_select3.NameValue(1,"select_4") 	//1차평가자 부서
			ds_1.NameValue(arg_ds_row, ls_eval_tag + "_dept_name") 		= ds_select3.NameValue(1,"select_5") 	//1차평가자 부서명
			ds_1.NameValue(arg_ds_row, ls_eval_tag + "_grade_code") 		= ds_select3.NameValue(1,"select_6") 	//1차평가자 직위
			ds_1.NameValue(arg_ds_row, ls_eval_tag + "_grade_name") 		= ds_select3.NameValue(1,"select_7") 	//1차평가자 직위명
		}
		else{		//tx입력화면
			ds_list.NameValue(arg_ds_row, ls_eval_tag + "_evaluator")	= ds_select3.NameValue(1,"select_1")	//1차평가자	
			ds_list.NameValue(arg_ds_row, ls_eval_tag + "_comp_code") 	= ds_select3.NameValue(1,"select_3") 	//1차평가자 사업체
			ds_list.NameValue(arg_ds_row, ls_eval_tag + "_dept_code") 	= ds_select3.NameValue(1,"select_4") 	//1차평가자 부서
			ds_list.NameValue(arg_ds_row, ls_eval_tag + "_grade_code") 	= ds_select3.NameValue(1,"select_6") 	//1차평가자 직위
			
			if (arg_evaluator == 'title_evaluator1'){ 	//1차평가자
				tx_fir_evaluator_name.value = ds_select3.NameValue(1,"select_2")	//1차평가자 평가자명
				tx_fir_dept_name.value		 = ds_select3.NameValue(1,"select_5") 	//1차평가자 부서명
				tx_fir_grade_name.value	    = ds_select3.NameValue(1,"select_7") 	//1차평가자 직위명
			}
			else if (arg_evaluator == 'title_evaluator2'){ 	//2차평가자
				tx_sec_evaluator_name.value = ds_select3.NameValue(1,"select_2")	//1차평가자 평가자명
				tx_sec_dept_name.value		 = ds_select3.NameValue(1,"select_5") 	//1차평가자 부서명
				tx_sec_grade_name.value	    = ds_select3.NameValue(1,"select_7") 	//1차평가자 직위명
			}
		}
	}
	
}
//------------------------------------------------------------------------------
function f_ds_select_q(ls_ds,ls_sql)
//------------------------------------------------------------------------------
{
var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
  ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  
//         eval("sa_key = sa_key + " + arg_ds + ".NameValue(ll_start_1,'" + array[ll_loop] + "')") 
  i = parseInt(ls_colcnt,10)
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')
  eval(ls_ds + '.DataID="/werp/erpw/comm_function/comm_select_' + i + 'q.jsp?in_sql=' + lls_sql + '"')
  eval(ls_ds + ".SyncLoad = true")
  eval(ls_ds + ".reset()")
  eval("ll_cnt = " + ls_ds + ".CountRow")
  return ll_cnt
}
//-----------------------------------------------------------------------
function f_select1_q(ls_sql)
//-----------------------------------------------------------------------
{
  var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')

  
  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_select1.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
     }
 ds_select1.SyncLoad = true
 ds_select1.reset()
 ll_cnt = ds_select1.CountRow
 return ll_cnt
}  
//---------------------------------------------------------------------------------
function f_select2_q(ls_sql)
//---------------------------------------------------------------------------------
{
  var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
  ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_select2.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
     }
 ds_select2.SyncLoad = true
 ds_select2.reset()
 ll_cnt = ds_select2.CountRow
 return ll_cnt
} 
//---------------------------------------------------------------------------------
function f_select3_q(ls_sql)
//---------------------------------------------------------------------------------
{
  var i,j,ll_find,ll_from,ls_colcnt,ll_cnt
  ll_find = 0
  ll_from = ls_sql.lastIndexOf("select_")
  for(i=ll_from ; i < ls_sql.length ; i++) {
     if  (ls_sql.substr(i,1) == "_") { 
         for (j=i; j < ls_sql.length ; j++) {
             if (ls_sql.substr(j,1) == " ") {
                 ll_find = 1
                 break
             }    
         }
     }
   if (ll_find == 1) break
  }      
  ls_colcnt = ls_sql.substr(i+1, j-i)
  var lls_sql = ls_sql
  lls_sql = lls_sql.replace(/\+/g,'!')

  

  switch(parseInt(ls_colcnt))  
    {
     case 1 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_1q.jsp?in_sql=" + lls_sql; break 
     case 2 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_2q.jsp?in_sql=" + lls_sql; break 
     case 3 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_3q.jsp?in_sql=" + lls_sql; break 
     case 4 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_4q.jsp?in_sql=" + lls_sql; break 
     case 5 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_5q.jsp?in_sql=" + lls_sql; break 
     case 6 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_6q.jsp?in_sql=" + lls_sql; break 
     case 7 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_7q.jsp?in_sql=" + lls_sql; break 
     case 8 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_8q.jsp?in_sql=" + lls_sql; break 
     case 9 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_9q.jsp?in_sql=" + lls_sql; break 
     case 10 : ds_select3.DataID="/werp/erpw/comm_function/comm_select_10q.jsp?in_sql=" + lls_sql; break 
     }
 ds_select3.SyncLoad = true
 ds_select3.reset()
 ll_cnt = ds_select3.CountRow
 return ll_cnt
} 
