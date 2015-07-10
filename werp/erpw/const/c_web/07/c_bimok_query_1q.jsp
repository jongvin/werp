<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "     " + 
                   " select '1' tag,                                                 " + 
                   "        a.mat_amt amt,                                               " + 
                   "        a.result_mat_amt result_amt,                                        " + 
                   "        a.result_mat_amt + ls_result_mat_amt tot_amt,            " + 
                   "        a.cost_mat_amt cost_amt,                                          " + 
                   "        a.cost_mat_amt + ls_cost_mat_amt tot_cost_amt       " + 
                   "   from c_spec_const_parent a,                                   " + 
                   "        y_budget_parent b                                        " + 
                   "   where a.dept_code = '" + arg_dept_code + "'                                   " + 
                   "     and a.yymm = '" + arg_yymm + "'                                   " + 
                   "     and a.spec_no_seq = b.spec_no_seq                           " + 
                   "     and b.sum_code = '01'                                       " + 
                   " union all                                                       " + 
                   " select '2',                                                     " + 
                   "        a.lab_amt,                                               " + 
                   "        a.result_lab_amt,                                        " + 
                   "        a.result_lab_amt + ls_result_lab_amt,                    " + 
                   "        a.cost_lab_amt,                                          " + 
                   "        a.cost_lab_amt + ls_cost_lab_amt                         " + 
                   "   from c_spec_const_parent a,                                   " + 
                   "        y_budget_parent b                                        " + 
                   "   where a.dept_code = '" + arg_dept_code + "'                                   " + 
                   "     and a.yymm = '" + arg_yymm + "'                                   " + 
                   "     and a.spec_no_seq = b.spec_no_seq                           " + 
                   "     and b.sum_code = '01'                                       " + 
                   " union all                                                       " + 
                   " select '3',                                                     " + 
                   "        a.sub_amt,                                               " + 
                   "        a.result_sub_amt,                                        " + 
                   "        a.result_sub_amt + ls_result_sub_amt,                    " + 
                   "        a.cost_sub_amt,                                          " + 
                   "        a.cost_sub_amt + ls_cost_sub_amt                         " + 
                   "   from c_spec_const_parent a,                                   " + 
                   "        y_budget_parent b                                        " + 
                   "   where a.dept_code = '" + arg_dept_code + "'                                   " + 
                   "     and a.yymm = '" + arg_yymm + "'                                   " + 
                   "     and a.spec_no_seq = b.spec_no_seq                           " + 
                   "     and b.sum_code = '01'                                       " + 
                   " union all                                                       " + 
                   " select '4',                                                     " + 
                   "        a.exp_amt,                                               " + 
                   "        a.result_exp_amt,                                        " + 
                   "        a.result_exp_amt + ls_result_exp_amt,                    " + 
                   "        a.cost_exp_amt,                                          " + 
                   "        a.cost_exp_amt + ls_cost_exp_amt                         " + 
                   "   from c_spec_const_parent a,                                   " + 
                   "        y_budget_parent b                                        " + 
                   "   where a.dept_code = '" + arg_dept_code + "'                                   " + 
                   "     and a.yymm = '" + arg_yymm + "'                                   " + 
                   "     and a.spec_no_seq = b.spec_no_seq                           " + 
                   "     and b.sum_code = '01'  "; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>