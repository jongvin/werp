<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date   = req.getParameter("arg_to_date");
     String arg_slip_date = req.getParameter("arg_slip_date");
     String arg_process   = req.getParameter("arg_process");
     String arg_jundo   = req.getParameter("arg_jundo");
     String arg_all_tag   = req.getParameter("arg_all_tag");
     String arg_vender_code = req.getParameter("arg_vender_code");
     String arg_name      = req.getParameter("arg_name");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_f_slip_list(?,?,?,?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_from_date);
      stmt.setString(3,arg_to_date);
      stmt.setString(4,arg_slip_date);
      stmt.setString(5,arg_process);
      stmt.setString(6,arg_jundo);
      stmt.setString(7,arg_all_tag);
      stmt.setString(8,arg_vender_code);
      stmt.setString(9,arg_name);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>