<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("rnp_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("rnp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("in_out_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("eval_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("rnp_div",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  p_code_rnp.rnp_code ," + 
     "          p_code_rnp.rnp_name ," + 
     "          p_code_rnp.in_out_div ," + 
     "          p_code_rnp.eval_score, rnp_div     FROM p_code_rnp        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>