<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("group_id",GauceDataColumn.TB_STRING,18));
      stmt = conn.prepareCall("{call efin_eis_com_budget_proc(?,?,?)}");
      stmt.registerOutParameter(1, java.sql.Types.VARCHAR);
      stmt.registerOutParameter(2, java.sql.Types.VARCHAR);
      stmt.setString(3,arg_year);
      stmt.executeQuery(); 
      String result_err = stmt.getString(1);
      String result_group_id = stmt.getString(2);
      GauceDataRow row = dSet.newDataRow();
       if (result_err.equals("1"))
          row.addColumnValue(result_group_id); // group_id
       else   
          row.addColumnValue("error"); // group_id
      dSet.addDataRow(row);
      dSet.flush();
%><%@ 
include file="../../../comm_function/conn_procedure_end_return_value.jsp"%>