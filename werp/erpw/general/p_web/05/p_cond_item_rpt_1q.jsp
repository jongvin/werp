<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_no = req.getParameter("arg_no");
     String arg_sql = req.getParameter("arg_sql");
     String ls_select;
     arg_sql = arg_sql.replace('!','+') ; 
     arg_sql = arg_sql.replace('@','%') ; 
     int ll_no = 0;
     for (int i=1;i<=Integer.parseInt(arg_no);i++) {
     	   ls_select="select_" + i;
         dSet.addDataColumn(new GauceDataColumn(ls_select,GauceDataColumn.TB_STRING,100));
     }	
 //------------------------------------------------------------------------ 
    String query = arg_sql;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>