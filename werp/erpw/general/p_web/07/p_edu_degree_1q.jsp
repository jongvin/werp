<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_edu_year = req.getParameter("arg_edu_year");
     String arg_edu_code = req.getParameter("arg_edu_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_day",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_place",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_person",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  to_char(p_edu_degree.edu_year, 'YYYY.MM.DD') edu_year ," + 
     "          p_edu_degree.edu_code ," + 
     "          p_edu_degree.edu_degree ," + 
     "          to_char(p_edu_degree.start_date, 'YYYY.MM.DD') start_date ," + 
     "          to_char(p_edu_degree.end_date, 'YYYY.MM.DD') end_date ," + 
     "          p_edu_degree.edu_day ," + 
     "          p_edu_degree.edu_time ," + 
     "          p_edu_degree.edu_place ," + 
     "          p_edu_degree.edu_person    " +
     "       FROM p_edu_degree  " +
     "    where p_edu_degree.edu_year = '" + arg_edu_year + "' " + 
     "      and p_edu_degree.edu_code = '" + arg_edu_code + "'    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>