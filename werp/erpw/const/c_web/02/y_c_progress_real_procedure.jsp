<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_last_date = req.getParameter("arg_last_date");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_c_progress_real(?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_chg_no_seq);
      stmt.setString(3,arg_start_date);
      stmt.setString(4,arg_last_date);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>