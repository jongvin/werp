<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sum_code = req.getParameter("arg_sum_code");
     String arg_ea = req.getParameter("arg_ea");
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_plan_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_amt_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_amt_profit",GauceDataColumn.TB_DECIMAL,18,0));
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
    String query = "    SELECT    c_spec_class_parent.name name," + 
     "              to_char(a.yymm,'yyyy.mm') yymm,   " + 
     "              NVL(sum(a.cnt_plan_amt),0) / " + arg_ea + " cnt_plan_amt," + 
     "              NVL(sum(a.plan_amt),0) / " + arg_ea + " plan_amt," + 
     "              NVL(sum(a.ls_cnt_plan_amt),0) / " + arg_ea + " ls_cnt_plan_amt," + 
     "              NVL(sum(a.ls_plan_amt),0) / " + arg_ea + " ls_plan_amt, " + 
     "              (NVL(sum(a.cnt_plan_amt),0) - NVL(sum(a.plan_amt),0)) / " + arg_ea + " plan_profit," + 
     "              (NVL(sum(a.ls_cnt_plan_amt),0) - NVL(sum(a.ls_plan_amt),0)) / " + arg_ea + " ls_plan_profit," + 
     "              (sum(a.cnt_result_amt) - sum(a.result_amt)) / " + arg_ea + " result_amt_profit," + 
     "              ((sum(a.cnt_result_amt) + sum(a.ls_cnt_result_amt)) - (sum(a.ls_result_amt) + sum(a.result_amt))) / " + arg_ea + " ls_result_amt_profit," + 
     "              sum(a.cnt_result_amt) / " + arg_ea + " cnt_result_amt,    " + 
     "              sum(a.result_amt) / " + arg_ea + " result_amt,    " + 
     "              sum(a.cost_amt) / " + arg_ea + " cost_amt,    " + 
     "              (sum(a.ls_cnt_result_amt) / " + arg_ea + " ) + (sum(a.cnt_result_amt) / " + arg_ea + " ) ls_cnt_result_amt,    " + 
     "              (sum(a.ls_result_amt) / " + arg_ea + " ) + (sum(a.result_amt) / " + arg_ea + " )  ls_result_amt,    " + 
     "              (sum(a.ls_cost_amt) / " + arg_ea + " ) + (sum(a.cost_amt) / " + arg_ea + ")  ls_cost_amt,    " + 
     "              sum(a.cnt_amt) / " + arg_ea + " cnt_amt,    " + 
     "              sum(a.amt) / " + arg_ea + " amt,    " + 
     "              (sum(a.cnt_result_amt) - sum(a.cost_amt)) / " + arg_ea + "  cnt_profit,    " + 
     "              (sum(a.result_amt) - sum(a.cost_amt)) / " + arg_ea + "  profit,    " + 
     "              ((sum(a.cnt_result_amt) + sum(a.ls_cnt_result_amt)) - (sum(a.cost_amt) + sum(a.ls_cost_amt))) / " + arg_ea + "  ls_cnt_profit,    " + 
     "              ((sum(a.result_amt) + sum(a.ls_result_amt)) - (sum(a.cost_amt) + sum(a.ls_cost_amt))) / " + arg_ea + "  ls_profit,    " + 
     "              sum(a.pre_result_amt) / " + arg_ea + "  pre_result_amt  " + 
     "        from ( SELECT '" + arg_sum_code + "' sum_code," + 
     "			              view_c_spec_const_parent.yymm,    " + 
     "			              0 cnt_plan_amt,    " + 
     "			              0 plan_amt,    " + 
     "			              0 ls_cnt_plan_amt,    " + 
     "			              0 ls_plan_amt,    " + 
     "			              NVL(sum(view_c_spec_const_parent.cnt_result_amt),0) cnt_result_amt,    " + 
     "			              NVL(sum(view_c_spec_const_parent.result_amt),0) result_amt,    " + 
     "			              NVL(sum(view_c_spec_const_parent.cost_amt),0) cost_amt,    " + 
     "			              NVL(sum(view_c_spec_const_parent.ls_cnt_result_amt),0) ls_cnt_result_amt,    " + 
     "			              NVL(sum(view_c_spec_const_parent.ls_result_amt),0) ls_result_amt,    " + 
     "			              NVL(sum(view_c_spec_const_parent.ls_cost_amt),0) ls_cost_amt,    " + 
     "			              NVL(sum(view_c_spec_const_parent.cnt_amt),0) cnt_amt ,    " + 
     "			              NVL(sum(view_c_spec_const_parent.amt),0) amt,    " + 
     "			              NVL(sum(view_c_spec_const_parent.pre_result_amt),0)  pre_result_amt   " + 
     "                 FROM view_c_spec_const_parent,z_code_dept z   " + 
     "                 WHERE ( view_c_spec_const_parent.sum_code like '" + arg_sum_code + "%' )  and  " + 
     "                       ( z.dept_code = view_c_spec_const_parent.dept_code ) and " + 
     "                       ( to_char(view_c_spec_const_parent.yymm,'YYYY') = '" + arg_year + "') and " + 
     "                       ( z.chg_const_start_date is not null ) and " + 
     "                       ( to_char(z.chg_const_start_date,'YYYY') <= '" + arg_year + "') and   " + 
     "                       ( to_char(z.chg_const_end_date,'YYYY') >= '" + arg_year + "')   " +    
     "                 GROUP BY sum_code," + 
     "                           view_c_spec_const_parent.yymm    " + 
     "             union all     " + 
     "				  SELECT '" + arg_sum_code + "' sum_code,   " + 
     "				          c_spec_sum_code_plan.yymm,   " + 
     "				         NVL(sum(cnt_plan_amt),0) cnt_plan_amt, " + 
     "				         NVL(sum(plan_amt),0) plan_amt," + 
     "				         NVL(sum(ls_cnt_plan_amt),0) ls_cnt_plan_amt," + 
     "				         NVL(sum(ls_plan_amt),0) ls_plan_amt,   " + 
     "			              0 cnt_result_amt,    " + 
     "			              0 result_amt,    " + 
     "			              0 cost_amt,    " + 
     "			              0 ls_cnt_result_amt,    " + 
     "			              0 ls_result_amt,    " + 
     "			              0 ls_cost_amt,    " + 
     "			              0 cnt_amt,    " + 
     "			              0 amt,    " + 
     "			              0 pre_result_amt    " + 
     "				    FROM c_spec_class_child,   " + 
     "				         c_spec_class_parent,   " + 
     "				         c_spec_sum_code_plan,  " + 
     "				         z_code_dept z  " + 
     "				   WHERE ( c_spec_class_parent.spec_no_seq = c_spec_class_child.spec_no_seq ) and  " + 
     "				         ( c_spec_sum_code_plan.dept_code = c_spec_class_child.dept_code ) and  " + 
     "				         (  c_spec_class_parent.sum_code like '" + arg_sum_code + "%' ) and    " + 
     "                       ( to_char(c_spec_sum_code_plan.yymm,'YYYY') = '" + arg_year + "') and " + 
     "                       ( z.dept_code = c_spec_class_child.dept_code ) and " + 
     "                       ( z.chg_const_start_date is not null ) and " + 
     "                       ( to_char(z.chg_const_start_date,'YYYY') <= '" + arg_year + "') and   " + 
     "                       ( to_char(z.chg_const_end_date,'YYYY') >= '" + arg_year + "')   " +    
     "				   GROUP BY sum_code,   " + 
     "				            c_spec_sum_code_plan.yymm ) a,   " + 
     "            c_spec_class_parent     " + 
     "        WHERE (a.sum_code = c_spec_class_parent.sum_code)  " + 
     "        GROUP BY  c_spec_class_parent.name,a.yymm        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>