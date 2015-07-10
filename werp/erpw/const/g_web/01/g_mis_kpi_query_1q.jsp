<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_yymm");
     String arg_plan_sum = req.getParameter("arg_plan_sum");
     arg_plan_sum = arg_plan_sum.replace('!','+') ; 
     String arg_result_sum = req.getParameter("arg_result_sum");   
     String arg_cur_plan = req.getParameter("arg_cur_plan");     
     String arg_cur_result = req.getParameter("arg_cur_result");     
       
     arg_result_sum = arg_result_sum.replace('!','+') ;      
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("desc1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("desc2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("plan_sum",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_cum",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("result_cum",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("plan_12",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("cur_plan",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("cur_result",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("calc_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.desc1 ," + 
     "                        a.desc2 ," + 
     "                        a.plan_1 + a.plan_2 + a.plan_3 + a.plan_4 + a.plan_5 + a.plan_6 + a.plan_7 + a.plan_8 + a.plan_9 + a.plan_10 + a.plan_11 + a.plan_12 plan_sum ," + 
     "                        " + arg_plan_sum + " plan_cum ," + 
     "                        " + arg_result_sum + " result_cum, " + 
     "                        a.plan_12 plan_12, " +
     "                        " + arg_cur_plan + " cur_plan, " + 
     "                        " + arg_cur_result + " cur_result, " + 
     "                        a.calc_yn calc_yn " +
     "                   FROM g_mis_kpi  a      		" +
     "                  where a.work_year = '" + arg_year + "'  order by a.no_seq";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>