<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_masterdept_tag = req.getParameter("arg_masterdept_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("received_plan_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_received_plan_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tmp_received_plan_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("no",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("key_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("const_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("const_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pq_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("receive_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("constkind_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("masterdept_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("new_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("received_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_profit_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("decision_yn",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("decision_yn1",GauceDataColumn.TB_STRING,8));
    String query = "  SELECT to_char(a.RECEIVED_PLAN_YEAR,'yyyy.mm.dd') received_plan_year,   " + 
     "         to_char(a.RECEIVED_PLAN_YEAR,'yyyy.mm.dd')   key_received_plan_year, " + 
     "         to_char(a.RECEIVED_PLAN_YEAR,'yyyy.mm')   tmp_received_plan_year, " + 
     "         a.NO,   " + 
     "         a.NO   key_no,   " + 
     "         a.CONST_NAME,   " + 
     "         a.ORDER_NO,  " + 
     "			b.order_name, " + 
     "         a.CONST_TAG,   " + 
     "         a.PQ_TAG,   " + 
     "         a.RECEIVE_TAG,   " + 
     "         a.CONSTKIND_TAG,   " + 
     "         a.MASTERDEPT_TAG,   " + 
     "         a.NEW_TAG,   " + 
     "         a.RECEIVED_PLAN_AMT,   " + 
	  "			a.pre_profit_rate , " +
     "         a.REMARK, " + 
     "			decode(a.decision_yn,'Y','확정','N','미확정') decision_yn1, " +
     "			a.decision_yn " +
     "    FROM R_RECEIVED_YEAR_PLAN  a," + 
     "			r_code_order b" + 
     "   WHERE a.order_no = b.order_no (+) and" + 
     "			to_char(a.RECEIVED_PLAN_YEAR,'YYYY') = substrb(" + "'" + arg_year + "'" + ",1,4) and " +
	  "			a.masterdept_tag in "+arg_masterdept_tag+" "+
     " ORDER BY a.received_plan_year asc,a.no asc     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>