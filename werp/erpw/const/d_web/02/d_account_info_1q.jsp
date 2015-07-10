<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_saup = req.getParameter("arg_saup");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date = req.getParameter("arg_to_date");
     arg_saup  = arg_saup.replace('^','%') ;  // ^를 %로 바꿈. url에서는 %를 값으로 넘겨줄수 없슴으로  

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("created_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("created_dept_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("gul_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ban_cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.created_dept_code," + 
     "       a.created_dept_name," + 
     "       count(a.created_dept_code) tot_cnt," + 
     "       sum(decode(a.approval_status_10,'1',1,0)) gul_cnt," + 
     "       sum(decode(a.approval_status_10,'3',1,0)) ban_cnt " + 
     "   from efin_invoice_header_itf  a" + 
     "   where a.account_dept_code is not null" + 
     "     and a.approval_num like '" + arg_saup + "' " + 
     "     and a.batch_date >= '" + arg_from_date + "' " + 
     "     and a.batch_date <= '" + arg_to_date + "' " + 
     "   group by a.created_dept_code," + 
     "            a.created_dept_name     " + 
     "   order by a.created_dept_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>