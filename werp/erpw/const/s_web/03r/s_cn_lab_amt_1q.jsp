<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT NVL(s_chg_cn_parent.lab_amt,0) lab_amt  " + 
     "    FROM s_chg_cn_parent  " + 
     "   WHERE ( s_chg_cn_parent.dept_code = '" + arg_dept_code + "' ) AND  " + 
     "         ( s_chg_cn_parent.order_number = " + arg_order_number + " ) AND  " + 
     "         ( s_chg_cn_parent.chg_degree = " + arg_chg_degree + ") AND  " + 
     "         ( s_chg_cn_parent.llevel = 1 )         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>