<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cls_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cls_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  h_base_option_master.dept_code ," + 
     "          h_base_option_master.cls_code ," + 
     "          h_base_option_master.cls_name   " + 
     "       FROM h_base_option_master    " + 
     "       WHERE ( h_base_option_master.dept_code = '" + arg_dept_code + "')       " +
     "       order by  h_base_option_master.cls_code ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>