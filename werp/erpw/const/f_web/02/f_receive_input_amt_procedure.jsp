<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
  String arg_dept_code     = req.getParameter("arg_dept_code");
 // String arg_seq           = req.getParameter("arg_seq");
     
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call SP_RECEIVE_AMT_INPUT(?) }");
      stmt.setString(1,arg_dept_code);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>



