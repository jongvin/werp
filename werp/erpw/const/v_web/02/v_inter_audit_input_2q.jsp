<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_part_code = req.getParameter("arg_part_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_NUMBER,18));
     dSet.addDataColumn(new GauceDataColumn("section",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("ins_contents",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("ins_basis",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("weight_point",GauceDataColumn.TB_NUMBER,3));

	 String query = "  SELECT part_code,   " + 
     "         seq,  " + 
     "         section,  " + 
     "         ins_contents,  " + 
     "         ins_basis,  " +
     "         weight_point  " + 	  
	  "    FROM V_INTER_AUDIT_ITEM  " + 
     "    WHERE part_code = '" + arg_part_code + "'" + 
	  "    order by section asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>