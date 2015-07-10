<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("week_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("photo_addr",GauceDataColumn.TB_STRING,250));
    String query = "select a.dept_code," + 
     "       to_char(a.week_date,'yyyy.mm.dd') week_date," + 
     "       a.photo_addr" + 
     "  from c_week_status a," + 
     "   (" + 
     "    select a.dept_code,max(a.week_date) week_date" + 
     "       from c_week_status a" + 
     "       where a.dept_code = '" + arg_dept_code + "' " + 
     "         and a.photo_addr is not null" + 
     "         and a.week_date < '" + arg_yymm  + "' " + 
     "       group by a.dept_code) b" + 
     "  where a.dept_code = b.dept_code" + 
     "    and a.week_date = b.week_date     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>