<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
     String arg_wbs_code = req.getParameter("arg_wbs_code");
     String arg_class = req.getParameter("arg_class");
     String arg_gubun = req.getParameter("arg_gubun");
     String arg_user = req.getParameter("arg_user");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_s_sbcr_insert(?,?,?,?,?,?)}");
      stmt.setString(1,arg_unq_num);
      stmt.setString(2,arg_sbcr_code);
      stmt.setString(3,arg_wbs_code);
      stmt.setString(4,arg_class);
	  stmt.setString(5,arg_gubun);
      stmt.setString(6,arg_user);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>