<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //     String arg_dept_code = req.getParameter("arg_dept_code");
 //     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("process_days",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  to_char(yymmdd,'yyyymmdd') yymmdd ," + 
     "                        to_char(yymmdd,'yyyymmdd') key_yymmdd, " + 
     "                        process_days " + 
     "       FROM h_com_holiday    " + 
     "     order by  yymmdd asc   "; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>