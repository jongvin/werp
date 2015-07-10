<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%>><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 String arg_detail_code = req.getParameter("arg_detail_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("acnt_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("acnt_name",GauceDataColumn.TB_STRING,80));
    String query = " select acnt_code,"   +
"        acnt_name"   +
"   from y_stand_detail_acntcode"   +
"  where detail_code      = '"+arg_detail_code+"'"+
" order by acnt_code" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>