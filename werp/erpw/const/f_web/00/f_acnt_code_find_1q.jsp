<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 String arg_acntname = req.getParameter("arg_acntname") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("acntname",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("acntname2",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT  acntcode  ," + 
     "         		         acntname,  " + 
     "         		         acntname2  " + 
     "         		 FROM z_code_acnt " +
     "                  where acntname2 like " + "'%" + arg_acntname + "'" +
     " order by acntcode asc       " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>