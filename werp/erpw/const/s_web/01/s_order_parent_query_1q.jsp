<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  s_order_parent.dept_code ," + 
     "          s_order_parent.order_number ," + 
     "          s_order_parent.spec_no_seq ," + 
     "          s_order_parent.seq ," + 
     "          s_order_parent.direct_class ," + 
     "          s_order_parent.llevel ," + 
     "          s_order_parent.sum_code ," + 
     "          s_order_parent.parent_sum_code ," + 
     "          s_order_parent.name ," + 
     "          s_order_parent.ssize ," + 
     "          s_order_parent.unit ," + 
     "          s_order_parent.cnt_amt ," + 
     "          s_order_parent.exe_amt, " + 
     "          s_order_parent.sub_amt " + 
     "             FROM s_order_parent   " + 
     "         WHERE ( s_order_parent.dept_code = '" + arg_dept_code + "') and  " + 
     "               ( s_order_parent.order_number = " + arg_order_number + ")  and " + 
     "                 ( s_order_parent.parent_sum_code = " + "'" + arg_parent_sum_code + "'" + " )     " + 
     "         ORDER BY s_order_parent.sum_code         ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>