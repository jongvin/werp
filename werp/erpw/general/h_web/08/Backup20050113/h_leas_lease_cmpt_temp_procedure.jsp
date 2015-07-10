<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_spec_unq_num  = req.getParameter("arg_spec_unq_num");
     String arg_dept_code     = req.getParameter("arg_dept_code");
     String arg_sell_code     = req.getParameter("arg_sell_code");
     String arg_dongho        = req.getParameter("arg_dongho");
     String arg_seq           = req.getParameter("arg_seq");
     String arg_input_date    = req.getParameter("arg_input_date");
     String arg_input_amt     = req.getParameter("arg_input_amt");
     String arg_input_class   = req.getParameter("arg_input_class");
     String arg_input_deposit = req.getParameter("arg_input_deposit");
     String arg_user          = req.getParameter("arg_user");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_h_leas_lease_cmpt_temp(?,?,?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_spec_unq_num);
      stmt.setString(2,arg_dept_code);
      stmt.setString(3,arg_sell_code);
      stmt.setString(4,arg_dongho);
      stmt.setString(5,arg_seq);
      stmt.setString(6,arg_input_date);
      stmt.setString(7,arg_input_amt);
      stmt.setString(8,arg_input_class);
      stmt.setString(9,arg_input_deposit);
      stmt.setString(10,arg_user);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>