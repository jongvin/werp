<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%

     String arg_work_seq  = req.getParameter("arg_work_seq");
	  String arg_work_tag   = req.getParameter("arg_work_tag");
	  String arg_sms_yn     = req.getParameter("arg_sms_yn");
	  String arg_input_id     = req.getParameter("arg_input_id");
	  String arg_input_date = req.getParameter("arg_input_date");
     

      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call Y_Sp_H_fbs_batch(?,?,?,?,?)}");
      stmt.setString(1,arg_work_seq);
		stmt.setString(2,arg_work_tag);
		stmt.setString(3,arg_sms_yn);
		stmt.setString(4,arg_input_id);
		stmt.setString(5,arg_input_date);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>


