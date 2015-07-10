<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code     = req.getParameter("arg_dept_code");
     String arg_sell_code     = req.getParameter("arg_sell_code");
     String arg_dongho        = req.getParameter("arg_dongho");
     String arg_seq           = req.getParameter("arg_seq");
	 String arg_sale_seq           = req.getParameter("arg_sale_seq");
     String arg_contract_date    = req.getParameter("arg_contract_date");
     String arg_cont_amt     = req.getParameter("arg_cont_amt");
	 String arg_rem_date    = req.getParameter("arg_rem_date");
	 String arg_user    = req.getParameter("arg_user");
	 String arg_cust_code    = req.getParameter("arg_cust_code");
	 String arg_cont_date    = req.getParameter("arg_cont_date");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_h_lease_to_cont_cmpt(?,?,?,?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_sell_code);
      stmt.setString(3,arg_dongho);
      stmt.setString(4,arg_seq);
      stmt.setString(5,arg_sale_seq);
      stmt.setString(6,arg_contract_date);
      stmt.setString(7,arg_cont_amt);
      stmt.setString(8,arg_rem_date);
      stmt.setString(9,arg_user);
	  stmt.setString(10,arg_cust_code);
	  stmt.setString(11,arg_cont_date);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>