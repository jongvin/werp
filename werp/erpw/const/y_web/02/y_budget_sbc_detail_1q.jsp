<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_spec_unq_num = req.getParameter("arg_spec_unq_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
    String query = "select a.order_number,a.order_name sbc_name" + 
     "  from s_order_list a," + 
     "       s_order_detail b" + 
     "  where a.dept_code = b.dept_code" + 
     "     and   a.order_number = b.order_number" + 
     "     and   b.dept_code = '" + arg_dept_code + "' " + 
     "     and   b.spec_unq_num = " + arg_spec_unq_num + "    " + 
     "   order by a.order_number ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>