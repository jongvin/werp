<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("approval_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
    String query = "select a.approval_id," + 
     "        a.approval_dept_code," + 
     "        b.name    " + 
     "     from efin_approval_authority a," + 
     "        (select a.user_id," + 
     "                max(a.name) name  " + 
     "               from z_authority_user a   " + 
     "           group by a.user_id) b " + 
     "    where a.approval_id = b.user_id " + 
     "    order by b.name    ";
%><%@ include file="../comm_function/conn_q_end.jsp"%>