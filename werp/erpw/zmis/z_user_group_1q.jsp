<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_group_key = req.getParameter("arg_group_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("user_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("group_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("user_group_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT  z_user_group.user_key ," + 
     "          z_user_group.group_key ," + 
     "          z_user_group.user_group_name     FROM z_user_group  " + 
     "    WHERE ( z_user_group.group_key = " + arg_group_key + " )    " +
     "	 order by  z_user_group.user_group_name  ";
%><%@ include file="../comm_function/conn_q_end.jsp"%>