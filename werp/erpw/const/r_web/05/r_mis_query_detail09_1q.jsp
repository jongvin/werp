<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_unit = req.getParameter("arg_unit");
     String arg_sum_code = req.getParameter("arg_sum_code") + '%';
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ly_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_01",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_02",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_03",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_04",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_05",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_06",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_07",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_08",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_09",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_10",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_11",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_12",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_tot",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_tot",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " select  a.dept_code dept_code,  " + 
     "		  a.long_name long_name," + 
     "		  trunc(round((nvl(a.ly_tot,0)) / " + arg_unit + "),0 )   ly_tot,  " + 
     "		  trunc(round((nvl(a.comp_01,0)) / " + arg_unit + "),0 ) comp_01,  " + 
     "		  trunc(round((nvl(a.comp_02,0)) / " + arg_unit + "),0 ) comp_02,  " + 
     "		  trunc(round((nvl(a.comp_03,0)) / " + arg_unit + "),0 ) comp_03,  " + 
     "		  trunc(round((nvl(a.comp_04,0)) / " + arg_unit + "),0 ) comp_04,  " + 
     "		  trunc(round((nvl(a.comp_05,0)) / " + arg_unit + "),0 ) comp_05,  " + 
     "		  trunc(round((nvl(a.comp_06,0)) / " + arg_unit + "),0 ) comp_06,  " + 
     "		  trunc(round((nvl(a.comp_07,0)) / " + arg_unit + "),0 ) comp_07,  " + 
     "		  trunc(round((nvl(a.comp_08,0)) / " + arg_unit + "),0 ) comp_08,  " + 
     "		  trunc(round((nvl(a.comp_09,0)) / " + arg_unit + "),0 ) comp_09,  " + 
     "		  trunc(round((nvl(a.comp_10,0)) / " + arg_unit + "),0 ) comp_10,  " + 
     "		  trunc(round((nvl(a.comp_11,0)) / " + arg_unit + "),0 ) comp_11,  " + 
     "		  trunc(round((nvl(a.comp_12,0)) / " + arg_unit + "),0 ) comp_12,  " + 
     "		  trunc(round((nvl(a.comp_tot,0)) / " + arg_unit + "),0 ) comp_tot,  " + 
     "        trunc(round(((nvl(a.comp_tot,0)) + (nvl(a.ly_tot,0))) / " + arg_unit + "),0 ) tot_tot" + 
     " from (" + 
     " 	select max(a.dept_code) dept_code, " + 
     " 			max(a.long_name) long_name, " + 
     " 			sum(nvl(a.ly_tot,0))   - sum(nvl(a.ly_tot1,0))    ly_tot," + 
     " 			sum(nvl(a.comp_01,0))  - sum(nvl(a.comp_011,0))  comp_01," + 
     " 			sum(nvl(a.comp_02,0))  - sum(nvl(a.comp_021,0))  comp_02," + 
     " 			sum(nvl(a.comp_03,0))  - sum(nvl(a.comp_031,0))  comp_03," + 
     " 			sum(nvl(a.comp_04,0))  - sum(nvl(a.comp_041,0))  comp_04," + 
     " 			sum(nvl(a.comp_05,0))  - sum(nvl(a.comp_051,0))  comp_05," + 
     " 			sum(nvl(a.comp_06,0))  - sum(nvl(a.comp_061,0))  comp_06," + 
     " 			sum(nvl(a.comp_07,0))  - sum(nvl(a.comp_071,0))  comp_07," + 
     " 			sum(nvl(a.comp_08,0))  - sum(nvl(a.comp_081,0))  comp_08," + 
     " 			sum(nvl(a.comp_09,0))  - sum(nvl(a.comp_091,0))  comp_09," + 
     " 			sum(nvl(a.comp_10,0))  - sum(nvl(a.comp_101,0))  comp_10," + 
     " 			sum(nvl(a.comp_11,0))  - sum(nvl(a.comp_111,0))  comp_11," + 
     " 			sum(nvl(a.comp_12,0))  - sum(nvl(a.comp_121,0))  comp_12," + 
     " 			sum(nvl(a.comp_tot,0)) - sum(nvl(a.comp_tot1,0)) comp_tot," + 
     " 			sum(nvl(a.tot_tot,0))  - sum(nvl(a.tot_tot1,0))  tot_tot" + 
     " 	from (select max(a.dept_code) dept_code, " + 
     " 					 max(b.long_name) long_name, " + 
     " 					 AVG(nvl(d.amt,0))   ly_tot," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'01',nvl(a.result_amt,0),0),0)) comp_01," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'02',nvl(a.result_amt,0),0),0)) comp_02," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'03',nvl(a.result_amt,0),0),0)) comp_03," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'04',nvl(a.result_amt,0),0),0)) comp_04," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'05',nvl(a.result_amt,0),0),0)) comp_05," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'06',nvl(a.result_amt,0),0),0)) comp_06," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'07',nvl(a.result_amt,0),0),0)) comp_07," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'08',nvl(a.result_amt,0),0),0)) comp_08," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'09',nvl(a.result_amt,0),0),0)) comp_09," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'10',nvl(a.result_amt,0),0),0)) comp_10," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'11',nvl(a.result_amt,0),0),0)) comp_11," + 
     " 					 sum(nvl(decode(to_char(a.yymm,'MM'),'12',nvl(a.result_amt,0),0),0)) comp_12," + 
     " 					 sum(nvl(a.result_amt,0))   comp_tot," + 
     " 					 sum(nvl(a.result_amt,0)) + AVG(nvl(d.amt,0)) tot_tot," + 
     " 					 0 ly_tot1," + 
     " 					 0 comp_011," + 
     " 					 0 comp_021," + 
     " 					 0 comp_031," + 
     " 					 0 comp_041," + 
     " 					 0 comp_051," + 
     " 					 0 comp_061," + 
     " 					 0 comp_071," + 
     " 					 0 comp_081," + 
     " 					 0 comp_091," + 
     " 					 0 comp_101," + 
     " 					 0 comp_111," + 
     " 					 0 comp_121," + 
     " 					 0 comp_tot1," + 
     " 					 0 tot_tot1 " + 
     "  	 		  from c_spec_const_parent a," + 
     " 		  			 z_code_dept b," + 
     " 					 y_budget_parent c," + 
     " 					 ( select sum(nvl(a.result_amt,0)) amt,max(a.dept_code) dept_code " + 
     "      			      from c_spec_const_parent a," + 
     "      			           z_code_dept b," + 
     "      			           y_budget_parent c," + 
     "      			           c_spec_class_parent d, " +
	  "      			           c_spec_class_child e " +
     "      			     where to_char(a.yymm,'YYYY') < " + "'" + arg_year + "'" + 
     "      			       and c.dept_code  = a.dept_code (+)" + 
     " 						  and c.spec_no_seq = a.spec_no_seq (+)" + 
     "      			       and c.llevel = 1" + 
     "      			 	 	  and b.dept_code = c.dept_code (+)" + 
     "      			       and e.dept_code = b.dept_code " +
     "      			       and d.spec_no_seq = e.spec_no_seq " +
     "      			       and d.sum_code like " + "'" + arg_sum_code + "'" +
     " 					     and b.chg_const_start_date is not null" + 
     " 						  and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     " 						  and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     "      			    group by a.dept_code ) d," + 
     "      			   c_spec_class_parent e, " +
	  "      			   c_spec_class_child f " +
     " 			where to_char(a.yymm,'YYYY') = " + "'" + arg_year + "'" + 
     "   		   and a.dept_code = d.dept_code (+) " +
     "   		   and c.dept_code   = a.dept_code (+)" + 
     "   		   and c.spec_no_seq = a.spec_no_seq (+)" + 
     "   		   and c.llevel = 1" + 
     "   		   and b.dept_code = c.dept_code (+)" + 
     "   		   and f.dept_code = b.dept_code " +
     "   		   and e.spec_no_seq = f.spec_no_seq " +
     "   		   and e.sum_code like " + "'" + arg_sum_code + "'" +
     "   		   and b.chg_const_start_date is not null" + 
     "   		   and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "   		   and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     "   		group by a.dept_code  " +
     "  union all " +
     " 	select max(a.dept_code) dept_code, " + 
     " 			max(b.long_name) long_name, " + 
     " 			0 ly_tot," + 
     " 			0 comp_01," + 
     " 			0 comp_02," + 
     " 			0 comp_03," + 
     " 			0 comp_04," + 
     " 			0 comp_05," + 
     " 			0 comp_06," + 
     " 			0 comp_07," + 
     " 			0 comp_08," + 
     " 			0 comp_09," + 
     " 			0 comp_10," + 
     " 			0 comp_11," + 
     " 			0 comp_12," + 
     " 			0 comp_tot," + 
     " 			0 tot_tot," + 
     " 			AVG(nvl(d.amt,0))   ly_tot1," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'01',nvl(a.cost_amt,0),0),0)) comp_011," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'02',nvl(a.cost_amt,0),0),0)) comp_021," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'03',nvl(a.cost_amt,0),0),0)) comp_031," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'04',nvl(a.cost_amt,0),0),0)) comp_041," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'05',nvl(a.cost_amt,0),0),0)) comp_051," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'06',nvl(a.cost_amt,0),0),0)) comp_061," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'07',nvl(a.cost_amt,0),0),0)) comp_071," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'08',nvl(a.cost_amt,0),0),0)) comp_081," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'09',nvl(a.cost_amt,0),0),0)) comp_091," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'10',nvl(a.cost_amt,0),0),0)) comp_101," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'11',nvl(a.cost_amt,0),0),0)) comp_111," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'12',nvl(a.cost_amt,0),0),0)) comp_121," + 
     " 			sum(nvl(a.cost_amt,0))   comp_tot1," + 
     " 			sum(nvl(a.cost_amt,0)) + AVG(nvl(d.amt,0)) tot_tot1" + 
     " 	from c_spec_const_parent a," + 
     " 		  z_code_dept b," + 
     " 		  y_budget_parent c," + 
     " 		  ( select sum(nvl(a.cost_amt,0)) amt,max(a.dept_code) dept_code " + 
     "             from c_spec_const_parent a," + 
     "                  z_code_dept b," + 
     "                  y_budget_parent c," + 
     "                  c_spec_class_parent d, " +
	  "                  c_spec_class_child e " +
     "            where to_char(a.yymm,'YYYY') < " + "'" + arg_year + "'" + 
     "              and c.dept_code  = a.dept_code (+)" + 
     " 				  and c.spec_no_seq = a.spec_no_seq (+)" + 
     "              and c.llevel = 1" + 
     "        	 	  and b.dept_code = c.dept_code (+)" + 
     "              and e.dept_code = b.dept_code " +
     "              and d.spec_no_seq = e.spec_no_seq " +
     "              and d.sum_code like " + "'" + arg_sum_code + "'" +
     " 			     and b.chg_const_start_date is not null" + 
     " 				  and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     " 				  and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     "           group by a.dept_code ) d," + 
     "          c_spec_class_parent e, " +
	  "          c_spec_class_child f " +
     " 	where to_char(a.yymm,'YYYY') = " + "'" + arg_year + "'" + 
     "      and a.dept_code = d.dept_code (+) " +
     "      and c.dept_code   = a.dept_code (+)" + 
     "      and c.spec_no_seq = a.spec_no_seq (+)" + 
     "      and c.llevel = 1" + 
     "      and b.dept_code = c.dept_code (+)" + 
     "      and f.dept_code = b.dept_code " +
     "      and e.spec_no_seq = f.spec_no_seq " +
     "      and e.sum_code like " + "'" + arg_sum_code + "'" +
     "      and b.chg_const_start_date is not null" + 
     "      and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "      and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     "   group by a.dept_code ) a group by a.dept_code " +
     " ) a   order by a.dept_code asc  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>