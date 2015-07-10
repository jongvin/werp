<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("select_1",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "     " + 
     "    select efin_confirm_unq_seq.nextval  select_1 from dual ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>