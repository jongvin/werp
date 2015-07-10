<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,300));
    String query = "select 0 unq_num," + 
     "        0 no_seq," + 
     "        '          ' name," + 
     "        '          ' url    from dual     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>