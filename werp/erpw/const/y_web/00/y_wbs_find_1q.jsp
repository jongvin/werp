<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_name = '%' + req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT WBS_CODE," + 
     "                       NAME," + 
     "                       NOTE       " +
     "                  FROM Y_WBS_CODE " +
     "                 WHERE PARENT_WBS_CODE = 'Z' " +
     "                   AND NAME like " + "'" + arg_name + "'" + 
     "              ORDER BY WBS_CODE ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>