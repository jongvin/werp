<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_yyyymm = req.getParameter("arg_yyyymm");
 //---------------------------------------------------------- 
//	 dSet.addDataColumn(new GauceDataColumn("tag_name",GauceDataColumn.TB_STRING,20));	
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	 dSet.addDataColumn(new GauceDataColumn("const_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("completion_date",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("change_sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
//	 dSet.addDataColumn(new GauceDataColumn("extablish_time",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("payment_condition",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("result_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
//	 dSet.addDataColumn(new GauceDataColumn("extablish_tag",GauceDataColumn.TB_STRING,20));
	dSet.addDataColumn(new GauceDataColumn("cp_sum_due",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("tot_rcv_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("reservation_amt",GauceDataColumn.TB_DECIMAL,18,0));
//	 dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("pre_sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("year_sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     
    String query =" select a.dept_code, " +
"									a.const_name, " +
"									a.start_date, " +
"									a.completion_date, " +
"									a.change_sum_amt, " +
"									a.cont_no, " +
"									a.payment_condition, " +
"									b.result_amt, " +
"       							c.supply_amt, " +
"									nvl(c.supply_amt,0) - nvl(d.tot_rcv_amt,0) cp_sum_due, " +
"									d.pre_amt pre_sum_amt, " +
"									d.tot_rcv_amt, " +
"									nvl(b.result_amt,0) - nvl(c.supply_amt,0) reservation_amt, " +
"									d.this_year_amt year_sum_amt, " +
"									d.this_mm_amt sum_amt" +
"  						from (select a.dept_code, " +
"											 a.cont_no, " +
"											 a.chg_degree, " +
"											 a.const_name, " +
"											 to_char(a.start_date,'YYYY.MM') start_date,  " +
"											 to_char(a.completion_date,'YYYY.MM') completion_date, " +
"       									 a.change_sum_amt,a.payment_condition " +
"			 						  from r_contract_register a, " +
"				   			  			 (select max(dept_code) dept_code, " +
"											 			max(cont_no) cont_no, " +
"											 			max(chg_degree) chg_degree " +
"					   			  			 from r_contract_register " +
"				  				    			group by dept_code,cont_no) b " +
"						  			 where a.dept_code = b.dept_code " +
"			  				 			and a.cont_no = b.cont_no " +
"			  				 			and a.chg_degree = b.chg_degree " +
"			  				 			and to_char(a.start_date ,'YYYY') <= substr('" + arg_yyyymm + "',0,4) " +
"			  				 			and to_char(a.completion_date,'YYYY') >= substr('" + arg_yyyymm + "',0,4)) a, " +
"		 					 		(select max(a.dept_code) dept_code,max(a.yymm),nvl(sum(a.cnt_result_amt),0) + nvl(sum(a.ls_cnt_result_amt),0) result_amt " +
"			 					 		from c_spec_const_detail a, " +
"				   		 				  (select max(dept_code) dept_code,max(yymm) yymm " +
"					    		 				  from c_spec_const_parent " +
"												 where to_char(yymm, 'yyyy-mm') <= '" + arg_yyyymm + "' " +
"												 group by dept_code ) b " +
"			 		 				  where a.dept_code = b.dept_code " +
"										 and a.yymm = b.yymm " + 
"		 			 				  group by a.dept_code) b, " +
"		 						   (select max(dept_code) dept_code,nvl(sum(decode(extablish_tag,'2',supply_amt,0)),0) supply_amt " +
"		    							from r_contract_time_extablished " +
"		   						  where to_char(issue_date,'yyyy-mm') <= '" + arg_yyyymm + "' " +
"									  group by dept_code ) c, " +
"		 							(select max(dept_code) dept_code,nvl(sum(decode(extablish_tag,'1',supply_amt,0)),0) pre_amt, " +
"				   						  nvl(sum(decode(extablish_tag,'2',supply_amt,0)),0) tot_rcv_amt,  " +
"				   						  nvl(sum(decode(extablish_tag,'2',decode(to_char(received_date,'YYYY'),substr('" + arg_yyyymm + "',0,4),supply_amt,0),0)),0) this_year_amt, " +
"				   						  nvl(sum(decode(extablish_tag,'2',decode(to_char(received_date,'YYYY'),substr('" + arg_yyyymm + "',0,4),0,supply_amt),0)),0) pre_year_amt, " +
"				   						  nvl(sum(decode(extablish_tag,'2',decode(to_char(received_date,'YYYY-MM'),'" + arg_yyyymm + "',supply_amt,0),0)),0) this_mm_amt " +
"		    							from r_contract_time_collection " +
"		   where to_char(received_date,'yyyy-mm') <= '" + arg_yyyymm + "' " +
"		group by dept_code ) d " +
" where a.dept_code = b.dept_code (+) " +
"    and a.dept_code = c.dept_code (+)  " +
"    and a.dept_code = d.dept_code (+) " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>