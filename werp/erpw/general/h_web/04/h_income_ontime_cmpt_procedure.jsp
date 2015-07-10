<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code     = req.getParameter("arg_dept_code");
     String arg_sell_code     = req.getParameter("arg_sell_code");
     String arg_dongho        = req.getParameter("arg_dongho");
     String arg_seq           = req.getParameter("arg_seq");
     String arg_input_date    = req.getParameter("arg_input_date");
     String arg_input_amt     = req.getParameter("arg_input_amt");
     String arg_input_class   = req.getParameter("arg_input_class");
     String arg_input_deposit = req.getParameter("arg_input_deposit");
     String arg_user          = req.getParameter("arg_user");
	 String arg_receipt_class_code   = req.getParameter("arg_receipt_class_code");
	 String arg_receipt_number          = req.getParameter("arg_receipt_number");
	 String arg_card_app_num          = req.getParameter("arg_card_app_num");
	 String arg_card_bank_code          = req.getParameter("arg_card_bank_code");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call h_calc_income_ontime.y_sp_h_income_ontime_cmpt(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_sell_code);
      stmt.setString(3,arg_dongho);
      stmt.setString(4,arg_seq);
      stmt.setString(5,arg_input_date);
      stmt.setString(6,arg_input_amt);
      stmt.setString(7,arg_input_class);
      stmt.setString(8,arg_input_deposit);
      stmt.setString(9,arg_user);
	  stmt.setString(10,arg_receipt_class_code);
	  stmt.setString(11,arg_receipt_number);
	  stmt.setString(12,arg_card_app_num);
	  stmt.setString(13,arg_card_bank_code);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>



