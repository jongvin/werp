<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
  String arg_dept_code     = req.getParameter("arg_dept_code");
  String arg_sell_code     = req.getParameter("arg_sell_code");
  String arg_receipt_date     = req.getParameter("arg_receipt_date");
     
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
     stmt = conn.prepareCall("{call y_sp_h_batch_loan_interest(?,?,?)}");
	  stmt.setString(1,arg_dept_code);
     stmt.setString(2,arg_sell_code);
	  stmt.setString(3,arg_receipt_date);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>



