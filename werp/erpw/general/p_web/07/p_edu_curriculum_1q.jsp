<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_part_code",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("edu_office_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("grade",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("level_year",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_object",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("edu_remark",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("io_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.edu_code ," + 
     "          a.edu_name ," + 
     "          a.edu_part_code ," + 
     "          a.edu_office_code ," + 
     "          a.grade ," + 
     "          a.level_year ," + 
     "          a.degree_sum ," + 
     "          a.edu_object ," + 
     "          a.edu_remark,   " +
     "          a.io_tag   " +
     "     FROM p_edu_curriculum a " +
     "	order by a.edu_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>