<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("old_wbs_code",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT y_wbs_code.wbs_code," + 
     "             y_wbs_code.no_seq," + 
     "             y_wbs_code.llevel," + 
     "             y_wbs_code.name," + 
     "             y_wbs_code.note," + 
     "          y_wbs_code.wbs_code old_wbs_code       FROM y_wbs_code  " + 
     "          where substr(y_wbs_code.wbs_code,1,1) <> 'Z' " + 
     "  ORDER BY y_wbs_code.no_seq ASC         ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>