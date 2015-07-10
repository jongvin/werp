<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,6,2));
     dSet.addDataColumn(new GauceDataColumn("opt_name",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("opt_base",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("opt_finish",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("opt_ref",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("old_pyong",GauceDataColumn.TB_DECIMAL,6,3));
     dSet.addDataColumn(new GauceDataColumn("old_opt_name",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("old_opt_base",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("old_opt_finish",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("old_opt_ref",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("amt_norm",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("amt_norm_vat",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("amt_prem",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("amt_prem_vat",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       pyong,   " + 
     "                       opt_name,   " + 
	 "                       opt_base,   " + 
	 "                       opt_finish,   " + 
	 "                       opt_ref,   " + 
	 "                       pyong old_pyong,   " + 
     "                       opt_name old_opt_name,   " + 
	 "                       opt_base old_opt_base,   " + 
	 "                       opt_finish old_opt_finish,   " + 
	 "                       opt_ref old_opt_ref,   " + 
     "                       amt_norm   ,   " + 
	 "                       amt_norm_vat   ,   " + 
	 "                       amt_prem   ,   " + 
	 "                       amt_prem_vat,   " + 
	 "                       note   " + 
     "                  FROM H_BASE_ONTIME_ITEM  " + 
     "                 WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "              ORDER BY pyong asc,     " + 
     "                       opt_name  ASC,        " +
	 "                       opt_base  ASC,        " +
	 "                       opt_finish  ASC,        " +
	 "                       opt_ref  ASC        " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>