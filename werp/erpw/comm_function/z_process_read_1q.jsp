<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_code = req.getParameter("arg_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("process_tag",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT PROCESS_TAG" + 
     "    FROM Z_PROCESS_SETTING  " + 
     "   WHERE setcode = " + "'" + arg_code + "'";
%><%@ 
include file="conn_q_end.jsp"%>