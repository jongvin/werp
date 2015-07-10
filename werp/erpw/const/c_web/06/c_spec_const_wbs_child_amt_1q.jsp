<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
     String arg_ea = req.getParameter("arg_ea");
 //-------------------------------------------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,70));
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
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,500));
    String query = "  SELECT    " + 
     "         y_budget_detail.name || '/' || y_budget_detail.ssize || '/' || y_budget_detail.unit  name,   " + 
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
     "         A.spec_unq_num  spec_unq_num,  " +  
     "         A.cost_rate, " +
     "         A.ls_cost_rate, " +
     "         A.result_rate, " +
     "         a.remark  " +  
     "   FROM  y_budget_detail,c_spec_const_detail A   " + 
     "          WHERE ( y_budget_detail.dept_code =  A.dept_code   ) and  " + 
     "                ( y_budget_detail.spec_no_seq = A.spec_no_seq) and  " + 
     "                ( y_budget_detail.spec_unq_num = A.spec_unq_num) and  " + 
     "                ( A.dept_code = " + "'" + arg_dept_code + "'" + ") and  " + 
     "                 ( A.yymm = " + "'" + arg_yymm + "'" + ")  and " + 
     "                 ( A.spec_no_seq = " + arg_spec_no_seq + "  ) " + 
     "      ORDER BY y_budget_detail.no_seq ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>