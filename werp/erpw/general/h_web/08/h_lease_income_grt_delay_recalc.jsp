<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code     = req.getParameter("arg_dept_code");
     String arg_sell_code     = req.getParameter("arg_sell_code");
     String arg_cont_date        = req.getParameter("arg_cont_date");
     String arg_cont_seq           = req.getParameter("arg_cont_seq");
     String arg_degree_code          = req.getParameter("arg_degree_code");
	 String arg_degree_seq          = req.getParameter("arg_degree_seq");
     String arg_receipt_date    = req.getParameter("arg_receipt_date");
	 String arg_daily_seq    = req.getParameter("arg_daily_seq");
	 String arg_delay_amt    = req.getParameter("arg_delay_amt");
	 String arg_discount_amt    = req.getParameter("arg_discount_amt");
     
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call h_calc_income_grt.y_sp_h_delay_recalc_grt(?,?,?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);                                            
      stmt.setString(2,arg_sell_code);
      stmt.setString(3,arg_cont_date);
      stmt.setString(4,arg_cont_seq);
	  stmt.setString(5,arg_degree_code);
	  stmt.setString(6,arg_degree_seq);
      stmt.setString(7,arg_receipt_date);
	  stmt.setString(8,arg_daily_seq);
	  stmt.setString(9,arg_delay_amt);
	  stmt.setString(10,arg_discount_amt);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>



