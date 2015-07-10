<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_from_dept_code   = req.getParameter("arg_from_dept_code");
     String arg_from_chg_no_seq  = req.getParameter("arg_from_chg_no_seq");
     String arg_from_spec_no_seq = req.getParameter("arg_from_spec_no_seq");
     String arg_to_dept_code   = req.getParameter("arg_to_dept_code");
     String arg_to_chg_no_seq  = req.getParameter("arg_to_chg_no_seq");
     String arg_to_spec_no_seq = req.getParameter("arg_to_spec_no_seq");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_dept_budget_copy(?,?,?,?,?,?)}");
      stmt.setString(1,arg_from_dept_code);
      stmt.setString(2,arg_from_chg_no_seq);
      stmt.setString(3,arg_from_spec_no_seq);
      stmt.setString(4,arg_to_dept_code);
      stmt.setString(5,arg_to_chg_no_seq);
      stmt.setString(6,arg_to_spec_no_seq);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>