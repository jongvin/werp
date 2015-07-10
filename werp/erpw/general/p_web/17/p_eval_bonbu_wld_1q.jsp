<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_degree = req.getParameter("arg_eval_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("ic_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pe_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ee_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ga_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("gm_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ng_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("not_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ic_per",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pe_per",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ee_per",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ga_per",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("gm_per",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ng_per",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("not_per",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  select a.self_comp_code,                                                 			" +   
	"								  a.comp_name,                                                      			" +
	"								  a.self_dept_code,                                                 			" +   
	"								  a.short_name,                                                      			" +
	"								  a.emp_name,                                                       			" +
	"								  a.title_name,																				" +
 	"	  					 		  a.grade_name,                                                            " +
 	"	  					 		  nvl(sum(IC_CNT),0) IC_CNT,                                               " +
 	"	  					 		  nvl(sum(PE_CNT),0) PE_CNT,                                               " +
 	"	  					 		  nvl(sum(EE_CNT),0) EE_CNT,                                               " +
 	"	  					 		  nvl(sum(GA_CNT),0) GA_CNT,                                               " +
 	"	  					 		  nvl(sum(GM_CNT),0) GM_CNT,                                               " +
 	"	  					 		  nvl(sum(NG_CNT),0) NG_CNT,                                               " +
	"	  					 		  nvl(sum(NOT_CNT),0) NOT_CNT,                                             " +
	"	  					 		  nvl(sum(IC_PER),0) IC_PER,                                               " +
 	"	  					 		  nvl(sum(PE_PER),0) PE_PER,                                               " +
 	"	  					 		  nvl(sum(EE_PER),0) EE_PER,                                               " +
 	"	  					 		  nvl(sum(GA_PER),0) GA_PER,                                               " +
 	"	  					 		  nvl(sum(GM_PER),0) GM_PER,                                               " +
 	"	  					 		  nvl(sum(NG_PER),0) NG_PER,                                               " +
	"	  					 		  nvl(sum(NOT_PER),0) NOT_PER		                                          " +
	"						 from (select a.self_comp_code,                                                  " +   
	"										  e.comp_name,                                                       " +
	"										  a.self_dept_code,                                                  " +   
	"										  d.short_name,                                                       " +
	"										  b.emp_name,                                                        " +
	"										  d.level_code,                                                      " +
	"										  d.title_name,                                                      " +
	"										  decode(b.title_code, '09', '00', a.self_grade_code) grade_code,    " +		 
	"										  decode(b.title_code, '09', '팀장', f.grade_name) grade_name,       " +		 
	"							  	 		  decode(sec_eval_grade,'1',count(a.self_evaluator) ) IC_CNT,        " +
	"								   	  decode(sec_eval_grade,'2',count(a.self_evaluator) ) PE_CNT,        " +
	"								 		  decode(sec_eval_grade,'3',count(a.self_evaluator) ) EE_CNT,        " +
	"								 		  decode(sec_eval_grade,'4',count(a.self_evaluator) ) GA_CNT,        " +
	"								 		  decode(sec_eval_grade,'5',count(a.self_evaluator) ) GM_CNT,        " +
	"								 		  decode(sec_eval_grade,'6',count(a.self_evaluator) ) NG_CNT,        " +
	"										  decode(sec_eval_grade,NULL,count(a.self_evaluator) ) NOT_CNT,      " +
	"										  decode(sec_eval_grade,'1',trunc( (count(a.self_evaluator) / c.cnt *100),0) ) IC_PER,  " + 
	"								   	  decode(sec_eval_grade,'2',trunc( (count(a.self_evaluator) / c.cnt *100),0) ) PE_PER,  " + 
	"								 		  decode(sec_eval_grade,'3',trunc( (count(a.self_evaluator) / c.cnt *100),0) ) EE_PER,  " + 
	"								 		  decode(sec_eval_grade,'4',trunc( (count(a.self_evaluator) / c.cnt *100),0) ) GA_PER,  " + 
	"								 		  decode(sec_eval_grade,'5',trunc( (count(a.self_evaluator) / c.cnt *100),0) ) GM_PER,  " + 
	"								 		  decode(sec_eval_grade,'6',trunc( (count(a.self_evaluator) / c.cnt *100),0) ) NG_PER,  " +
	"								 		  decode(sec_eval_grade,NULL,trunc( (count(a.self_evaluator) / c.cnt *100),0) ) NOT_PER " + 
	"								   from p_eval_world_list a,																" +
	"										  (select distinct resident_no, emp_name, service_div_code, title_code from p_pers_master)   b, " +
	"										  view_dept_code  d,                                                 " +
	"										  z_code_comp     e,                                                 " +
	"										  p_code_grade    f,                                                 " +
	"										  (select count(*) cnt                                               " +       
	"							     			  from p_eval_world_list                                          " +         
	"								 		    where eval_code   = '02'                                         " +
	"											   and eval_degree = '"+ arg_eval_degree +"'                      " +
	"								         ) c                                                               " +
	"									where a.self_evaluator = b.resident_no                                  " +
	"									  and b.service_div_code = '2'														" +
	"									  and a.self_dept_code = d.dept_code(+)                                 " +
	"									  and a.self_comp_code = e.comp_code(+)                                 " +
	"									  and a.self_grade_code = f.grade_code(+)                               " +
	"									  and eval_code   = '02'                                    			   " +
	"									  and eval_degree = '"+ arg_eval_degree +"'                             " +
	"								group by a.self_comp_code,                                                 " +   
	"										  e.comp_name,                                                       " +
	"										  a.self_dept_code,                                                  " +   
	"										  d.short_name,                                                       " +
	"										  b.emp_name,                                                        " +
	"										  d.level_code,                                                      " +
	"										  d.title_name,                                                      " +
	"										  decode(b.title_code, '09', '00', a.self_grade_code),    				" +		 
	"										  decode(b.title_code, '09', '팀장', f.grade_name),       				" +		 
	"										  a.sec_eval_grade,                                                  " +
	"										  c.cnt                                                              " +
	"								 ) a                                                                       " +
	"					  group by a.self_comp_code,                                                 			" +   
	"								  a.comp_name,                                                      			" +
	"								  a.self_dept_code,                                                 			" +   
	"								  a.short_name,                                                      			" +
	"								  a.emp_name,                                                       			" +
	"								  a.level_code,                                                            " +
	"						 		  a.title_name,                                                            " +
	"						 		  a.grade_code,                                                            " +
	"						 		  a.grade_name                                                             " +
	"					  order by a.self_comp_code,                                                 			" +   
	"								  a.level_code,                                                            " +
	"						 		  a.self_dept_code,                                                 			" +   
	"								  a.grade_code,                                                            " +
	"						  		  a.emp_name                                                       			" +
	"								  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>