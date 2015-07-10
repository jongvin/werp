<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_app_fix   = req.getParameter("arg_app_fix");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no    = req.getParameter("arg_chg_no");
     String arg_user      = req.getParameter("arg_user");
	 String arg_user_name = req.getParameter("arg_user_name");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_y_chg_approve(?,?,?,?,?)}");
      stmt.setString(1,arg_app_fix);
      stmt.setString(2,arg_dept_code);
      stmt.setString(3,arg_chg_no);
      stmt.setString(4,arg_user);
	  stmt.setString(5,arg_user_name);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>