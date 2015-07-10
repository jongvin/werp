<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_spec_unq_num     = req.getParameter("arg_spec_unq_num");
	  String arg_dept_code    = req.getParameter("arg_dept_code");
     String arg_sell_code     = req.getParameter("arg_sell_code");
     String arg_work_date    = req.getParameter("arg_work_date");
     String arg_agree_fr       = req.getParameter("arg_agree_fr");
     String arg_agree_to      = req.getParameter("arg_agree_to");
	  String arg_dongho_fr       = req.getParameter("arg_dongho_fr");
     String arg_dongho_to      = req.getParameter("arg_dongho_to");
	  String arg_pyong_fr       = req.getParameter("arg_pyong_fr");
     String arg_pyong_to      = req.getParameter("arg_pyong_to");
     
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call Y_Sp_H_invoice_mail_batch(?,?,?,?,?,?,?,?,?,?)}");
		stmt.setString(1,arg_spec_unq_num);
      stmt.setString(2,arg_dept_code);
      stmt.setString(3,arg_sell_code);
      stmt.setString(4,arg_work_date);
      stmt.setString(5,arg_agree_fr);
      stmt.setString(6,arg_agree_to);
		stmt.setString(7,arg_dongho_fr);
      stmt.setString(8,arg_dongho_to);
		stmt.setString(9,arg_pyong_fr);
      stmt.setString(10,arg_pyong_to);


%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>