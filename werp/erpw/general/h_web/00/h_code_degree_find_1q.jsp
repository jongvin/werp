<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("code_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT CODE_DIV," + 
     "             CODE," + 
     "             CODE_NAME        FROM H_CODE_COMMON       WHERE CODE_DIV = '02'     ORDER BY CODE ASC         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>