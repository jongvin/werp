<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     //String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("setcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("setname",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("old_setcode",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT z_process_setting.setcode," + 
     "             z_process_setting.setname," + 
     "             z_process_setting.process_tag," + 
     "             z_process_setting.remark," + 
     "          z_process_setting.setcode old_setcode      FROM z_process_setting         " +
     "  ORDER BY setcode asc ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>