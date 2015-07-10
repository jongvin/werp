<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%

 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_seq = req.getParameter("arg_seq");
     String arg_item = req.getParameter("arg_item");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("opinion_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("part_code",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("d_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("or_point",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("max_point",GauceDataColumn.TB_DECIMAL,18,0));
     
	 String query = " SELECT														" +
					"		a.opinion_type,											" + 
					"       a.seq,													" + 
					"       a.part_code,											" + 
					"       a.item_code,											" +     
					"       a.d_seq,												" + 
					"       a.contents,												" + 
					"       a.or_point,												" + 
					"       0 max_point											" +
					" FROM															" +
					"		e_opinion_register_detail a								" + 
					" WHERE															" + 
					"		a.opinion_type = '2' and								" + 
					"       a.seq = " + arg_seq + " and								" +
					"       a.item_code = '" + arg_item + "'						" +
					" ORDER BY														" +
					"		a.d_seq ASC												" ;

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>