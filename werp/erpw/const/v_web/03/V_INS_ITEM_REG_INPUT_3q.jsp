<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_quality_ins_code = req.getParameter("arg_quality_ins_code");
     String arg_quality_section = req.getParameter("arg_quality_section");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("quality_ins_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("quality_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("point",GauceDataColumn.TB_DECIMAL,4,1));
	 String query = "  SELECT quality_ins_code,   " + 
						  "         quality_section , " + 
						  "         seq , " + 
						  "         d_seq , " + 
						  "         contents , " + 
						  "         point  " + 
						  "   FROM V_INS_ITEM_REG_DETAIL  "  + 
						  "	WHERE  quality_ins_code = '"+ arg_quality_ins_code +"'" + 
						  "		and quality_section = '"+ arg_quality_section +"' " + 
						  "		and seq = '"+ arg_seq +"'" +
						  "	order by point desc "; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>