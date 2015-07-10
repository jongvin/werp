<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_userid = req.getParameter("arg_userid");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
    String query = " " + 
  "    SELECT a.user_id,         " + 
  "           a.empno,      " + 
  "           a.password,       " + 
  "           a.name,   " + 
  "           a.dept_code     " + 
  "      from z_authority_user a       " + 
  "      where a.user_id = '" + arg_userid + "'";
%><%@ include file="../comm_function/conn_q_end.jsp"%>