<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_user = req.getParameter("arg_user");
     String arg_slip_dt = req.getParameter("arg_slip_dt");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_f_slip_request_nopay(?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_date);
      stmt.setString(3,arg_user);
      stmt.setString(4,arg_slip_dt);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>