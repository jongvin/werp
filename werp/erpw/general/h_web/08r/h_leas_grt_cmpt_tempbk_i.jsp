<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_spec_unq_num  = req.getParameter("arg_spec_unq_num");
     String arg_dept_code      = req.getParameter("arg_dept_code");
     String arg_sell_code       = req.getParameter("arg_sell_code");
     String arg_from_pyong    = req.getParameter("arg_from_pyong");
	 String arg_to_pyong        = req.getParameter("arg_to_pyong");
	 String arg_from_dongho  = req.getParameter("arg_from_dongho");
	 String arg_to_dongho      = req.getParameter("arg_to_dongho");
	 String arg_process_tag   = req.getParameter("arg_process_tag");
 //----------------------------------------------------------
 y_sp_h_leas_grt_cmpt_tempbk_i(as_spec_unq_num IN NUMBER,
															    as_dept_code     IN   VARCHAR2,
															    as_sell_code     IN   VARCHAR2,
																 as_from_pyong    IN   varchar2,
																 as_to_pyong      IN   varchar2,
																 as_from_dongho   IN   varchar2,
																 as_to_dongho     IN   varchar2,
																 as_from_date     IN   date,
																 as_to_date       IN   date,
																 as_date          IN   date,
																 as_user          IN   VARCHAR2)
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call  y_sp_h_leas_grt_cmpt_tempbk_i(?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_spec_unq_num);
      stmt.setString(2,arg_dept_code);
      stmt.setString(3,arg_sell_code);
      stmt.setString(4,arg_from_pyong);
      stmt.setString(5,arg_to_pyong);
      stmt.setString(6,arg_from_dongho);
      stmt.setString(7,arg_to_dongho);
      stmt.setString(8,arg_process_tag);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>