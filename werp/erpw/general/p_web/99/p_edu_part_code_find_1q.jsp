<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_edu_code = req.getParameter("arg_edu_code") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_part_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("edu_part_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("edu_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.edu_code ," + 
     "          a.edu_name,      " +
     "          a.edu_part_code,      " +
     "          b.edu_part_name ," + 
     "          a.edu_tag      " +
     "       FROM p_code_edu a, p_code_edu_part b " +
     "  where a.edu_part_code = b.edu_part_code  " +
     "    and ( a.edu_code like '" + arg_edu_code + "' " +
     "     or   a.edu_name like '" + arg_edu_code + "' )            ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>