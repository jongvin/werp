<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_invoice_id = req.getParameter("arg_invoice_id");
     String arg_unq_num = req.getParameter("arg_unq_num");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_d_efin_invoice_copy(?,?)}");
      stmt.setString(1,arg_invoice_id);
      stmt.setString(2,arg_unq_num);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>