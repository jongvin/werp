<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
    String query = "SELECT A.profession_wbs_code,B.profession_wbs_name  " + 
     "  FROM (" + 
     "     SELECT DISTINCT S_ORDER_LIST.profession_wbs_code   " + 
     "         FROM  S_PAY,S_ORDER_LIST  " + 
     "       WHERE   S_PAY.DEPT_CODE = S_ORDER_LIST.DEPT_CODE   AND " + 
     "               S_PAY.ORDER_NUMBER =  S_ORDER_LIST.ORDER_NUMBER AND " + 
     "               S_PAY.YYMM <= '" + arg_yymm + "') A," + 
     "       s_profession_wbs B   " + 
     "     WHERE A.profession_wbs_code = B.profession_wbs_code     " + 
     "     ORDER BY B.profession_wbs_name     " ; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>