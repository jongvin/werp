<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
	 String arg_pyong = req.getParameter("arg_pyong");
	 String arg_style = req.getParameter("arg_style");
	 String arg_class = req.getParameter("arg_class");
	 String arg_option_code = req.getParameter("arg_option_code");
	 String arg_lease_supply = req.getParameter("arg_lease_supply");
	 String arg_recont_date = req.getParameter("arg_recont_date");
	 String arg_raise_amt = req.getParameter("arg_raise_amt");
     String arg_input_id = req.getParameter("arg_input_id");
	 
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_h_leas_raise_lease_batch(?,?,?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_sell_code);
      stmt.setString(3,arg_pyong);
      stmt.setString(4,arg_style);
      stmt.setString(5,arg_class);
      stmt.setString(6,arg_option_code);
	  stmt.setString(7,arg_lease_supply);
	  stmt.setString(8,arg_recont_date);	
	  stmt.setString(9,arg_raise_amt);
	  stmt.setString(10,arg_input_id);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>