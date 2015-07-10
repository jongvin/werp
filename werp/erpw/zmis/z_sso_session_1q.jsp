<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../comm_function/conn_mssql_q.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sessionkey = req.getParameter("arg_sessionkey");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sessionkey",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("userid",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("usersabun",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("username",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("userpassword",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("userdeptid",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("insertdate",GauceDataColumn.TB_STRING,50));
    String query = " " + 
  "    SELECT a.sessionkey,     " + 
  "           a.userid,         " + 
  "           a.usersabun,      " + 
  "           a.username,       " + 
  "           a.userpassword,   " + 
  "           a.userdeptid,     " + 
  "           a.insertdate      " + 
  "      from sso_login a       " + 
  "      where a.sessionkey = " + arg_sessionkey + " ";
%><%@ include file="../comm_function/conn_q_end.jsp"%>