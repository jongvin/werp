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
    String query = " select  max(a.dept_code) dept_code,  " + 
     "		  max(a.long_name) long_name," + 
     "		  trunc(round(sum(nvl(a.ly_tot,0)) / " + arg_unit + "),0 )   ly_tot,  " + 
     "		  trunc(round(sum(nvl(a.comp_01,0)) / " + arg_unit + "),0 ) comp_01,  " + 
     "		  trunc(round(sum(nvl(a.comp_02,0)) / " + arg_unit + "),0 ) comp_02,  " + 
     "		  trunc(round(sum(nvl(a.comp_03,0)) / " + arg_unit + "),0 ) comp_03,  " + 
     "		  trunc(round(sum(nvl(a.comp_04,0)) / " + arg_unit + "),0 ) comp_04,  " + 
     "		  trunc(round(sum(nvl(a.comp_05,0)) / " + arg_unit + "),0 ) comp_05,  " + 
     "		  trunc(round(sum(nvl(a.comp_06,0)) / " + arg_unit + "),0 ) comp_06,  " + 
     "		  trunc(round(sum(nvl(a.comp_07,0)) / " + arg_unit + "),0 ) comp_07,  " + 
     "		  trunc(round(sum(nvl(a.comp_08,0)) / " + arg_unit + "),0 ) comp_08,  " + 
     "		  trunc(round(sum(nvl(a.comp_09,0)) / " + arg_unit + "),0 ) comp_09,  " + 
     "		  trunc(round(sum(nvl(a.comp_10,0)) / " + arg_unit + "),0 ) comp_10,  " + 
     "		  trunc(round(sum(nvl(a.comp_11,0)) / " + arg_unit + "),0 ) comp_11,  " + 
     "		  trunc(round(sum(nvl(a.comp_12,0)) / " + arg_unit + "),0 ) comp_12,  " + 
     "		  trunc(round(sum(nvl(a.comp_tot,0)) / " + arg_unit + "),0 ) comp_tot,  " + 
     "        trunc(round((sum(nvl(a.comp_tot,0)) + sum(nvl(a.ly_tot,0))) / " + arg_unit + "),0 ) tot_tot" + 
     "  from (select max(a.dept_code) dept_code," + 
     "					max(c.long_name) long_name," + 
     "					0 ly_tot, " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'01',nvl(a.tot_cont_amt,0),0),0)) comp_01,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'02',nvl(a.tot_cont_amt,0),0),0)) comp_02,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'03',nvl(a.tot_cont_amt,0),0),0)) comp_03,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'04',nvl(a.tot_cont_amt,0),0),0)) comp_04,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'05',nvl(a.tot_cont_amt,0),0),0)) comp_05,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'06',nvl(a.tot_cont_amt,0),0),0)) comp_06,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'07',nvl(a.tot_cont_amt,0),0),0)) comp_07,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'08',nvl(a.tot_cont_amt,0),0),0)) comp_08,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'09',nvl(a.tot_cont_amt,0),0),0)) comp_09,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'10',nvl(a.tot_cont_amt,0),0),0)) comp_10,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'11',nvl(a.tot_cont_amt,0),0),0)) comp_11,  " + 
     "					sum(nvl(decode(to_char(a.cont_date,'MM'),'12',nvl(a.tot_cont_amt,0),0),0)) comp_12,  " + 
     "					sum(nvl(a.tot_cont_amt,0)) comp_tot  " + 
     "			 from r_contract_register   a," + 
     "					z_code_dept c,  " + 
     "               c_spec_class_parent d, " +
	  "               c_spec_class_child e " +
     "			where to_char(a.cont_date,'YYYY') =  " + "'" + arg_year + "'" + 
     "			  and a.cont_no = 1  " + 
     "			  and a.chg_degree = 1  " + 
     "			  and e.dept_code = a.dept_code (+) " + 
     "			  and c.dept_code = e.dept_code " + 
     "           and d.spec_no_seq = e.spec_no_seq " +
     "           and d.sum_code like " + "'" + arg_sum_code + "'" +
     "			  and c.chg_const_start_date is not null " + 
     "			  and to_char(c.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "			  and to_char(c.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + 
     "		group by a.dept_code" + 
     "		union all  " + 
     "		 select  max(a.dept_code) dept_code," + 
     "					max(b.long_name) long_name," + 
     "					sum(nvl(a.tot_cont_amt,0)) ly_tot, " + 
     "					0 comp_01,  " + 
     "					0 comp_02,  " + 
     "					0 comp_03,  " + 
     "					0 comp_04,  " + 
     "					0 comp_05,  " + 
     "					0 comp_06,  " + 
     "					0 comp_07,  " + 
     "					0 comp_08,  " + 
     "					0 comp_09,  " + 
     "					0 comp_10,  " + 
     "					0 comp_11,  " + 
     "					0 comp_12,  " + 
     "					0 comp_tot  " + 
     "			 from r_contract_register  a, " + 
     "					z_code_dept b, " + 
     "               c_spec_class_parent d, " +
	  "               c_spec_class_child e " +
     "			where to_char(a.cont_date,'YYYY') <   " + "'" + arg_year + "'" + 
     "			  and a.cont_no = 1  " + 
     "			  and a.chg_degree = 1  " + 
     "			  and e.dept_code = a.dept_code (+) " + 
     "			  and b.dept_code = e.dept_code  " + 
     "           and d.spec_no_seq = e.spec_no_seq " +
     "           and d.sum_code like " + "'" + arg_sum_code + "'" +
     "			  and b.chg_const_start_date is not null " + 
     "			  and to_char(b.chg_const_start_date,'YYYY') <=  " + "'" + arg_year + "'" + 
     "			  and to_char(b.chg_const_end_date,'YYYY') >=  " + "'" + arg_year + "'" + 
     "		group by a.dept_code" + 
     " ) a      " + 
     " group by a.dept_code" + 
     " order by a.dept_code asc     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>