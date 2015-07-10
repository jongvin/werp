<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_unit = req.getParameter("arg_unit");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("id",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("lyp_tot",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_01",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_02",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_03",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_04",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_05",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_06",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_07",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_08",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_09",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_10",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_11",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_12",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cp_tot",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tp_tot",GauceDataColumn.TB_STRING,18));
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
    String query = "select a.id," + 
     " 		 a.name," + 
     "  		 to_char(trunc(round(a.ly_tot / " + arg_unit + "),0 ),'9,999,999,999,999') lyp_tot," + 
     "  		 to_char(trunc(round(a.comp_01 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_01," + 
     "  		 to_char(trunc(round(a.comp_02 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_02," + 
     "  		 to_char(trunc(round(a.comp_03 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_03," + 
     "  		 to_char(trunc(round(a.comp_04 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_04," + 
     "  		 to_char(trunc(round(a.comp_05 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_05," + 
     "  		 to_char(trunc(round(a.comp_06 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_06," + 
     "  		 to_char(trunc(round(a.comp_07 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_07," + 
     "  		 to_char(trunc(round(a.comp_08 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_08," + 
     "  		 to_char(trunc(round(a.comp_09 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_09," + 
     "  		 to_char(trunc(round(a.comp_10 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_10," + 
     "  		 to_char(trunc(round(a.comp_11 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_11," + 
     "  		 to_char(trunc(round(a.comp_12 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_12," + 
     "  		 to_char(trunc(round(a.comp_tot / " + arg_unit + "),0 ),'9,999,999,999,999') cp_tot," + 
     "  		 to_char(trunc(round(a.tot_tot / " + arg_unit + "),0 ),'9,999,999,999,999') tp_tot," + 
     "  		 trunc(round(nvl(a.ly_tot,0) / " + arg_unit + "),0 ) ly_tot ," + 
     "  		 trunc(round(nvl(a.comp_01,0) / " + arg_unit + "),0 ) comp_01 ," + 
     "  		 trunc(round(nvl(a.comp_02,0) / " + arg_unit + "),0 ) comp_02 ," + 
     "  		 trunc(round(nvl(a.comp_03,0) / " + arg_unit + "),0 ) comp_03 ," + 
     "  		 trunc(round(nvl(a.comp_04,0) / " + arg_unit + "),0 ) comp_04 ," + 
     "  		 trunc(round(nvl(a.comp_05,0) / " + arg_unit + "),0 ) comp_05 ," + 
     "  		 trunc(round(nvl(a.comp_06,0) / " + arg_unit + "),0 ) comp_06 ," + 
     "  		 trunc(round(nvl(a.comp_07,0) / " + arg_unit + "),0 ) comp_07 ," + 
     "  		 trunc(round(nvl(a.comp_08,0) / " + arg_unit + "),0 ) comp_08 ," + 
     "  		 trunc(round(nvl(a.comp_09,0) / " + arg_unit + "),0 ) comp_09 ," + 
     "  		 trunc(round(nvl(a.comp_10,0) / " + arg_unit + "),0 ) comp_10 ," + 
     "  		 trunc(round(nvl(a.comp_11,0) / " + arg_unit + "),0 ) comp_11 ," + 
     "  		 trunc(round(nvl(a.comp_12,0) / " + arg_unit + "),0 ) comp_12 ," + 
     "  		 trunc(round(nvl(a.comp_tot,0) / " + arg_unit + "),0 ) comp_tot," + 
     "  		 trunc(round(nvl(a.tot_tot,0) / " + arg_unit + "),0 ) tot_tot" + 
     " from (" + 
     " 	select '1' id, " + 
     " 			'매출계획' name, " + 
     " 			AVG(nvl(c.amt,0))   ly_tot," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'01',nvl(a.cnt_plan_amt,0),0),0)) comp_01," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'02',nvl(a.cnt_plan_amt,0),0),0)) comp_02," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'03',nvl(a.cnt_plan_amt,0),0),0)) comp_03," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'04',nvl(a.cnt_plan_amt,0),0),0)) comp_04," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'05',nvl(a.cnt_plan_amt,0),0),0)) comp_05," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'06',nvl(a.cnt_plan_amt,0),0),0)) comp_06," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'07',nvl(a.cnt_plan_amt,0),0),0)) comp_07," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'08',nvl(a.cnt_plan_amt,0),0),0)) comp_08," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'09',nvl(a.cnt_plan_amt,0),0),0)) comp_09," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'10',nvl(a.cnt_plan_amt,0),0),0)) comp_10," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'11',nvl(a.cnt_plan_amt,0),0),0)) comp_11," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'12',nvl(a.cnt_plan_amt,0),0),0)) comp_12," + 
     " 			sum(nvl(a.cnt_plan_amt,0))   comp_tot," + 
     " 			sum(nvl(a.cnt_plan_amt,0)) + AVG(nvl(c.amt,0)) tot_tot" + 
     " 	from c_spec_sum_code_plan a," + 
     " 		  z_code_dept b," + 
     " 		  ( select sum(nvl(a.cnt_result_amt,0)) amt" + 
     "             from c_spec_const_parent a," + 
     "                  z_code_dept b," + 
     "                  y_budget_parent c" + 
     "            where to_char(a.yymm,'YYYY') < " + "'" + arg_year + "'" + 
     "              and c.dept_code  = a.dept_code (+)" + 
     " 				 and c.spec_no_seq = a.spec_no_seq (+)" + 
     "              and c.llevel = 1" + 
     "        	 	 and b.dept_code = c.dept_code (+)" + 
     " 			    and b.chg_const_start_date is not null" + 
     " 				 and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     " 				 and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + " ) c" + 
     " 	where to_char(a.yymm,'YYYY') = " + "'" + arg_year + "'" + 
     "      and b.dept_code = a.dept_code (+)" + 
     "      and b.chg_const_start_date is not null" + 
     "      and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "      and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     " 	union all" + 
     " 	select '2' id, " + 
     " 			'매출실적' name, " + 
     " 			AVG(nvl(d.amt,0))   ly_tot," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'01',nvl(a.cnt_result_amt,0),0),0)) comp_01," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'02',nvl(a.cnt_result_amt,0),0),0)) comp_02," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'03',nvl(a.cnt_result_amt,0),0),0)) comp_03," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'04',nvl(a.cnt_result_amt,0),0),0)) comp_04," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'05',nvl(a.cnt_result_amt,0),0),0)) comp_05," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'06',nvl(a.cnt_result_amt,0),0),0)) comp_06," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'07',nvl(a.cnt_result_amt,0),0),0)) comp_07," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'08',nvl(a.cnt_result_amt,0),0),0)) comp_08," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'09',nvl(a.cnt_result_amt,0),0),0)) comp_09," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'10',nvl(a.cnt_result_amt,0),0),0)) comp_10," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'11',nvl(a.cnt_result_amt,0),0),0)) comp_11," + 
     " 			sum(nvl(decode(to_char(a.yymm,'MM'),'12',nvl(a.cnt_result_amt,0),0),0)) comp_12," + 
     " 			sum(nvl(a.cnt_result_amt,0))   comp_tot," + 
     " 			sum(nvl(a.cnt_result_amt,0)) + AVG(nvl(d.amt,0)) tot_tot" + 
     " 	from c_spec_const_parent a," + 
     " 		  z_code_dept b," + 
     " 		  y_budget_parent c," + 
     " 		  ( select sum(nvl(a.cnt_result_amt,0)) amt" + 
     "             from c_spec_const_parent a," + 
     "                  z_code_dept b," + 
     "                  y_budget_parent c" + 
     "            where to_char(a.yymm,'YYYY') < " + "'" + arg_year + "'" + 
     "              and c.dept_code  = a.dept_code (+)" + 
     " 				 and c.spec_no_seq = a.spec_no_seq (+)" + 
     "              and c.llevel = 1" + 
     "        	 	 and b.dept_code = c.dept_code (+)" + 
     " 			    and b.chg_const_start_date is not null" + 
     " 				 and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     " 				 and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + " ) d" + 
     " 	where to_char(a.yymm,'YYYY') = " + "'" + arg_year + "'" + 
     "      and c.dept_code   = a.dept_code (+)" + 
     "      and c.spec_no_seq = a.spec_no_seq (+)" + 
     "      and c.llevel = 1" + 
     "      and b.dept_code = c.dept_code (+)" + 
     "      and b.chg_const_start_date is not null" + 
     "      and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "      and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     " ) a     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>