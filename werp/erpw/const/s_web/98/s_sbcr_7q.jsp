<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("grade",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("age",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("imp_process",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("our_career_year",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("career_year",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("representative_rel",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("last_scholarship",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("imp_career",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  sbcr_code ," + 
     					 "          seq ," + 
     					 "          seq key_seq," + 
     					 "          grade ," + 
     					 "          name ," + 
     					 "          age ," + 
     					 "          imp_process ," + 
     					 "          our_career_year ," + 
     					 "          career_year ," + 
     					 "          representative_rel ," + 
     					 "          last_scholarship ," + 
     					 "          imp_career   " +
     					 "     FROM s_master " +
     					 "    WHERE sbcr_code = '" + arg_sbcr_code + "'" + 
     					 " order by seq asc       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>