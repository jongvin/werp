<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_workym = req.getParameter("arg_workym");
	  String arg_month_code = req.getParameter("arg_month_code");
	  String arg_day_code= req.getParameter("arg_day_code");
	  String arg_day = req.getParameter("arg_day");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_h_lease_create_rent(?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_sell_code);
      stmt.setString(3,arg_workym);
		stmt.setString(4,arg_month_code);
		stmt.setString(5,arg_day_code);
		stmt.setString(6,arg_day);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>