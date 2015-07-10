<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_start_date = req.getParameter("arg_start_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,250));
     dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,250));
    String query = "select a.dept_code," + 
     "       to_char(a.week_date,'yyyy.mm.dd') yymmdd," + 
     "       a.photo_addr url," + 
     "       a.a_this memo" + 
     "  from c_week_status a " + 
     "  where a.dept_code = '" + arg_dept_code + "' " + 
     "    and a.week_date >= '" + arg_start_date + "'     " + 
     "    and a.photo_addr is not null ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>