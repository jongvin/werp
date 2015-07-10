<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_old_degree   = req.getParameter("arg_old_degree");
     String arg_new_degree  = req.getParameter("arg_new_degree");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call z_sp_dept_title_copy(?,?)}");
      stmt.setString(1,arg_old_degree);
      stmt.setString(2,arg_new_degree);
%><%@ 
include file="../comm_function/conn_procedure_end.jsp"%>