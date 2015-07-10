<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 	  String arg_edu_year = req.getParameter("arg_edu_year");
 	  String arg_edu_code = req.getParameter("arg_edu_code") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("io_tag",GauceDataColumn.TB_STRING,10));     
     dSet.addDataColumn(new GauceDataColumn("edu_part_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("edu_office_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_remark",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("edu_object",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_day",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_place",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT distinct a.edu_code ," + 
     "            a.edu_name, " + 
     "            decode(a.io_tag,'1','사내','2','사외','') io_tag, a.io_tag, " + 
     "            a.edu_part_code , " +
	  "            a.edu_office_code , " +
	  "            a.edu_remark,  " +
     "            a.edu_object,  " +
     "            to_char(b.start_date,'yyyy.mm.dd') start_date, " +
	  "            to_char(b.end_date,'yyyy.mm.dd') end_date, " +
	  "			   b.edu_degree , " +
	  "            b.edu_day    , " +
	  "            b.edu_time   , " +
	  "            b.edu_place    " +
	  "       FROM p_edu_curriculum a, " +
     "				p_edu_degree	  b  " +
     "      where a.edu_code  = b.edu_code " +
     "        and b.edu_year  = '" + arg_edu_year + "' " + 
     "        and ( a.edu_code like '" + arg_edu_code + "' " +   
     "         or   a.edu_name like '" +  arg_edu_code + "' ) " +
     " order by a.io_tag, a.edu_name     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>