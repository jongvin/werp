<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_eval_degree = req.getParameter("arg_eval_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("base_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("base_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ret_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          a.base_code ," + 
     "          a.base_name,   " +
     "			 'Y' ret_tag  " +
     "		FROM p_eval_base    a  " +
     "	  where a.eval_code  = '" + arg_eval_code + "' " +
     "		 and a.eval_degree  = '" + arg_eval_degree + "' " +
     " order by a.base_code ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>