<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("receive_person",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("piety_relation",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("piety_bank",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("piety_account",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  p_pers_filial_piety.emp_no ," + 
     "          p_pers_filial_piety.receive_person ," + 
     "          p_pers_filial_piety.piety_relation ," + 
     "          p_pers_filial_piety.piety_bank ," + 
     "          p_pers_filial_piety.piety_account     FROM p_pers_filial_piety      " +
     "		WHERE ( p_pers_filial_piety.emp_no = '" + arg_emp_no + "' )       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>