<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_quality_section = req.getParameter("arg_quality_section");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("quality_ins_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("quality_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("quality_ins_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("weight_point1",GauceDataColumn.TB_NUMBER,2));
     dSet.addDataColumn(new GauceDataColumn("weight_point2",GauceDataColumn.TB_NUMBER,2));
     dSet.addDataColumn(new GauceDataColumn("weight_point",GauceDataColumn.TB_STRING,3));
	  dSet.addDataColumn(new GauceDataColumn("COLUMN_SIZE",GauceDataColumn.TB_STRING,30));



    String query = "  SELECT quality_ins_code,   " + 
     "         quality_section,  " + 
     "         quality_ins_name,  " + 
     "         weight_point1,  " + 
     "         weight_point2,  " + 
	  "			weight_point,	" +
     "         COLUMN_SIZE  " + 
	  "    FROM V_INS_ITEM_REG_MASTER  " +
	  "    WHERE  quality_section = '" + arg_quality_section + "'" +
	  "    ORDER BY quality_ins_code ASC " ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>