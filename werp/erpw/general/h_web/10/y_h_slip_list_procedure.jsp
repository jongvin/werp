<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_tag       = req.getParameter("arg_tag");
	  String arg_group_id = req.getParameter("arg_group_id");
	  String arg_slip_num = req.getParameter("arg_slip_num");
	  String arg_slip_name = req.getParameter("arg_slip_name");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date   = req.getParameter("arg_to_date");

 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_h_slip_list(?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_tag);
		stmt.setString(2,arg_group_id);
		stmt.setString(3,arg_slip_num);
		stmt.setString(4,arg_slip_name);
      stmt.setString(5,arg_dept_code);
      stmt.setString(6,arg_sell_code);
      stmt.setString(7,arg_from_date);
      stmt.setString(8,arg_to_date);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>