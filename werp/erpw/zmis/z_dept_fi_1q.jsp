<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_fi_q.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("flex_value",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("description",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  flex_value ," + 
     "                        description " + 
     "               FROM efin_department_v " + 
     "         ORDER BY flex_value         ASC      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>