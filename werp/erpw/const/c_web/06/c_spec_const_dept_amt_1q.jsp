<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_sum_code = req.getParameter("arg_sum_code");
     String arg_ea = req.getParameter("arg_ea");
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_result_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("proj_pos",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("proj_charge",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_profit",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " SELECT  view_c_spec_const_parent.sum_code,  " + 
     "         view_c_spec_const_parent.dept_code, " + 
     "         view_c_spec_const_parent.long_name, " + 
     "         view_c_spec_const_parent.cnt_result_amt / " + arg_ea + " cnt_result_amt,   " + 
     "         view_c_spec_const_parent.result_amt / " + arg_ea + " result_amt,   " + 
     "         view_c_spec_const_parent.cost_amt / " + arg_ea + " cost_amt,   " + 
     "         (view_c_spec_const_parent.ls_cnt_result_amt / " + arg_ea + ") + (view_c_spec_const_parent.cnt_result_amt / " + arg_ea + ") ls_cnt_result_amt,   " + 
     "         (view_c_spec_const_parent.ls_result_amt / " + arg_ea + ") + (view_c_spec_const_parent.result_amt / " + arg_ea + ") ls_result_amt,   " + 
     "         (view_c_spec_const_parent.ls_cost_amt / " + arg_ea + ") + (view_c_spec_const_parent.cost_amt / " + arg_ea + ") ls_cost_amt,   " + 
     "         view_c_spec_const_parent.cnt_amt / " + arg_ea + " cnt_amt,   " + 
     "         view_c_spec_const_parent.amt / " + arg_ea + " amt,   " + 
     "         view_c_spec_const_parent.pre_result_amt / " + arg_ea + " pre_result_amt," + 
     "         view_c_spec_const_parent.pre_result_rate pre_result_rate," + 
     "         view_c_spec_const_parent.proj_pos  proj_pos," + 
     "         view_c_spec_const_parent.proj_charge proj_charge," + 
     "         to_char(view_c_spec_const_parent.chg_const_start_date,'yyyymmdd') chg_const_start_date," + 
     "         to_char(view_c_spec_const_parent.chg_const_end_date,'yyyymmdd') chg_const_end_date," + 
     "         (view_c_spec_const_parent.cnt_result_amt - view_c_spec_const_parent.cost_amt) / " + arg_ea + "  cnt_profit,   " + 
     "         (view_c_spec_const_parent.result_amt - view_c_spec_const_parent.cost_amt) / " + arg_ea + "  profit,   " + 
     "         ((view_c_spec_const_parent.cnt_result_amt + view_c_spec_const_parent.ls_cnt_result_amt) - (view_c_spec_const_parent.cost_amt + view_c_spec_const_parent.ls_cost_amt)) / " + arg_ea + "  ls_cnt_profit,   " + 
     "         ((view_c_spec_const_parent.result_amt + view_c_spec_const_parent.ls_result_amt) -( view_c_spec_const_parent.cost_amt + view_c_spec_const_parent.ls_cost_amt)) / " + arg_ea + "  ls_profit   " + 
     "    FROM view_c_spec_const_parent" + 
     "   WHERE ( view_c_spec_const_parent.yymm = " + "'" + arg_yymm + "'" + " ) AND  " + 
     "        ( view_c_spec_const_parent.sum_code = " + "'" + arg_sum_code + "'" + " )   " + 
     "        ORDER BY view_c_spec_const_parent.no_seq ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>