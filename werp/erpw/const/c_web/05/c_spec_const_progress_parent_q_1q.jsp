<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invest_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_cost_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_equ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ls_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ls_result_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ls_result_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_equ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cm_result_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cm_result_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_result_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_result_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_result_equ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_result_sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cost_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cost_qty1",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("cost_rate1",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("pre_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT b.dept_code,    " + 
     "         to_date(b.yymm,'yyyy.mm.dd') yymm, " + 
     "         a.SUM_CODE,    " + 
     "         a.parent_sum_code, " + 
     "         a.DIRECT_CLASS, " + 
     "         a.no_SEQ, " + 
     "         a.LLEVEL,   " + 
     "         a.INVEST_CLASS,  " + 
     "         a.NAME,  " + 
     "         a.SSIZE,   " + 
     "         a.UNIT,   " + 
     "			NVL(b.CNT_MAT_AMT,0) CNT_MAT_AMT, " + 
     "			NVL(b.CNT_LAB_AMT,0) CNT_LAB_AMT, " + 
     "			NVL(b.CNT_EXP_AMT,0) CNT_EXP_AMT,   " + 
     "         NVL(b.CNT_AMT,0) CNT_AMT, " + 
     "         NVL(b.CNT_RESULT_QTY,0) CNT_RESULT_QTY, " + 
     "         NVL(b.CNT_RESULT_AMT,0) CNT_RESULT_AMT, " + 
     "         NVL(b.CNT_RESULT_MAT_AMT,0) CNT_RESULT_MAT_AMT, " + 
     "         NVL(b.CNT_RESULT_LAB_AMT,0) CNT_RESULT_LAB_AMT, " + 
     "         NVL(b.CNT_RESULT_EXP_AMT,0) CNT_RESULT_EXP_AMT, " + 
     "         NVL(b.CNT_RESULT_RATE,0) CNT_RESULT_RATE, " + 
     "         NVL(b.LS_CNT_RESULT_QTY, 0) LS_CNT_RESULT_QTY, " + 
     "         NVL(b.LS_CNT_RESULT_RATE, 0) LS_CNT_RESULT_RATE, 	" + 
     "         NVL(b.LS_CNT_RESULT_MAT_AMT, 0) LS_CNT_RESULT_MAT_AMT, " + 
     "         NVL(b.LS_CNT_RESULT_LAB_AMT, 0) LS_CNT_RESULT_LAB_AMT, " + 
     "         NVL(b.LS_CNT_RESULT_EXP_AMT, 0) LS_CNT_RESULT_EXP_AMT, " + 
     "			NVL(b.LS_CNT_RESULT_AMT, 0) LS_CNT_RESULT_AMT, " + 
     "			NVL(b.CNT_RESULT_QTY, 0) + NVL(b.LS_CNT_RESULT_QTY, 0) CM_CNT_RESULT_QTY, " + 
     "         NVL(b.CNT_RESULT_RATE, 0) + NVL(b.LS_CNT_RESULT_RATE, 0) CM_CNT_RESULT_RATE, " + 
     "         NVL(b.CNT_RESULT_MAT_AMT, 0) + NVL(b.LS_CNT_RESULT_MAT_AMT, 0) CM_CNT_RESULT_MAT_AMT, " + 
     "         NVL(b.CNT_RESULT_LAB_AMT, 0) + NVL(b.LS_CNT_RESULT_LAB_AMT, 0) CM_CNT_RESULT_LAB_AMT, " + 
     "         NVL(b.CNT_RESULT_EXP_AMT, 0) + NVL(b.LS_CNT_RESULT_EXP_AMT, 0) CM_CNT_RESULT_EXP_AMT, " + 
     "         NVL(b.CNT_RESULT_AMT, 0) + NVL(b.LS_CNT_RESULT_AMT, 0) CM_CNT_RESULT_AMT, " + 
     "         ((NVL(b.CNT_RESULT_AMT, 0) + NVL(b.LS_CNT_RESULT_AMT, 0)) - (NVL(b.COST_AMT,0)  + NVL(b.LS_COST_AMT, 0)))  cm_cnt_cost_profit," + 
     "			NVL(b.MAT_AMT,0) MAT_AMT, " + 
     "			NVL(b.LAB_AMT,0) LAB_AMT, " + 
     "			NVL(b.EXP_AMT,0) EXP_AMT, " + 
     "			NVL(b.EQU_AMT,0) EQU_AMT, " + 
     "			NVL(b.SUB_AMT,0) SUB_AMT,    " + 
     "         NVL(b.AMT,0) AMT, " + 
     "         NVL(b.RESULT_QTY,0) RESULT_QTY, " + 
     "         NVL(b.RESULT_AMT,0) RESULT_AMT, " + 
     "         NVL(b.RESULT_MAT_AMT,0) RESULT_MAT_AMT, " + 
     "         NVL(b.RESULT_LAB_AMT,0) RESULT_LAB_AMT, " + 
     "         NVL(b.RESULT_EXP_AMT,0) RESULT_EXP_AMT, " + 
     "         NVL(b.RESULT_EQU_AMT,0) RESULT_EQU_AMT, " + 
     "			NVL(b.RESULT_SUB_AMT,0) RESULT_SUB_AMT,   " + 
     "         NVL(b.RESULT_RATE,0) RESULT_RATE, " + 
     "         NVL(b.LS_RESULT_QTY, 0) LS_RESULT_QTY, " + 
     "         NVL(b.LS_RESULT_RATE, 0) LS_RESULT_RATE, 	" + 
     "         NVL(b.LS_RESULT_MAT_AMT, 0) LS_RESULT_MAT_AMT, " + 
     "         NVL(b.LS_RESULT_LAB_AMT, 0) LS_RESULT_LAB_AMT, " + 
     "         NVL(b.LS_RESULT_EXP_AMT, 0) LS_RESULT_EXP_AMT, " + 
     "			NVL(b.LS_RESULT_EQU_AMT, 0) LS_RESULT_EQU_AMT, " + 
     "         NVL(b.LS_RESULT_SUB_AMT, 0) LS_RESULT_SUB_AMT, " + 
     "			NVL(b.LS_RESULT_AMT, 0) LS_RESULT_AMT, " + 
     "			NVL(b.RESULT_QTY, 0) + NVL(b.LS_RESULT_QTY, 0) CM_RESULT_QTY, " + 
     "         NVL(b.RESULT_RATE, 0) + NVL(b.LS_RESULT_RATE, 0) CM_RESULT_RATE, " + 
     "         NVL(b.RESULT_MAT_AMT, 0) + NVL(b.LS_RESULT_MAT_AMT, 0) CM_RESULT_MAT_AMT, " + 
     "         NVL(b.RESULT_LAB_AMT, 0) + NVL(b.LS_RESULT_LAB_AMT, 0) CM_RESULT_LAB_AMT, " + 
     "         NVL(b.RESULT_EXP_AMT, 0) + NVL(b.LS_RESULT_EXP_AMT, 0) CM_RESULT_EXP_AMT, " + 
     "         NVL(b.RESULT_EQU_AMT, 0) + NVL(b.LS_RESULT_EQU_AMT, 0) CM_RESULT_EQU_AMT, " + 
     "         NVL(b.RESULT_SUB_AMT, 0) + NVL(b.LS_RESULT_SUB_AMT, 0) CM_RESULT_SUB_AMT, " + 
     "         NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0) CM_RESULT_AMT, " + 
     "         ((NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0)) - (NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0))) cm_cost_profit," + 
     "			NVL(b.COST_QTY,0) + NVL(b.LS_COST_QTY, 0) COST_QTY, " + 
     "			NVL(b.COST_QTY,0)  COST_QTY1, " + 
     "			NVL(b.LS_COST_QTY,0)  LS_COST_QTY, " + 
	  "			NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0) COST_AMT, " + 
     "			NVL(b.COST_AMT,0)  COST_AMT1, " + 
     "			NVL(b.LS_COST_AMT,0) LS_COST_AMT, " + 
	  "			NVL(b.COST_RATE,0) + NVL(b.LS_COST_RATE, 0) COST_RATE," + 
     "         NVL(b.COST_RATE,0) COST_RATE1, " + 
     "         NVL(b.LS_COST_RATE,0) LS_COST_RATE, " + 
     "         NVL(b.PRE_RESULT_AMT,0) PRE_RESULT_AMT " + 
    "    FROM Y_BUDGET_parent a, " + 
     "         C_SPEC_CONST_parent b  " + 
     "   WHERE ( b.dept_code    = a.dept_code ) and " + 
     "         ( b.spec_no_seq     = a.spec_no_seq ) and " + 
     "         ( b.dept_code    = '" + arg_dept_code + "') AND " + 
     "         ( b.yymm         = '" + arg_yymm + "')  and " + 
     "         ( a.parent_sum_code       = '" + arg_parent_sum_code  + "')  " + 
     "ORDER BY b.dept_code ASC, " + 
     "         a.no_SEQ ASC     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>