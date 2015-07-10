<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_id = req.getParameter("arg_group_id");
     String arg_batch_date = req.getParameter("arg_batch_date");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call efin_invoice_approval_pkg.create_reverse_invoice(?,?,?,?)}");
      stmt.registerOutParameter(1, java.sql.Types.VARCHAR);
      stmt.registerOutParameter(2, java.sql.Types.VARCHAR);
      stmt.setString(3,arg_group_id);
      stmt.setString(4,arg_batch_date);
      stmt.executeQuery(); 
      String result_1 = stmt.getString(1);
      String result_2 = stmt.getString(2);
      if (result_2.equals("0")) {
			throw new Exception("true");
      }	
      if (result_2.equals("2")) {
			throw new Exception(result_1 + "false");
      }	 
%><%@ 
include file="../../../comm_function/conn_procedure_end_return_value.jsp"%>