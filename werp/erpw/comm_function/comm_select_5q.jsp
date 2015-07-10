<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_sql = req.getParameter("in_sql");
     in_sql = in_sql.replace('!','+') ; 
     in_sql = in_sql.replace('@','%') ; 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("select_1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("select_2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("select_3",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("select_4",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("select_5",GauceDataColumn.TB_STRING,100));
    String query = in_sql;
%><%@ 
include file="conn_q_end.jsp"%>