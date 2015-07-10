<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_cdongho = req.getParameter("arg_cdongho");
     String arg_b_seq = req.getParameter("arg_b_seq");
     String arg_seq = req.getParameter("arg_seq");
	 String arg_lease_supply = req.getParameter("arg_lease_supply");
	 String arg_lease_vat = req.getParameter("arg_lease_vat");
	 String arg_chg_date = req.getParameter("arg_chg_date");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_h_type_chg_insert(?,?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_sell_code);
      stmt.setString(3,arg_dongho);
      stmt.setString(4,arg_cdongho);
      stmt.setString(5,arg_b_seq);
      stmt.setString(6,arg_seq);
	  stmt.setString(7,arg_lease_supply);
	  stmt.setString(8,arg_lease_vat);
	  stmt.setString(9,arg_chg_date);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>

