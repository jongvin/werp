<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_fr_date = req.getParameter("arg_fr_date");
     String arg_to_date = req.getParameter("arg_to_date");
     String arg_unq = req.getParameter("arg_unq");
     String arg_yn = req.getParameter("arg_yn");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_f_slip_request(?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_fr_date);
      stmt.setString(3,arg_to_date);
      stmt.setString(4,arg_unq);
      stmt.setString(5,arg_yn);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>