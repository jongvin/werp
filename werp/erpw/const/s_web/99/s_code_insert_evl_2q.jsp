<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,2000));
    String query = "  SELECT  class ," + 
     					 "          seq ," + 
     					 "          spec_seq ," + 
     					 "          code_name ," + 
     					 "          score ," + 
     					 "          remark    " +
     					 "     FROM s_code_evl_child  " +
     					 "    WHERE CLASS = " + "'" + arg_class + "'" +
     					 "      and SEQ = " + arg_seq  +
     					 " ORDER BY spec_seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>