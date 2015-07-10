<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_quality_ins_code = req.getParameter("arg_quality_ins_code");
     String arg_quality_section = req.getParameter("arg_quality_section");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("quality_ins_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("quality_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("wbs_name",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("section",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ins_item",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("place",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));

	 String query = "  SELECT quality_ins_code,   " + 
     "         quality_section,  " + 
     "         seq,  " + 
     "         part_code,  " + 
     "         wbs_code,  " +
     "         (select comm_name from v_comm_code where comm_code = V_INS_ITEM_REG.wbs_code and part_code is not null) wbs_name,  " +
	  "         section,  " +
     "         ins_item,  " +
     "         place,  " +
     "         remark  " + 	  
	  "    FROM V_INS_ITEM_REG  " + 
     "    WHERE quality_ins_code = '" + arg_quality_ins_code + "'" + 
     "    and quality_section = '" + arg_quality_section + "'" + 
	  "    order by section asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>