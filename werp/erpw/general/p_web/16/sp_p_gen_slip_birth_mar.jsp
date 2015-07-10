<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call sp_p_gen_slip_birth_mar(?,?,?,?)}");
      stmt.setString(1,arg_comp_code);
      stmt.setString(2,arg_yymm);
      stmt.setString(3,arg_date);
      stmt.setString(4,arg_seq);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>