<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
   
 String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("confirm_section",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_confirm_section",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("order_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("confirm_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.confirm_section,									" + 
     "                       a.confirm_section key_confirm_section,		" + 
     "                       a.dept_code,											" + 
     "                       a.seq,													" + 
     "                       a.order_dt,											" + 
     "                       a.confirm_dt,        								" +
     "                       a.seq key_seq										" + 
     "                  FROM v_test_plan_master a   							" +
     "                 WHERE a.dept_code='" + arg_dept_code +
     "              ORDER BY a.confirm_section ASC,							" + 
	  "                       a.dept_code ASC,									" + 
	  "                       a.seq ASC         									";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>