<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_user_id = req.getParameter("arg_user_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("user_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
    String query = "  SELECT  z_user.user_key ," + 
     "                        z_user.empno  " + 
     "                 FROM z_user,   " + 
     "                      z_authority_user " + 
     "     where z_authority_user.empno = z_user.empno      " + 
     "     and  z_authority_user.user_id = " + "'" + arg_user_id + "'" + "     " +
     "   order by z_user.no_seq  ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>