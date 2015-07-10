<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("flicense_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("test_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("gain_score",GauceDataColumn.TB_DECIMAL,4,2));
     dSet.addDataColumn(new GauceDataColumn("lc",GauceDataColumn.TB_DECIMAL,4,0));
     dSet.addDataColumn(new GauceDataColumn("rc",GauceDataColumn.TB_DECIMAL,4,0));
     dSet.addDataColumn(new GauceDataColumn("full_score",GauceDataColumn.TB_DECIMAL,4,2));
     dSet.addDataColumn(new GauceDataColumn("rank",GauceDataColumn.TB_STRING,10,0));
     dSet.addDataColumn(new GauceDataColumn("remk_text",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  p_pers_flicense.resident_no ," + 
     "          p_pers_flicense.flicense_code ," + 
     "          to_char(p_pers_flicense.test_date,'yyyy.mm.dd') test_date ," + 
     "          p_pers_flicense.gain_score ," + 
     "          p_pers_flicense.lc ," + 
     "          p_pers_flicense.rc ," + 
     "          p_pers_flicense.full_score ," + 
     "          p_pers_flicense.rank ," + 
     "          p_pers_flicense.remk_text     " +
     " FROM p_pers_flicense        " +
     "   where p_pers_flicense.resident_no = '" + arg_resident_no   + "' " +
	 " order by test_date desc, flicense_code ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>