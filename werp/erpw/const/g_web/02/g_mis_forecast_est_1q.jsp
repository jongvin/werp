<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_yymm = req.getParameter("arg_work_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("proj_bus_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proj_prog_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proj_unq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ord_sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bef_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rem_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  to_char(a.work_yymm,'yyyy.mm.dd') work_yymm ," + 
				       "          a.proj_bus_type ," + 
				       "          a.proj_prog_type ," + 
				       "          a.proj_unq_key ," + 
				       "          a.proj_name ," + 
				       "          a.ord_sell_amt ," + 
				       "          a.bef_amt ," + 
				       "          a.rem_amt ," + 
				       "          a.amt_1 ," + 
				       "          a.amt_2 ," + 
				       "          a.amt_3 ," + 
				       "          a.amt_4 ," + 
				       "          a.remark, " +
				       "          a.no_seq " +
				       "     FROM g_mis_forecast_est    a    " + 
				       "     where to_char(a.work_yymm,'yyyy.mm') = to_char(to_date('" + arg_work_yymm + "'),'yyyy.mm') " +
				       " order by a.proj_bus_type asc ," + 
				       "          a.proj_prog_type desc ," + 
				       "          a.no_seq,a.proj_name asc	" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>