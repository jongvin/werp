<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_name",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  p_eval_code.eval_code ," + 
     "          p_eval_code.eval_name    " +
     "		 FROM p_eval_code   " +
     "	order by eval_code     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>