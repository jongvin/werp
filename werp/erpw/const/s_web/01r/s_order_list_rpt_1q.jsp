<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.order_number,   " + 
     "         b.profession_wbs_name profession_wbs_name,   " + 
     "         a.order_name,   " + 
     "         a.approve_class  " + 
     "    FROM s_order_list a,   " + 
     "         s_profession_wbs  b " + 
     "   WHERE a.profession_wbs_code  = b.profession_wbs_code  " + 
     "     and a.dept_code      = '" + arg_dept_code + "'    " +
     "   ORDER BY a.order_number desc " ; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>