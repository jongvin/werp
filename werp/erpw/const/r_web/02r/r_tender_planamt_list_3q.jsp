<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_code = req.getParameter("arg_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("comp_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("combination",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("avg_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  select receive_code , " +
     "                       to_char(comp_date,'YYYY.MM.DD') comp_date, " +
     "                       combination, " +
     "                       nvl(avg_amt,0) avg_amt " +
     "                  from r_tender_planamt_output    " +
     "                 where receive_code = " + "'" + arg_code + "'" +
     "                   and comp_date  = " + "'" + arg_date + "'" +
     "              order by combination asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>