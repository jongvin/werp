<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("reson",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  sbcr_code ," + 
					    "          seq ," + 
					    "          seq key_seq," + 
					    "          to_char(e_date,'YYYY.MM.DD') e_date ," + 
					    "          owner ," + 
					    "          name ," + 
					    "          reson   " +
					    "     FROM s_award " +
					    "    WHERE sbcr_code = '" + arg_sbcr_code + "'" +
					    " ORDER BY seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>