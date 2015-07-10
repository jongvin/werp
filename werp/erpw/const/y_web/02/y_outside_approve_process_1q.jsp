<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_approve_class = req.getParameter("arg_approve_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
    String query = "select a.dept_code,b.long_name,a.cnt,to_char(a.work_dt) work_dt, " + 
     "      to_char(a.request_dt,'yyyy.mm.dd') request_dt,to_char(a.approve_dt,'yyyy.mm.dd') approve_dt " + 
     "  from (" + 
     "       select a.dept_code dept_code," + 
     "              count(a.dept_code) cnt," + 
     "              max(a.work_dt) work_dt," + 
     "              max(a.request_dt) request_dt," + 
     "              max(a.approve_dt) approve_dt" + 
     "        from y_outside a" + 
     "        where a.approve_class = '" + arg_approve_class + "' " + 
     "        group by a.dept_code ) a," + 
     "      z_code_dept b" + 
     "   where a.dept_code = b.dept_code " + 
     "     and a.cnt <> 0     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>