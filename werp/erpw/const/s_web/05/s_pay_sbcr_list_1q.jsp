<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
    String query = "SELECT A.sbcr_code,B.sbcr_name  " + 
     "  FROM (" + 
     "     SELECT DISTINCT S_CN_LIST.SBCR_CODE   " + 
     "         FROM  S_PAY,S_CN_LIST  " + 
     "       WHERE   S_PAY.DEPT_CODE = S_CN_LIST.DEPT_CODE   AND " + 
     "               S_PAY.ORDER_NUMBER =  S_CN_LIST.ORDER_NUMBER AND " + 
     "               S_PAY.YYMM <= '" + arg_yymm + "') A," + 
     "       s_sbcr B   " + 
     "     WHERE A.sbcr_code = B.sbcr_code     " + 
     "     ORDER BY B.SBCR_NAME     " ; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>