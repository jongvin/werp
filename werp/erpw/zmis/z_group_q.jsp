<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("group_key",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("group_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  z_group.group_key ," + 
     "          z_group.group_name     FROM z_group        " + 
     "   ORDER BY z_group.group_key ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>