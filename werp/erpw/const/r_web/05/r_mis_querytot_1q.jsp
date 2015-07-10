<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_unit = req.getParameter("arg_unit");
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("id",GauceDataColumn.TB_DECIMAL,3));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
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
	  "      	select 0 id, " + 
     "      			 '수주실적' name, " + 
     "                sum(nvl(a.ly_tot,0))  ly_tot, " + 
     "      			 sum(nvl(a.comp_01,0)) comp_01, " + 
     "      			 sum(nvl(a.comp_02,0)) comp_02, " + 
     "      			 sum(nvl(a.comp_03,0)) comp_03, " + 
     "      			 sum(nvl(a.comp_04,0)) comp_04, " + 
     "      			 sum(nvl(a.comp_05,0)) comp_05, " + 
     "      			 sum(nvl(a.comp_06,0)) comp_06, " + 
     "      			 sum(nvl(a.comp_07,0)) comp_07, " + 
     "      			 sum(nvl(a.comp_08,0)) comp_08, " + 
     "      			 sum(nvl(a.comp_09,0)) comp_09, " + 
     "      			 sum(nvl(a.comp_10,0)) comp_10, " + 
     "      			 sum(nvl(a.comp_11,0)) comp_11, " + 
     "      			 sum(nvl(a.comp_12,0)) comp_12, " + 
     "      			 sum(nvl(a.comp_tot,0)) comp_tot, " + 
     "      			 sum(nvl(a.comp_tot,0)) + sum(nvl(a.ly_tot,0)) tot_tot  " + 
     "      	from (select 0 ly_tot," + 
     "							 sum(nvl(decode(to_char(cont_date,'MM'),'01',nvl(a.tot_cont_amt,0),0),0)) comp_01, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'02',nvl(a.tot_cont_amt,0),0),0)) comp_02, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'03',nvl(a.tot_cont_amt,0),0),0)) comp_03, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'04',nvl(a.tot_cont_amt,0),0),0)) comp_04, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'05',nvl(a.tot_cont_amt,0),0),0)) comp_05, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'06',nvl(a.tot_cont_amt,0),0),0)) comp_06, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'07',nvl(a.tot_cont_amt,0),0),0)) comp_07, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'08',nvl(a.tot_cont_amt,0),0),0)) comp_08, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'09',nvl(a.tot_cont_amt,0),0),0)) comp_09, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'10',nvl(a.tot_cont_amt,0),0),0)) comp_10, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'11',nvl(a.tot_cont_amt,0),0),0)) comp_11, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'12',nvl(a.tot_cont_amt,0),0),0)) comp_12, " + 
     "      					 sum(nvl(a.tot_cont_amt,0)) comp_tot " + 
     "      			  from r_contract_register a, " + 
     "							 z_code_dept b" + 
     "      			 where to_char(a.cont_date,'YYYY') =  " + "'" + arg_year + "'" + 
     "      				and a.cont_no = 1 " + 
     "      				and a.chg_degree = 1 " + 
     "					   and b.dept_code = a.dept_code (+)" + 
     "						and b.chg_const_start_date is not null" + 
     "     				   and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "      				and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     "               union all" + 
     "      		  select  sum(nvl(a.tot_cont_amt,0)) ly_tot," + 
     "							 0 comp_01, " + 
     "      					 0 comp_02, " + 
     "      					 0 comp_03, " + 
     "      					 0 comp_04, " + 
     "      					 0 comp_05, " + 
     "      					 0 comp_06, " + 
     "      					 0 comp_07, " + 
     "      					 0 comp_08, " + 
     "      					 0 comp_09, " + 
     "      					 0 comp_10, " + 
     "      					 0 comp_11, " + 
     "      					 0 comp_12, " + 
     "      					 0 comp_tot " + 
     "      			  from r_contract_register  a," + 
     "							 z_code_dept b" + 
     "      			 where to_char(a.cont_date,'YYYY') <  " + "'" + arg_year + "'" + 
     "      				and cont_no = 1 " + 
     "      				and a.chg_degree = 1 " + 
     "					   and b.dept_code = a.dept_code (+)" + 
     "						and b.chg_const_start_date is not null" + 
     "     				   and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "      				and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     "      				) a      " +
     " union all " +
	  "      	select 1 id, " + 
     "      			 '계약실적' name, " + 
     "               sum(nvl(a.ly_tot,0))    ly_tot, " + 
     "      			 sum(nvl(a.comp_01,0)) comp_01, " + 
     "      			 sum(nvl(a.comp_02,0)) comp_02, " + 
     "      			 sum(nvl(a.comp_03,0)) comp_03, " + 
     "      			 sum(nvl(a.comp_04,0)) comp_04, " + 
     "      			 sum(nvl(a.comp_05,0)) comp_05, " + 
     "      			 sum(nvl(a.comp_06,0)) comp_06, " + 
     "      			 sum(nvl(a.comp_07,0)) comp_07, " + 
     "      			 sum(nvl(a.comp_08,0)) comp_08, " + 
     "      			 sum(nvl(a.comp_09,0)) comp_09, " + 
     "      			 sum(nvl(a.comp_10,0)) comp_10, " + 
     "      			 sum(nvl(a.comp_11,0)) comp_11, " + 
     "      			 sum(nvl(a.comp_12,0)) comp_12, " + 
     "      			 sum(nvl(a.comp_tot,0)) comp_tot, " + 
     "      			 sum(nvl(a.comp_tot,0)) + sum(nvl(a.ly_tot,0)) tot_tot  " + 
     "      	from (select 0 ly_tot," + 
     "							 (nvl(decode(to_char(a.cont_date,'MM'),'01',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_01, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'02',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_02, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'03',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_03, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'04',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_04, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'05',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_05, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'06',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_06, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'07',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_07, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'08',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_08, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'09',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_09, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'10',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_10, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'11',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_11, " + 
     "      					 (nvl(decode(to_char(a.cont_date,'MM'),'12',nvl(a.change_sum_amt - b.change_sum_amt,0),0),0)) comp_12, " + 
     "      					  nvl(a.change_sum_amt - b.change_sum_amt,0) comp_tot " + 
     "      			  from r_contract_register a, " + 
     "      					 r_contract_register b " + 
     "      			 where a.dept_code = b.dept_code " + 
     "      				and a.cont_no   = b.cont_no " + 
     "      				and b.chg_degree = a.chg_degree - 1 " + 
     "      				and to_char(a.cont_date,'YYYY') =  " + "'" + arg_year + "'" + 
     "      				and a.chg_degree > 1 " + 
     "      			union all " + 
     "      		  select  0 ly_tot," + 
     "							 sum(nvl(decode(to_char(cont_date,'MM'),'01',nvl(change_sum_amt,0),0),0)) comp_01, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'02',nvl(change_sum_amt,0),0),0)) comp_02, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'03',nvl(change_sum_amt,0),0),0)) comp_03, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'04',nvl(change_sum_amt,0),0),0)) comp_04, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'05',nvl(change_sum_amt,0),0),0)) comp_05, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'06',nvl(change_sum_amt,0),0),0)) comp_06, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'07',nvl(change_sum_amt,0),0),0)) comp_07, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'08',nvl(change_sum_amt,0),0),0)) comp_08, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'09',nvl(change_sum_amt,0),0),0)) comp_09, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'10',nvl(change_sum_amt,0),0),0)) comp_10, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'11',nvl(change_sum_amt,0),0),0)) comp_11, " + 
     "      					 sum(nvl(decode(to_char(cont_date,'MM'),'12',nvl(change_sum_amt,0),0),0)) comp_12, " + 
     "      					 sum(nvl(change_sum_amt,0)) comp_tot " + 
     "      			  from r_contract_register  " + 
     "      			 where to_char(cont_date,'YYYY') =  " + "'" + arg_year + "'" + 
     "      				and chg_degree = 1 " + 
     "               union all" + 
     "					select nvl(a.change_sum_amt - b.change_sum_amt,0) ly_tot," + 
     "							 0 comp_01, " + 
     "      					 0 comp_02, " + 
     "      					 0 comp_03, " + 
     "      					 0 comp_04, " + 
     "      					 0 comp_05, " + 
     "      					 0 comp_06, " + 
     "      					 0 comp_07, " + 
     "      					 0 comp_08, " + 
     "      					 0 comp_09, " + 
     "      					 0 comp_10, " + 
     "      					 0 comp_11, " + 
     "      					 0 comp_12, " + 
     "      					 0 comp_tot " + 
     "      			  from r_contract_register a, " + 
     "      					 r_contract_register b," + 
     "                      z_code_dept c " + 
     "      			 where a.dept_code = b.dept_code " + 
     "      				and a.cont_no   = b.cont_no " + 
     "      				and b.chg_degree = a.chg_degree - 1 " + 
     "      				and to_char(a.cont_date,'YYYY') <  " + "'" + arg_year + "'" + 
     "      				and a.chg_degree > 1 " + 
     "					   and c.dept_code = a.dept_code (+)" + 
     "						and c.chg_const_start_date is not null" + 
     "     				   and to_char(c.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "      				and to_char(c.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     "      			union all " + 
     "      		  select  sum(nvl(a.change_sum_amt,0)) ly_tot," + 
     "							 0 comp_01, " + 
     "      					 0 comp_02, " + 
     "      					 0 comp_03, " + 
     "      					 0 comp_04, " + 
     "      					 0 comp_05, " + 
     "      					 0 comp_06, " + 
     "      					 0 comp_07, " + 
     "      					 0 comp_08, " + 
     "      					 0 comp_09, " + 
     "      					 0 comp_10, " + 
     "      					 0 comp_11, " + 
     "      					 0 comp_12, " + 
     "      					 0 comp_tot " + 
     "      			  from r_contract_register  a," + 
     "							 z_code_dept b" + 
     "      			 where to_char(a.cont_date,'YYYY') <  " + "'" + arg_year + "'" + 
     "      				and a.chg_degree = 1 " + 
     "					   and b.dept_code = a.dept_code (+)" + 
     "						and b.chg_const_start_date is not null" + 
     "     				   and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "      				and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     "      				) a      " +
     " union all " +
     " 	select 2 id, " + 
     " 			'매출실적(A)' name, " + 
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
	  "  union all " +
     " 	select 3 id, " + 
     " 			'수금실적' name, " + 
     " 			AVG(nvl(c.amt,0))   ly_tot," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'01',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_01," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'02',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_02," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'03',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_03," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'04',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_04," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'05',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_05," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'06',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_06," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'07',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_07," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'08',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_08," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'09',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_09," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'10',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_10," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'11',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_11," + 
     " 			sum(nvl(decode(to_char(a.received_date,'MM'),'12',nvl(a.supply_amt,0) + nvl(a.vat_amt,0),0),0)) comp_12," + 
     " 			sum(nvl(a.supply_amt,0) + nvl(a.vat_amt,0)) comp_tot," + 
     " 			sum(nvl(a.supply_amt,0) + nvl(a.vat_amt,0)) + AVG(nvl(c.amt,0)) tot_tot" + 
     " 	from r_contract_time_collection a," + 
     " 		  z_code_dept b," + 
     " 		  ( select sum(nvl(a.supply_amt,0)) + sum(nvl(a.vat_amt,0)) amt" + 
     "             from r_contract_time_collection a," + 
     "                  z_code_dept b" + 
     "            where to_char(a.received_date,'YYYY') < " + "'" + arg_year + "'" + 
     "        	 	 and b.dept_code = a.dept_code (+)" + 
     " 			    and b.chg_const_start_date is not null" + 
     " 				 and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     " 				 and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + " ) c" + 
     " 	where to_char(a.received_date,'YYYY') = " + "'" + arg_year + "'" + 
     "      and b.dept_code = a.dept_code (+)" + 
     "      and b.chg_const_start_date is not null" + 
     "      and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "      and to_char(b.chg_const_end_date,'YYYY') >= " + "'" + arg_year + "'" + 
     " union all " +
     "  select max(a.id) id," + 
     "       max(a.name) name," + 
     "       sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)) ly_tot," + 
     "       sum(nvl(a.rsq_01,0)) - sum(nvl(a.rev_01,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_01," + 
     "       sum(nvl(a.rsq_02,0)) - sum(nvl(a.rev_02,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_02," + 
     "       sum(nvl(a.rsq_03,0)) - sum(nvl(a.rev_03,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_03," + 
     "       sum(nvl(a.rsq_04,0)) - sum(nvl(a.rev_04,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_04," + 
     "       sum(nvl(a.rsq_05,0)) - sum(nvl(a.rev_05,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_05," + 
     "       sum(nvl(a.rsq_06,0)) - sum(nvl(a.rev_06,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_06," + 
     "       sum(nvl(a.rsq_07,0)) - sum(nvl(a.rev_07,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_07," + 
     "       sum(nvl(a.rsq_08,0)) - sum(nvl(a.rev_08,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_08," + 
     "       sum(nvl(a.rsq_09,0)) - sum(nvl(a.rev_09,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_09," + 
     "       sum(nvl(a.rsq_10,0)) - sum(nvl(a.rev_10,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_10," + 
     "       sum(nvl(a.rsq_11,0)) - sum(nvl(a.rev_11,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_11," + 
     "       sum(nvl(a.rsq_12,0)) - sum(nvl(a.rev_12,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0)))  comp_12," + 
     "       sum(nvl(a.rsq_tot,0)) - sum(nvl(a.rev_tot,0))                                                        comp_tot," + 
     "       sum(nvl(a.rsq_tot,0)) - sum(nvl(a.rev_tot,0)) + (sum(nvl(a.ly_rsq_tot,0)) - sum(nvl(a.ly_rev_tot,0))) tot_tot" + 
     "  from (" + 
     "      select 4 id,  " + 
     "       		'미수금' name,  " + 
     "       		AVG(nvl(d.amt,0))   ly_rsq_tot, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '01'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_01, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '02'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_02, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '03'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_03, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '04'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_04, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '05'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_05, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '06'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_06, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '07'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_07, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '08'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_08, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '09'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_09, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '10'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_10, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '11'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_11, " + 
     "       		sum(nvl(decode(sign(to_char(a.issue_date,'MM') - '12'),1,0,nvl(a.supply_amt,0) + nvl(a.vat_amt,0)),0)) rsq_12, " + 
     "       		sum(nvl(a.supply_amt,0) + nvl(a.vat_amt,0))  rsq_tot," + 
     "       		0 ly_rev_tot," + 
     "       		0 rev_01," + 
     "       		0 rev_02," + 
     "       		0 rev_03," + 
     "       		0 rev_04," + 
     "       		0 rev_05," + 
     "       		0 rev_06," + 
     "       		0 rev_07," + 
     "       		0 rev_08," + 
     "       		0 rev_09," + 
     "       		0 rev_10," + 
     "       		0 rev_11," + 
     "       		0 rev_12," + 
     "       		0 rev_tot" + 
     "       from r_contract_time_extablished a, " + 
     "       	   z_code_dept b,                " + 
     "       	  ( select sum(nvl(a.supply_amt,0)) + sum(nvl(a.vat_amt,0)) amt" + 
     "       			  from r_contract_time_extablished a, " + 
     "       					 z_code_dept c " + 
     "       			 where to_char(a.issue_date,'YYYY') <  " + "'" + arg_year + "'" + 
     "       			 and c.dept_code = a.dept_code (+) " + 
     "       			 and c.chg_const_start_date is not null " + 
     "       			 and to_char(c.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "       			 and to_char(c.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + "  ) d " + 
     "       where  to_char(a.issue_date,'YYYY') =  " + "'" + arg_year + "'" + 
     "       	 and b.dept_code = a.dept_code (+) " + 
     "       	 and b.chg_const_start_date is not null " + 
     "       	 and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "       	 and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + 
     "     union all" + 
     "      select 4 id,  " + 
     "       		'미수금' name,  " + 
     "       		0 ly_rsq_tot," + 
     "       		0 rsq_01," + 
     "       		0 rsq_02," + 
     "       		0 rsq_03," + 
     "       		0 rsq_04," + 
     "       		0 rsq_05," + 
     "       		0 rsq_06," + 
     "       		0 rsq_07," + 
     "       		0 rsq_08," + 
     "       		0 rsq_09," + 
     "       		0 rsq_10," + 
     "       		0 rsq_11," + 
     "       		0 rsq_12," + 
     "       		0 rsq_tot," + 
     "       		AVG(nvl(d.amt,0))   ly_rev_tot, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '01'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_01, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '02'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_02, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '03'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_03, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '04'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_04, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '05'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_05, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '06'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_06, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '07'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_07, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '08'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_08, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '09'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_09, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '10'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_10, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '11'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_11, " + 
     "       		sum(nvl(decode(sign(to_char(c.received_date,'MM') - '12'),1,0,nvl(c.supply_amt,0) + nvl(c.vat_amt,0)),0)) rev_12, " + 
     "       		sum(nvl(c.supply_amt,0) + nvl(c.vat_amt,0))  rev_tot" + 
     "       from z_code_dept b," + 
     "				r_contract_time_collection c," + 
     "       	  ( select sum(nvl(a.supply_amt,0)) + sum(nvl(a.vat_amt,0)) amt" + 
     "       			  from r_contract_time_collection a, " + 
     "       					 z_code_dept c " + 
     "       			 where to_char(a.received_date,'YYYY') <  " + "'" + arg_year + "'" + 
     "       			 and c.dept_code = a.dept_code (+) " + 
     "       			 and c.chg_const_start_date is not null " + 
     "       			 and to_char(c.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "       			 and to_char(c.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + "  ) d " + 
     "       where  b.dept_code = c.dept_code (+)" + 
     "			 and to_char(c.received_date,'YYYY') = " + "'" + arg_year + "'" + 
     "          and b.chg_const_start_date is not null " + 
     "       	 and to_char(b.chg_const_start_date,'YYYY') <= " + "'" + arg_year + "'" + 
     "       	 and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + 
     "         ) a     " +
     "  union all " +
     "      	select 5 id,  " + 
     "      			'실행기성(B)' name,  " + 
     "      			AVG(nvl(d.amt,0))   ly_tot, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'01',nvl(a.result_amt,0),0),0)) comp_01, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'02',nvl(a.result_amt,0),0),0)) comp_02, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'03',nvl(a.result_amt,0),0),0)) comp_03, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'04',nvl(a.result_amt,0),0),0)) comp_04, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'05',nvl(a.result_amt,0),0),0)) comp_05, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'06',nvl(a.result_amt,0),0),0)) comp_06, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'07',nvl(a.result_amt,0),0),0)) comp_07, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'08',nvl(a.result_amt,0),0),0)) comp_08, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'09',nvl(a.result_amt,0),0),0)) comp_09, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'10',nvl(a.result_amt,0),0),0)) comp_10, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'11',nvl(a.result_amt,0),0),0)) comp_11, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'12',nvl(a.result_amt,0),0),0)) comp_12, " + 
     "      			sum(nvl(a.result_amt,0))   comp_tot, " + 
     "      			sum(nvl(a.result_amt,0)) + AVG(nvl(d.amt,0)) tot_tot " + 
     "      	from c_spec_const_parent a, " + 
     "      		  z_code_dept b, " + 
     "      		  y_budget_parent c, " + 
     "      		  ( select sum(nvl(a.result_amt,0)) amt " + 
     "                  from c_spec_const_parent a, " + 
     "                       z_code_dept b, " + 
     "                       y_budget_parent c " + 
     "                 where to_char(a.yymm,'YYYY') <  " + "'" + arg_year + "'" + 
     "                   and c.dept_code  = a.dept_code (+) " + 
     "      				 and c.spec_no_seq = a.spec_no_seq (+) " + 
     "                   and c.llevel = 1 " + 
     "             	 	 and b.dept_code = c.dept_code (+) " + 
     "      			    and b.chg_const_start_date is not null " + 
     "      				 and to_char(b.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "      				 and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + "  ) d " + 
     "      	where to_char(a.yymm,'YYYY') =  " + "'" + arg_year + "'" + 
     "           and c.dept_code   = a.dept_code (+) " + 
     "           and c.spec_no_seq = a.spec_no_seq (+) " + 
     "           and c.llevel = 1 " + 
     "           and b.dept_code = c.dept_code (+) " + 
     "           and b.chg_const_start_date is not null " + 
     "           and to_char(b.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "           and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + 
     "      	union all " + 
     "      	select 6 id,  " + 
     "      			'공사원가(C)' name,  " + 
     "      			AVG(nvl(d.amt,0))   ly_tot, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'01',nvl(a.cost_amt,0),0),0)) comp_01, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'02',nvl(a.cost_amt,0),0),0)) comp_02, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'03',nvl(a.cost_amt,0),0),0)) comp_03, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'04',nvl(a.cost_amt,0),0),0)) comp_04, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'05',nvl(a.cost_amt,0),0),0)) comp_05, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'06',nvl(a.cost_amt,0),0),0)) comp_06, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'07',nvl(a.cost_amt,0),0),0)) comp_07, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'08',nvl(a.cost_amt,0),0),0)) comp_08, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'09',nvl(a.cost_amt,0),0),0)) comp_09, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'10',nvl(a.cost_amt,0),0),0)) comp_10, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'11',nvl(a.cost_amt,0),0),0)) comp_11, " + 
     "      			sum(nvl(decode(to_char(a.yymm,'MM'),'12',nvl(a.cost_amt,0),0),0)) comp_12, " + 
     "      			sum(nvl(a.cost_amt,0))   comp_tot, " + 
     "      			sum(nvl(a.cost_amt,0)) + AVG(nvl(d.amt,0)) tot_tot " + 
     "      	from c_spec_const_parent a, " + 
     "      		  z_code_dept b, " + 
     "      		  y_budget_parent c, " + 
     "      		  ( select sum(nvl(a.cost_amt,0)) amt " + 
     "                  from c_spec_const_parent a, " + 
     "                       z_code_dept b, " + 
     "                       y_budget_parent c " + 
     "                 where to_char(a.yymm,'YYYY') <  " + "'" + arg_year + "'" + 
     "                   and c.dept_code  = a.dept_code (+) " + 
     "      				 and c.spec_no_seq = a.spec_no_seq (+) " + 
     "                   and c.llevel = 1 " + 
     "             	 	 and b.dept_code = c.dept_code (+) " + 
     "      			    and b.chg_const_start_date is not null " + 
     "      				 and to_char(b.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "      				 and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + " ) d " + 
     "      	where to_char(a.yymm,'YYYY') =  " + "'" + arg_year + "'" + 
     "           and c.dept_code   = a.dept_code (+) " + 
     "           and c.spec_no_seq = a.spec_no_seq (+) " + 
     "           and c.llevel = 1 " + 
     "           and b.dept_code = c.dept_code (+) " + 
     "           and b.chg_const_start_date is not null " + 
     "           and to_char(b.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "           and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'"  +
     " ) a   order by a.id asc  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>