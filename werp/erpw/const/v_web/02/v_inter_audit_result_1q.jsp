<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_part_code = req.getParameter("arg_part_code");
     String arg_year = req.getParameter("arg_year");
     String arg_half_year = req.getParameter("arg_half_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("half_year",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("part_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("ins_dt",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("position",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("inspector",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("review",GauceDataColumn.TB_STRING,500));
    String query = "  SELECT   " + 
     "         part_code,  " + 
	  "         to_char(year,'YYYY') year,  " + 
     "         half_year,  " + 
     "         part_name,  " + 
     "         to_char(ins_dt,'YYYYMMDD') ins_dt,  " +
     "         position,  " +
     "         inspector,  " +
     "         review  " +
	  "    FROM V_INTER_AUDIT_RESULT_MASTER  " +
     "    WHERE part_code =  '" + arg_part_code + "'" +
	  "         AND to_char(year,'yyyy') =  '" + arg_year +  "'" +
     "         AND half_year =  '" + arg_half_year + "'" ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>