<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_receive_code = req.getParameter("arg_receive_code");
     String arg_class = req.getParameter("arg_class");
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_z_dept_code_request(?,?,?)}");
      stmt.setString(1,arg_receive_code);
      stmt.setString(2,arg_class);
      stmt.setString(3,arg_year);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>