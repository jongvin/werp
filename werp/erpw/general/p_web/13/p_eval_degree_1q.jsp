<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("eval_degree_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  p_eval_degree.eval_code ," + 
     "          p_eval_degree.eval_degree,  " + 
     "          p_eval_degree.eval_degree_name  " + 
     "	   FROM p_eval_degree     " + 
     "	  where eval_code = '" + arg_eval_code + "'     " + 
     "	order by eval_degree desc   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>