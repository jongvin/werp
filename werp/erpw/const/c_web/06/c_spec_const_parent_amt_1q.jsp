<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_sum_code = req.getParameter("arg_sum_code");
     String arg_ea = req.getParameter("arg_ea");
     arg_sum_code = arg_sum_code + "%";
     String arg_substr = req.getParameter("arg_substr");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT   a.sum_code sum_code," + 
     "         c_spec_class_parent.name name,   " + 
     "         sum(a.cnt_result_amt) / " + arg_ea + " cnt_result_amt,   " + 
     "         sum(a.result_amt) / " + arg_ea + " result_amt,   " + 
     "         sum(a.cost_amt) / " + arg_ea + " cost_amt,   " + 
     "         (sum(a.ls_cnt_result_amt) / " + arg_ea + " ) + (sum(a.cnt_result_amt) / " + arg_ea + " ) ls_cnt_result_amt,   " + 
     "         (sum(a.ls_result_amt) / " + arg_ea + " ) + (sum(a.result_amt) / " + arg_ea + " )  ls_result_amt,   " + 
     "         (sum(a.ls_cost_amt) / " + arg_ea + " ) + (sum(a.cost_amt) / " + arg_ea + ")  ls_cost_amt,   " + 
     "         sum(a.cnt_amt) / " + arg_ea + " cnt_amt,   " + 
     "         sum(a.amt) / " + arg_ea + " amt,   " + 
     "         (sum(a.cnt_result_amt) - sum(a.cost_amt)) / " + arg_ea + "  cnt_profit,   " + 
     "         (sum(a.result_amt) - sum(a.cost_amt)) / " + arg_ea + "  profit,   " + 
     "         ((sum(a.cnt_result_amt) + sum(a.ls_cnt_result_amt)) - (sum(a.cost_amt) + sum(a.ls_cost_amt))) / " + arg_ea + "  ls_cnt_profit,   " + 
     "         ((sum(a.result_amt) + sum(a.ls_result_amt)) - (sum(a.cost_amt) + sum(a.ls_cost_amt))) / " + arg_ea + "  ls_profit,   " + 
     "         sum(a.pre_result_amt) / " + arg_ea + "  pre_result_amt " + 
     "   from ( SELECT substr(view_c_spec_const_parent.sum_code,1," + arg_substr + ") sum_code ,   " + 
     "         view_c_spec_const_parent.cnt_result_amt,   " + 
     "         view_c_spec_const_parent.result_amt,   " + 
     "         view_c_spec_const_parent.cost_amt,   " + 
     "         view_c_spec_const_parent.ls_cnt_result_amt,   " + 
     "         view_c_spec_const_parent.ls_result_amt,   " + 
     "         view_c_spec_const_parent.ls_cost_amt,   " + 
     "         view_c_spec_const_parent.cnt_amt,   " + 
     "         view_c_spec_const_parent.amt,   " + 
     "         view_c_spec_const_parent.pre_result_amt   " + 
     "    FROM view_c_spec_const_parent  " + 
     "   WHERE ( view_c_spec_const_parent.yymm = " + "'" + arg_yymm + "'" + ")  and " + 
      "        ( view_c_spec_const_parent.sum_code like " +  "'" + arg_sum_code + "'" + " )   " + 
    "        ORDER BY view_c_spec_const_parent.sum_code ASC  ) a, " + 
    "       c_spec_class_parent    " + 
    "    WHERE (a.sum_code = c_spec_class_parent.sum_code) " + 
     "   GROUP BY  a.sum_code,c_spec_class_parent.name       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>