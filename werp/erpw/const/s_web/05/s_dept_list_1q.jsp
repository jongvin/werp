<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
    String query = "SELECT A.DEPT_CODE,B.LONG_NAME,B.PROCESS_CODE " + 
     "  FROM (" + 
     "     SELECT DISTINCT S_PAY.DEPT_CODE  " + 
     "         FROM  S_PAY  " + 
     "       WHERE   S_PAY.YYMM <= '" + arg_yymm + "') A," + 
     "       Z_CODE_DEPT B   " + 
     "     WHERE A.dept_CODE = B.DEPT_CODE     " + 
     "     ORDER BY B.LONG_NAME     " ; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>