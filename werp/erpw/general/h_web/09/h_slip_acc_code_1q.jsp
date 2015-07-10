<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("key",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("old_key",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("전표구분",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("전표단위",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("차변_계정명칭",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("차변_계정코드",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("대변_계정명칭",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("대변_계정코드",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  key , key old_key," + 
     "          전표구분, "+
	 "          전표단위, "+
	 "          차변_계정명칭, "+
	 "          차변_계정코드, "+
	 "          대변_계정명칭, "+
	 "          대변_계정코드 "+
	 "	 FROM h_slip_acc_code_table         " + 
     "          ORDER BY key         " ;  
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>