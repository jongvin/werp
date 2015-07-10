<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //   String arg_ration_code = req.getParameter("arg_ration_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("nation_code",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("nation_name_en",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("nation_name_kr",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("nation_code_chk",GauceDataColumn.TB_DECIMAL,3,0));
     String query = "  SELECT nation_code," + 
		"				nation_name_en," + 
		"				nation_name_kr," + 
		"				nation_code nation_code_chk " + 
		"		 FROM l_nation_code " + 
      "      ORDER BY nation_name_kr  ASC " ; 
     
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>