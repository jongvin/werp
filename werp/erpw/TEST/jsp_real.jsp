<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="comm_function/conn_gauce_q_pool.jsp"%><%
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("date1",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT to_char(sysdate,'yyyy.mm.dd') date1   " + 
     "    FROM dual   " + 
     "                  ";
    DBProfile dbpro  = context.getDBProfile();             // testdb의 정보 이용
    String database_url="";
    String database_user="";
    String database_password="";
    session.setMaxInactiveInterval(24*60*60);  // 세션 라이프 시간 설정 브라우져 종료까지
    database_url = dbpro.getURL();
    database_user = dbpro.getUser();
    database_password = dbpro.getPasswd();
    database_user = database_user + '*' + database_password + '*' + database_url;
    session.setAttribute("database_user",database_user);
%><%@ include file="comm_function/conn_q_end.jsp"%>