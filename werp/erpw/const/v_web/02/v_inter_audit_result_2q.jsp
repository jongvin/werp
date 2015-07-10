<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
	  String arg_part_code = req.getParameter("arg_part_code");
     String arg_year = req.getParameter("arg_year");
     String arg_half_year = req.getParameter("arg_half_year");
 //---------------------------------------------------------- 
	  dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("half_year",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comm_section",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("section",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("ins_contents",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ins_basis",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("weight_point",GauceDataColumn.TB_NUMBER,3));
     dSet.addDataColumn(new GauceDataColumn("point",GauceDataColumn.TB_NUMBER,3));
     dSet.addDataColumn(new GauceDataColumn("opinion",GauceDataColumn.TB_STRING,500));

    String query = "  SELECT part_code,   " + 
     "         to_char(year,'YYYY') year,  " + 
     "         half_year,  " + 
	  "			comm_section, " +
     "         seq,  " +
     "         section,  " +
     "         ins_contents,  " +
     "         ins_basis,  " +
	  "         weight_point,  " +
	  "			(select decode(point,null,0,point) from V_INTER_AUDIT_RESULT_DETAIL  " +
	  "          WHERE  part_code =  V_INTER_AUDIT_RESULT_ITEM.part_code  " +
	  "         AND year = V_INTER_AUDIT_RESULT_ITEM.year " +
     "         AND half_year = V_INTER_AUDIT_RESULT_ITEM.half_year " + 
     "         AND comm_section = V_INTER_AUDIT_RESULT_ITEM.comm_section  " +
	  "         AND select_type = 'T' " +
	  "	      AND seq = V_INTER_AUDIT_RESULT_ITEM.seq  ) point ," +
	  "         opinion " +
	  "    FROM V_INTER_AUDIT_RESULT_ITEM  " +
     "    WHERE PART_CODE =  '" + arg_part_code + "'" +
	  "         AND TO_CHAR(year,'YYYY') =  '" + arg_year +  "'" +
     "         AND half_year =  '" + arg_half_year + "'" +
	  "	 ORDER BY COMM_SECTION , SECTION , INS_CONTENTS , INS_BASIS " ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>