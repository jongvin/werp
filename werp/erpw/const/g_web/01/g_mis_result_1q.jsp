<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("unq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("desc1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("plan_1",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_2",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_3",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_4",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_5",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_6",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_7",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_8",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_9",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_10",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_11",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_12",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_1",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_2",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_3",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_4",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_5",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_6",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_7",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_8",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_9",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_10",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_11",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_12",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("calc_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  to_char(g_mis_result.work_year,'yyyy.mm.dd') work_year ," + 
     "          g_mis_result.unq_key ," + 
     "          g_mis_result.no_seq ," + 
     "          g_mis_result.desc1 ," + 
     "          g_mis_result.plan_1 ," + 
     "          g_mis_result.plan_2 ," + 
     "          g_mis_result.plan_3 ," + 
     "          g_mis_result.plan_4 ," + 
     "          g_mis_result.plan_5 ," + 
     "          g_mis_result.plan_6 ," + 
     "          g_mis_result.plan_7 ," + 
     "          g_mis_result.plan_8 ," + 
     "          g_mis_result.plan_9 ," + 
     "          g_mis_result.plan_10 ," + 
     "          g_mis_result.plan_11 ," + 
     "          g_mis_result.plan_12 ," + 
     "          g_mis_result.result_1 ," + 
     "          g_mis_result.result_2 ," + 
     "          g_mis_result.result_3 ," + 
     "          g_mis_result.result_4 ," + 
     "          g_mis_result.result_5 ," + 
     "          g_mis_result.result_6 ," + 
     "          g_mis_result.result_7 ," + 
     "          g_mis_result.result_8 ," + 
     "          g_mis_result.result_9 ," + 
     "          g_mis_result.result_10 ," + 
     "          g_mis_result.result_11 ," + 
     "          g_mis_result.result_12,  " +
     "          g_mis_result.calc_yn  " +
     "    FROM g_mis_result        		" +
     " where work_year = '" + arg_year + "' " + 
     "  order by no_seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>