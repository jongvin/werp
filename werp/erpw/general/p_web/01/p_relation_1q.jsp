<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("relation_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("relation_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("old_relation_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  p_code_relation.relation_code ," + 
     "          p_code_relation.relation_name ," + 
     "          p_code_relation.old_relation_code  " +
     "     FROM p_code_relation     " +
     "	order by  relation_code  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>