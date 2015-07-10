<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
     String arg_ea = req.getParameter("arg_ea");
 //-------------------------------------------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("result_rate",GauceDataColumn.TB_DECIMAL,5,2));
    String query = "  SELECT y_budget_parent.dept_code dept_code,   " + 
     "         y_budget_parent.no_seq no_seq,   " + 
     "         y_budget_parent.sum_code sum_code,    " + 
     "         y_budget_parent.parent_sum_code parent_sum_code,   " + 
     "         y_budget_parent.llevel llevel,   " + 
     "         y_budget_parent.name name,   " + 
     "         A.cnt_amt/" + arg_ea + " cnt_amt,   " + 
     "         A.amt/" + arg_ea + " amt," + 
     "         NVL(A.cnt_result_amt,0)/" + arg_ea + " cnt_result_amt,   " + 
     "         NVL(A.result_amt,0)/" + arg_ea + " result_amt,    " + 
     "         NVL(A.cost_amt,0)/" + arg_ea + " cost_amt,    " + 
     "         NVL(A.cost_mat_amt,0)/" + arg_ea + " cost_mat_amt,    " + 
     "         NVL(A.cost_sub_amt,0)/" + arg_ea + " cost_sub_amt,    " + 
     "         NVL(A.cost_lab_amt,0)/" + arg_ea + " cost_lab_amt,    " + 
     "         NVL(A.cost_exp_amt,0)/" + arg_ea + " + NVL(A.cost_equ_amt,0)/" + arg_ea + "  cost_exp_amt,    " + 
     "         NVL(A.pre_result_amt,0)/" + arg_ea + " pre_result_amt,    " + 
     "         NVL(A.cnt_result_amt,0)/" + arg_ea + " + NVL(A.ls_cnt_result_amt,0)/" + arg_ea + "  ls_cnt_result_amt,    " + 
     "         NVL(A.result_amt,0)/" + arg_ea + "  + NVL(A.ls_result_amt,0)/" + arg_ea + " ls_result_amt,    " + 
     "         NVL(A.cost_amt,0)/" + arg_ea + " + NVL(A.ls_cost_amt,0) /" + arg_ea + " ls_cost_amt,    " + 
     "         NVL(A.cost_mat_amt,0)/" + arg_ea + "  + NVL(A.ls_cost_mat_amt,0)/" + arg_ea + " ls_cost_mat_amt,    " + 
     "         NVL(A.cost_sub_amt,0)/" + arg_ea + " +  NVL(A.ls_cost_sub_amt,0)/" + arg_ea + " ls_cost_sub_amt,    " + 
     "         NVL(A.cost_lab_amt,0)/" + arg_ea + " + NVL(A.ls_cost_lab_amt,0)/" + arg_ea + " ls_cost_lab_amt,    " + 
     "         NVL(A.cost_exp_amt,0)/" + arg_ea + " + NVL(A.ls_cost_exp_amt,0) /" + arg_ea + " + NVL(A.cost_equ_amt,0)/" + arg_ea + " + NVL(A.ls_cost_equ_amt,0)/" + arg_ea + " ls_cost_exp_amt,   " + 
     "         (NVL(A.cnt_result_amt,0) - NVL(A.cost_amt,0)) / " + arg_ea + "  cnt_profit,   " + 
     "         (NVL(A.result_amt,0) - NVL(A.cost_amt,0)) / " + arg_ea + "  profit,   " + 
     "         ((NVL(A.cnt_result_amt,0) + NVL(A.ls_cnt_result_amt,0)) - (NVL(A.cost_amt,0) + NVL(A.ls_cost_amt,0))) / " + arg_ea + "  ls_cnt_profit, " +    
     "         ((NVL(A.result_amt,0) + NVL(A.ls_result_amt,0)) - (NVL(A.cost_amt,0) + NVL(A.ls_cost_amt,0))) / " + arg_ea + "  ls_profit,  " +  
     "         A.cost_rate, " +
     "			A.ls_cost_rate, " +
     "         A.result_rate " +
     "   FROM (  " + 
     "      SELECT c_spec_const_parent.dept_code," + 
     "             c_spec_const_parent.spec_no_seq," + 
     "             c_spec_const_parent.cnt_result_amt,   " + 
     "             c_spec_const_parent.result_amt,   " + 
     "             c_spec_const_parent.cost_amt,   " + 
     "             c_spec_const_parent.cost_mat_amt,   " + 
     "             c_spec_const_parent.cost_sub_amt,   " + 
     "             c_spec_const_parent.cost_lab_amt,   " + 
     "             c_spec_const_parent.cost_equ_amt,   " + 
     "             c_spec_const_parent.cost_exp_amt,   " + 
     "             c_spec_const_parent.pre_result_amt,   " + 
     "             c_spec_const_parent.ls_cnt_result_amt,   " + 
     "             c_spec_const_parent.ls_result_amt,   " + 
     "             c_spec_const_parent.ls_cost_amt,   " + 
     "             c_spec_const_parent.ls_cost_mat_amt,   " + 
     "             c_spec_const_parent.ls_cost_sub_amt,   " + 
     "             c_spec_const_parent.ls_cost_lab_amt,   " + 
     "             c_spec_const_parent.ls_cost_equ_amt,   " + 
     "             c_spec_const_parent.ls_cost_exp_amt,  " + 
     "             c_spec_const_parent.amt,  " + 
     "             c_spec_const_parent.cnt_amt,  " + 
     "             c_spec_const_parent.cost_rate, " +
     "             c_spec_const_parent.ls_cost_rate, " +
     "				 c_spec_const_parent.result_rate " +
     "          FROM  c_spec_const_parent  " + 
     "          WHERE (( c_spec_const_parent.dept_code = " + "'" + arg_dept_code + "'" + ") AND  " + 
     "                ( c_spec_const_parent.yymm = " + "'" + arg_yymm + "'" + "))  ) A, y_budget_parent" + 
     "     WHERE (( y_budget_parent.dept_code = A.dept_code (+)) and" + 
     "           ( y_budget_parent.spec_no_seq = A.spec_no_seq (+)) and" + 
     "           ( y_budget_parent.dept_code = " + "'" + arg_dept_code + "'" + ") and" + 
     "           ( y_budget_parent.parent_sum_code = " + "'" + arg_parent_sum_code + "'" + "))" + 
     "ORDER BY y_budget_parent.no_seq ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>