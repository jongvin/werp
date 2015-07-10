<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yyyy = req.getParameter("arg_yyyy");
      
 //---------------------------------------------------------- 
 	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	  dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("jan_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("feb_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("mar_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("apr_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("may_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("jun_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("jul_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("aug_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("sep_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("oct_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("nov_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("dece_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("res_tot_cost",GauceDataColumn.TB_DECIMAL,13,0));
	  
	  String query ="select a.dept_code,																					" +
	   "                    (select long_name from z_code_dept where dept_code=a.dept_code) long_name, " +
      "							decode(to_char(a.res_comp_date, 'mm'), '01', sum(a.res_cost), 0) jan_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '02', sum(a.res_cost), 0) feb_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '03', sum(a.res_cost), 0) mar_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '04', sum(a.res_cost), 0) apr_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '05', sum(a.res_cost), 0) may_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '06', sum(a.res_cost), 0) jun_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '07', sum(a.res_cost), 0) jul_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '08', sum(a.res_cost), 0) aug_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '09', sum(a.res_cost), 0) sep_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '10', sum(a.res_cost), 0) oct_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '11', sum(a.res_cost), 0) nov_cost,	" +
		"	 						decode(to_char(a.res_comp_date, 'mm'), '12', sum(a.res_cost), 0) dece_cost,	" +
      " 							nvl(sum(a.res_cost), 0) res_tot_cost													" +
		"					 from a_as_req_master a																			" +
 		"					where a.prog_st = '3' and																			" +
      " 							to_char(a.res_comp_date, 'yyyy') = " + arg_yyyy + "								" +
		"				group by a.dept_code, to_char(a.res_comp_date, 'mm')											" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>	  