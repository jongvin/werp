<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_edu_subject_code = req.getParameter("arg_edu_subject_code") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_subject_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_subject_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.edu_subject_code ," + 
     "          a.edu_subject_name ," + 
     "          a.edu_code,      " +
     "          b.edu_name      " +
     "       FROM p_code_edu_subject a, p_code_edu b " +
     "  where a.edu_code = b.edu_code  " +
     "    and ( a.edu_subject_code like '" + arg_edu_subject_code + "' " +   
     "     or   a.edu_subject_name like '" +  arg_edu_subject_code + "' )      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>