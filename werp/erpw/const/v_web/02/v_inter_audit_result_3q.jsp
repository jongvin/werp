<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
	  String arg_part_code = req.getParameter("arg_part_code");
     String arg_year = req.getParameter("arg_year");
     String arg_half_year = req.getParameter("arg_half_year");
     String arg_comm_section = req.getParameter("arg_comm_section");
	  String arg_seq = req.getParameter("arg_seq");

 //---------------------------------------------------------- 
	  dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("half_year",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comm_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("point",GauceDataColumn.TB_NUMBER,3));
     dSet.addDataColumn(new GauceDataColumn("select_type",GauceDataColumn.TB_STRING,1));

    String query = "  SELECT part_code,   " + 
     "         to_char(year,'YYYY') year , " + 
     "         half_year,  " + 
	  "			comm_section, " +
     "         seq,  " +
     "         d_seq,  " +
     "         contents,  " +
     "         point,  " +
	  "         select_type  " +
	  "    FROM V_INTER_AUDIT_RESULT_DETAIL  " +
	  "    WHERE  part_code =  '" + arg_part_code + "'" +
	  "         AND to_char(year,'yyyy') =  '" + arg_year +  "'" +
     "         AND half_year =  '" + arg_half_year + "'" + 
     "         AND comm_section =  '" + arg_comm_section + "'" +
	  "         AND seq =  '" + arg_seq + "'" ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>