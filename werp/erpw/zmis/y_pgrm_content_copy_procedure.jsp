<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_from_pgrm_above_key   = req.getParameter("arg_from_pgrm_above_key");
     String arg_to_group_key  = req.getParameter("arg_to_group_key");
     String arg_to_group_seq_key = req.getParameter("arg_to_group_seq_key");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_pgrm_content_copy(?,?,?)}");
      stmt.setString(1,arg_from_pgrm_above_key);
      stmt.setString(2,arg_to_group_key);
      stmt.setString(3,arg_to_group_seq_key);
%><%@ 
include file="../comm_function/conn_procedure_end.jsp"%>