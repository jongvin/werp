<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  max(dept_code)  dept_code," + 
     "                        max(order_number) order_number ," + 
     "                        max(spec_no_seq) spec_no_seq " + 
     "             FROM s_order_detail    " + 
     "          WHERE ( dept_code = '" + arg_dept_code + "' ) And   " + 
     "                ( order_number = " + arg_order_number + " )   " + 
     "          GROUP BY dept_code,order_number,spec_no_seq      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>