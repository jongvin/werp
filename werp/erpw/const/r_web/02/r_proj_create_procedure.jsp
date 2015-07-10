<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_receive_code = req.getParameter("arg_receive_code");
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_seq_key = req.getParameter("arg_seq_key");
     String arg_class = req.getParameter("arg_class");
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_r_proj_create(?,?,?,?,?)}");
      stmt.setString(1,arg_receive_code);
      stmt.setString(2,arg_comp_code);
      stmt.setString(3,arg_seq_key);
      stmt.setString(4,arg_class);
      stmt.setString(5,arg_year);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>