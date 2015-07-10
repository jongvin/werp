<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("msg",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("send_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  h_sms_master.no_seq ," + 
     "                        h_sms_master.msg,     " + 
     "                        to_char(h_sms_master.send_date,'yyyy.mm.dd') send_date,     " + 
     "                        tag     " + 
     "                   FROM h_sms_master  " + 
     "                  ORDER BY h_sms_master.no_seq          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>