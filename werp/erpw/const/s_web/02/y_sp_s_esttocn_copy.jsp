<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
     String arg_vat_class = req.getParameter("arg_vat_class");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_s_esttocn_copy(?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_order_number);
      stmt.setString(3,arg_sbcr_code);
      stmt.setString(4,arg_vat_class);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>