<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_unit = req.getParameter("arg_unit");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("id",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,8));
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
    String query = "select a.id," + 
     " 		 a.name," + 
     " 		 to_char(trunc(round(a.comp_01 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_01," + 
     " 		 to_char(trunc(round(a.comp_02 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_02," + 
     " 		 to_char(trunc(round(a.comp_03 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_03," + 
     " 		 to_char(trunc(round(a.comp_04 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_04," + 
     " 		 to_char(trunc(round(a.comp_05 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_05," + 
     " 		 to_char(trunc(round(a.comp_06 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_06," + 
     " 		 to_char(trunc(round(a.comp_07 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_07," + 
     " 		 to_char(trunc(round(a.comp_08 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_08," + 
     " 		 to_char(trunc(round(a.comp_09 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_09," + 
     " 		 to_char(trunc(round(a.comp_10 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_10," + 
     " 		 to_char(trunc(round(a.comp_11 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_11," + 
     " 		 to_char(trunc(round(a.comp_12 / " + arg_unit + "),0 ),'9,999,999,999,999') cp_12," + 
     " 		 to_char(trunc(round(a.comp_tot / " + arg_unit + "),0 ),'9,999,999,999,999') cp_tot," + 
     " 		 trunc(round(nvl(a.comp_01,0) / " + arg_unit + "),0 ) comp_01 ," + 
     " 		 trunc(round(nvl(a.comp_02,0) / " + arg_unit + "),0 ) comp_02 ," + 
     " 		 trunc(round(nvl(a.comp_03,0) / " + arg_unit + "),0 ) comp_03 ," + 
     " 		 trunc(round(nvl(a.comp_04,0) / " + arg_unit + "),0 ) comp_04 ," + 
     " 		 trunc(round(nvl(a.comp_05,0) / " + arg_unit + "),0 ) comp_05 ," + 
     " 		 trunc(round(nvl(a.comp_06,0) / " + arg_unit + "),0 ) comp_06 ," + 
     " 		 trunc(round(nvl(a.comp_07,0) / " + arg_unit + "),0 ) comp_07 ," + 
     " 		 trunc(round(nvl(a.comp_08,0) / " + arg_unit + "),0 ) comp_08 ," + 
     " 		 trunc(round(nvl(a.comp_09,0) / " + arg_unit + "),0 ) comp_09 ," + 
     " 		 trunc(round(nvl(a.comp_10,0) / " + arg_unit + "),0 ) comp_10 ," + 
     " 		 trunc(round(nvl(a.comp_11,0) / " + arg_unit + "),0 ) comp_11 ," + 
     " 		 trunc(round(nvl(a.comp_12,0) / " + arg_unit + "),0 ) comp_12 ," + 
     " 		 trunc(round(nvl(a.comp_tot,0) / " + arg_unit + "),0 ) comp_tot" + 
     " from (" + 
     " 	select '1' id, " + 
     " 			'수주계획' name, " + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'01',nvl(received_plan_amt,0),0),0)) comp_01," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'02',nvl(received_plan_amt,0),0),0)) comp_02," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'03',nvl(received_plan_amt,0),0),0)) comp_03," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'04',nvl(received_plan_amt,0),0),0)) comp_04," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'05',nvl(received_plan_amt,0),0),0)) comp_05," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'06',nvl(received_plan_amt,0),0),0)) comp_06," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'07',nvl(received_plan_amt,0),0),0)) comp_07," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'08',nvl(received_plan_amt,0),0),0)) comp_08," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'09',nvl(received_plan_amt,0),0),0)) comp_09," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'10',nvl(received_plan_amt,0),0),0)) comp_10," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'11',nvl(received_plan_amt,0),0),0)) comp_11," + 
     " 			sum(nvl(decode(to_char(received_plan_year,'MM'),'12',nvl(received_plan_amt,0),0),0)) comp_12," + 
     " 			sum(nvl(received_plan_amt,0)) comp_tot" + 
     " 	from r_received_year_plan" + 
     " 	where to_char(received_plan_year,'YYYY') = " + "'" + arg_year + "'" + 
     " 	union all" + 
     " 	select '2' id," + 
     " 			 '수주실적' name," + 
     " 			 sum(a.comp_01)," + 
     " 			 sum(a.comp_02)," + 
     " 			 sum(a.comp_03)," + 
     " 			 sum(a.comp_04)," + 
     " 			 sum(a.comp_05)," + 
     " 			 sum(a.comp_06)," + 
     " 			 sum(a.comp_07)," + 
     " 			 sum(a.comp_08)," + 
     " 			 sum(a.comp_09)," + 
     " 			 sum(a.comp_10)," + 
     " 			 sum(a.comp_11)," + 
     " 			 sum(a.comp_12)," + 
     " 			 sum(a.comp_tot)" + 
     " 	from (select sum(nvl(decode(to_char(cont_date,'MM'),'01',nvl(tot_cont_amt,0),0),0)) comp_01," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'02',nvl(tot_cont_amt,0),0),0)) comp_02," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'03',nvl(tot_cont_amt,0),0),0)) comp_03," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'04',nvl(tot_cont_amt,0),0),0)) comp_04," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'05',nvl(tot_cont_amt,0),0),0)) comp_05," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'06',nvl(tot_cont_amt,0),0),0)) comp_06," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'07',nvl(tot_cont_amt,0),0),0)) comp_07," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'08',nvl(tot_cont_amt,0),0),0)) comp_08," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'09',nvl(tot_cont_amt,0),0),0)) comp_09," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'10',nvl(tot_cont_amt,0),0),0)) comp_10," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'11',nvl(tot_cont_amt,0),0),0)) comp_11," + 
     " 					 sum(nvl(decode(to_char(cont_date,'MM'),'12',nvl(tot_cont_amt,0),0),0)) comp_12," + 
     " 					 sum(nvl(tot_cont_amt,0)) comp_tot" + 
     " 			  from r_contract_register " + 
     " 			 where to_char(cont_date,'YYYY') = " + "'" + arg_year + "'" + 
     "            and cont_no = 1 " +
     " 				and chg_degree = 1 ) a" + 
     " ) a    order by a.id asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>