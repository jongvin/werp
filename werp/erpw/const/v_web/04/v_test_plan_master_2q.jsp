<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
    
 String arg_section = req.getParameter("arg_section");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("confirm_section",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_confirm_section",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("order_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("confirm_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.confirm_section,													" + 
     "                       a.confirm_section key_confirm_section,						" + 
     "                       a.dept_code,															" + 
     "                       b.long_name,															" + 
     "                       a.seq,																	" + 
     "                       to_char(a.order_dt, 'yyyy.mm.dd') order_dt,				" + 
     "                       to_char(a.confirm_dt, 'yyyy.mm.dd') confirm_dt,        " +
     "                       a.seq key_seq														" + 
     "                  FROM v_test_plan_master a,   											" +
     "                       z_code_dept b														" +
     "                 WHERE a.dept_code = b.dept_code and									" +
     "                       a.confirm_section='" + arg_section + "'    				" +
     "              ORDER BY a.confirm_section ASC,											" + 
	  "                       a.dept_code ASC,													" + 
	  "                       a.confirm_dt DESC,													" + 
	  "                       a.order_dt ASC        	 										";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>