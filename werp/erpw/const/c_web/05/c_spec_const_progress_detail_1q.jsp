<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_cost_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ls_result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("ls_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cm_result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("cm_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cost_profit",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cost_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cost_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("tot_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("sup_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sup_unit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sup_unit_fix",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mat_unit_fix",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,500));
    String query = "  SELECT b.dept_code,   " + 
     "         to_char(b.yymm,'yyyy.mm.dd') yymm," + 
     "         b.spec_no_seq," + 
     "         b.spec_unq_num," + 
     "         a.detail_code,   " + 
     "         a.res_class,   " + 
     "         a.no_seq," + 
     "         a.name,   " + 
     "         a.ssize,   " + 
     "         a.unit," + 
     "			NVL(b.CNT_QTY,0) CNT_QTY, " + 
     "			NVL(b.CNT_PRICE,0) CNT_PRICE, " + 
     "         NVL(b.CNT_AMT,0) CNT_AMT," + 
     "         NVL(b.CNT_RESULT_QTY,0) CNT_RESULT_QTY," + 
     "         NVL(b.CNT_RESULT_RATE,0) CNT_RESULT_RATE," + 
     "			NVL(b.CNT_RESULT_AMT,0) CNT_RESULT_AMT," + 
     "         NVL(b.LS_CNT_RESULT_QTY, 0) LS_CNT_RESULT_QTY," + 
     "         NVL(b.LS_CNT_RESULT_RATE, 0) LS_CNT_RESULT_RATE,	" + 
     "			NVL(b.LS_CNT_RESULT_AMT, 0) LS_CNT_RESULT_AMT, " + 
     "			NVL(b.CNT_RESULT_QTY, 0) + NVL(b.LS_CNT_RESULT_QTY, 0) CM_CNT_RESULT_QTY," + 
     "         NVL(b.CNT_RESULT_RATE, 0) + NVL(b.LS_CNT_RESULT_RATE, 0) CM_CNT_RESULT_RATE," + 
     "         NVL(b.CNT_RESULT_AMT, 0) + NVL(b.LS_CNT_RESULT_AMT, 0) CM_CNT_RESULT_AMT," + 
     "         ((NVL(b.CNT_RESULT_AMT, 0) + NVL(b.LS_CNT_RESULT_AMT, 0)) - (NVL(b.COST_AMT,0)  + NVL(b.LS_COST_AMT, 0)))  cm_cnt_cost_profit," + 
     "			NVL(b.QTY,0) QTY," + 
     "			NVL(b.PRICE,0) PRICE," + 
     "			NVL(b.SUB_AMT,0) SUB_AMT,  " + 
     "         NVL(b.AMT,0) AMT," + 
     "         NVL(b.RESULT_QTY,0) RESULT_QTY," + 
     "         NVL(b.RESULT_RATE,0) RESULT_RATE," + 
     "			NVL(b.RESULT_AMT,0) RESULT_AMT," + 
     "         NVL(b.LS_RESULT_QTY, 0) LS_RESULT_QTY," + 
     "         NVL(b.LS_RESULT_RATE, 0) LS_RESULT_RATE,	" + 
     "			NVL(b.LS_RESULT_AMT, 0) LS_RESULT_AMT,         " + 
     "			NVL(b.RESULT_QTY, 0) + NVL(b.LS_RESULT_QTY, 0) CM_RESULT_QTY," + 
     "         NVL(b.RESULT_RATE, 0) + NVL(b.LS_RESULT_RATE, 0) CM_RESULT_RATE," + 
     "         NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0) CM_RESULT_AMT," + 
     "         ((NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0)) - (NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0))) cm_cost_profit," + 
     "			NVL(b.COST_QTY,0)  + NVL(b.LS_COST_QTY, 0) TOT_COST_QTY," + 
     "			NVL(b.COST_QTY,0)  COST_QTY," + 
     "			NVL(b.LS_COST_QTY,0)  LS_COST_QTY," + 
	  "			NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0) TOT_COST_AMT," + 
     "			NVL(b.COST_AMT,0)  COST_AMT," + 
     "			NVL(b.LS_COST_AMT,0)  LS_COST_AMT," + 
	  "         NVL(b.PRE_RESULT_AMT,0) PRE_RESULT_AMT, " + 
	  "	 decode( NVL(b.pre_result_amt, 0), 0, 0 ,(NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0)) / NVL(b.pre_result_amt, 0) * 100)  TOT_COST_RATE,  " +
     "   decode( NVL(pre_result_amt,0),0,0, NVL(b.COST_AMT,0) / pre_result_amt * 100) COST_RATE,  " +
     "   decode( NVL(pre_result_amt,0),0,0, NVL(b.LS_COST_AMT,0) / pre_result_amt * 100) LS_COST_RATE, " +  
     "         NVL(b.SUP_QTY,0) SUP_QTY, " + 
     "         NVL(b.SUP_UNIT_AMT,0) SUP_UNIT_AMT, " + 
     "         b.SUP_UNIT_FIX, " + 
     "         b.MAT_UNIT_FIX,  " + 
     "         b.remark  " + 
     "    FROM Y_BUDGET_DETAIL a," + 
     "         C_SPEC_CONST_DETAIL b " + 
     "   WHERE ( a.dept_code    = b.dept_code ) and" + 
     "         ( a.spec_no_seq     = b.spec_no_seq) and" + 
     "         ( a.spec_unq_num = b.spec_unq_num ) and" + 
     "         ( a.dept_code    = '" + arg_dept_code + "') AND  " + 
     "         ( b.yymm         = '" + arg_yymm + "') and" + 
     "         ( a.spec_no_seq     = " + arg_spec_no_seq + ")   " + 
     "ORDER BY a.no_seq ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>