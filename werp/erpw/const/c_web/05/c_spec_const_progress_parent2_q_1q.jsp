<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_col_tag = req.getParameter("arg_col_tag");
     String arg_seq = req.getParameter("arg_seq");

 //---------------------------------------------------------- 

	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
 	  dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
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
     dSet.addDataColumn(new GauceDataColumn("tot_cost_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cost_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("tot_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cost_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("pre_result_amt",GauceDataColumn.TB_DECIMAL,18,0)); 
  


	 String query = " SELECT   " + 
			"    dept_code,    " +
			"    yymm,   " +  
			"    name, " +
			"    cnt_mat_amt,    " +
			"    cnt_lab_amt,    " +
			"    cnt_exp_amt,    " +
			"    cnt_amt,    " +
			"    cnt_result_qty,    " +
			"    cnt_result_amt,    " +
			"    cnt_result_mat_amt,    " +
			"    cnt_result_lab_amt,    " +
			"    cnt_result_exp_amt,    " +
			"    ls_cnt_result_qty,    " +
			"    ls_cnt_result_mat_amt,    " +
			"    ls_cnt_result_lab_amt,    " +
			"    ls_cnt_result_exp_amt,    " +
			"    ls_cnt_result_amt,    " +
			"    cm_cnt_result_qty,    " +
			"    cm_cnt_result_mat_amt,    " +
			"    cm_cnt_result_lab_amt,    " +
			"    cm_cnt_result_exp_amt,    " +
			"    cm_cnt_result_amt,    " +
			"    cm_cnt_cost_profit,    " +
			"    mat_amt,    " +
			"    lab_amt,    " +
			"    exp_amt,    " +
			"    equ_amt,    " +
			"    sub_amt,    " +
			"    amt,    " +
			"    result_qty,    " +
			"    result_amt,    " +
			"    result_mat_amt,    " +
			"    result_lab_amt,    " +
			"    result_exp_amt,    " +
			"    result_equ_amt,    " +
			"    result_sub_amt,    " +
			"    ls_result_qty,    " +
			"    ls_result_mat_amt,    " +
			"    ls_result_lab_amt,    " +
			"    ls_result_exp_amt,    " +
			"    ls_result_equ_amt,    " +
			"    ls_result_sub_amt,    " +
			"    ls_result_amt,    " +
			"    cm_result_qty,    " +
			"    cm_result_mat_amt,    " +
			"    cm_result_lab_amt,    " +
			"    cm_result_exp_amt,    " +
			"    cm_result_equ_amt,    " +
			"    cm_result_sub_amt,    " +
			"    cm_result_amt,    " +
			"    cm_cost_profit,    " +
			"    tot_cost_qty,    " +
			"    cost_qty,    " +
			"    ls_cost_qty,    " +
			"    tot_cost_amt,    " +
			"    cost_amt,    " +
			"    ls_cost_amt,    " +
			"    pre_result_amt,    " +
			"	decode(amt,0,0,(result_amt / amt * 100 )) result_rate  ,    " +
			"	decode(amt,0,0,(cm_result_amt / amt * 100 )) cm_result_rate ,    " +
			"	decode(amt,0,0,(ls_result_amt / amt * 100 )) ls_result_rate ,    " +
			"	decode(cnt_amt,0,0,(cm_cnt_result_amt / cnt_amt * 100 )) cm_cnt_result_rate ,    " +
			"	decode(cnt_amt,0,0,(cnt_result_amt  / cnt_amt * 100 )) cnt_result_rate  ,    " +
			"	decode(cnt_amt,0,0,(ls_cnt_result_amt / cnt_amt * 100 )) ls_cnt_result_rate ,    " +
			"	decode(pre_result_amt,0,0,(tot_cost_amt / pre_result_amt * 100 )) tot_cost_rate  ,    " +
			"	decode(pre_result_amt ,0,0,(cost_amt /  pre_result_amt  * 100 )) cost_rate ,     " +
			"	decode(pre_result_amt,0,0,(ls_cost_amt /  pre_result_amt * 100 )) ls_cost_rate	,    " +
			"  seq " +
			" FROM     " +
			" (	        " +
		 " SELECT b.dept_code, " +
       "  to_date(b.yymm,'yyyy.mm.dd') yymm,  " +
		 " sum((NVL(b.CNT_MAT_AMT,0)) )CNT_MAT_AMT ,   " +
		 " sum( NVL(b.CNT_LAB_AMT,0) ) CNT_LAB_AMT,  " +
		 " sum(NVL(b.CNT_EXP_AMT,0) ) CNT_EXP_AMT,  " +
       "  sum(NVL(b.CNT_AMT,0) ) CNT_AMT,  " +
       "  sum(NVL(b.CNT_RESULT_QTY,0) ) CNT_RESULT_QTY,  " +
       "  sum(NVL(b.CNT_RESULT_AMT,0) )CNT_RESULT_AMT,  " +
       "  sum(NVL(b.CNT_RESULT_MAT_AMT,0) ) CNT_RESULT_MAT_AMT, " +
       "  sum(NVL(b.CNT_RESULT_LAB_AMT,0) ) CNT_RESULT_LAB_AMT, " +
       "  sum(NVL(b.CNT_RESULT_EXP_AMT,0) ) CNT_RESULT_EXP_AMT, " +
       "  sum(NVL(b.CNT_RESULT_RATE,0) ) CNT_RESULT_RATE, " +
       "  sum(NVL(b.LS_CNT_RESULT_QTY, 0) ) LS_CNT_RESULT_QTY, " +
       "  avg(NVL(b.LS_CNT_RESULT_RATE, 0) ) LS_CNT_RESULT_RATE, " +
       "  sum(NVL(b.LS_CNT_RESULT_MAT_AMT, 0) ) LS_CNT_RESULT_MAT_AMT, " +
       "  sum(NVL(b.LS_CNT_RESULT_LAB_AMT, 0) ) LS_CNT_RESULT_LAB_AMT, " +
       "  sum(NVL(b.LS_CNT_RESULT_EXP_AMT, 0) ) LS_CNT_RESULT_EXP_AMT, " +
		 " sum(NVL(b.LS_CNT_RESULT_AMT, 0) ) LS_CNT_RESULT_AMT, " +
	    " sum(NVL(b.CNT_RESULT_QTY, 0) + NVL(b.LS_CNT_RESULT_QTY, 0) ) CM_CNT_RESULT_QTY, " +
       "  avg(NVL(b.CNT_RESULT_RATE, 0) + NVL(b.LS_CNT_RESULT_RATE, 0) ) CM_CNT_RESULT_RATE, " +
       "  sum(NVL(b.CNT_RESULT_MAT_AMT, 0) + NVL(b.LS_CNT_RESULT_MAT_AMT, 0) ) CM_CNT_RESULT_MAT_AMT, " +
       "  sum(NVL(b.CNT_RESULT_LAB_AMT, 0) + NVL(b.LS_CNT_RESULT_LAB_AMT, 0) ) CM_CNT_RESULT_LAB_AMT, " +
       "  sum(NVL(b.CNT_RESULT_EXP_AMT, 0) + NVL(b.LS_CNT_RESULT_EXP_AMT, 0) ) CM_CNT_RESULT_EXP_AMT, " +
       "  sum(NVL(b.CNT_RESULT_AMT, 0) + NVL(b.LS_CNT_RESULT_AMT, 0) ) CM_CNT_RESULT_AMT, " +
       "  sum(((NVL(b.CNT_RESULT_AMT, 0) + NVL(b.LS_CNT_RESULT_AMT, 0)) - (NVL(b.COST_AMT,0)  + NVL(b.LS_COST_AMT, 0))) )  cm_cnt_cost_profit, " +
		 " sum(NVL(b.MAT_AMT,0) ) MAT_AMT, " +
		 " sum(NVL(b.LAB_AMT,0) ) LAB_AMT, " +
	 	 " sum(NVL(b.EXP_AMT,0) ) EXP_AMT, " +
	    " sum(NVL(b.EQU_AMT,0) ) EQU_AMT, " +
		 " sum(NVL(b.SUB_AMT,0) ) SUB_AMT, " +
       "  sum(NVL(b.AMT,0) ) AMT, " +
       "  sum(NVL(b.RESULT_QTY,0) ) RESULT_QTY, " +
       "  sum(NVL(b.RESULT_AMT,0) ) RESULT_AMT, " +
       "  sum(NVL(b.RESULT_MAT_AMT,0) ) RESULT_MAT_AMT, " +
       "  sum(NVL(b.RESULT_LAB_AMT,0) ) RESULT_LAB_AMT, " +
       "  sum(NVL(b.RESULT_EXP_AMT,0) ) RESULT_EXP_AMT, " +
       "  sum(NVL(b.RESULT_EQU_AMT,0) ) RESULT_EQU_AMT, " +
		 " sum(NVL(b.RESULT_SUB_AMT,0) ) RESULT_SUB_AMT, " +
       "  avg(NVL(b.RESULT_RATE,0) ) RESULT_RATE, " +
       "  sum(NVL(b.LS_RESULT_QTY, 0) ) LS_RESULT_QTY, " +
       "  avg(NVL(b.LS_RESULT_RATE, 0) ) LS_RESULT_RATE, " +
       "  sum(NVL(b.LS_RESULT_MAT_AMT, 0) ) LS_RESULT_MAT_AMT, " +
       "  sum(NVL(b.LS_RESULT_LAB_AMT, 0) ) LS_RESULT_LAB_AMT, " +
       "  sum(NVL(b.LS_RESULT_EXP_AMT, 0) ) LS_RESULT_EXP_AMT, " +
		 " sum(NVL(b.LS_RESULT_EQU_AMT, 0) ) LS_RESULT_EQU_AMT, " +
       "  sum(NVL(b.LS_RESULT_SUB_AMT, 0) ) LS_RESULT_SUB_AMT, " +
		 " sum(NVL(b.LS_RESULT_AMT, 0)  )LS_RESULT_AMT, " +
		 " sum(NVL(b.RESULT_QTY, 0) + NVL(b.LS_RESULT_QTY, 0) ) CM_RESULT_QTY, " +
       "  avg(NVL(b.RESULT_RATE, 0) + NVL(b.LS_RESULT_RATE, 0)  )CM_RESULT_RATE, " +
       "  sum(NVL(b.RESULT_MAT_AMT, 0) + NVL(b.LS_RESULT_MAT_AMT, 0) ) CM_RESULT_MAT_AMT, " +
       "  sum(NVL(b.RESULT_LAB_AMT, 0) + NVL(b.LS_RESULT_LAB_AMT, 0) ) CM_RESULT_LAB_AMT, " +
       "  sum(NVL(b.RESULT_EXP_AMT, 0) + NVL(b.LS_RESULT_EXP_AMT, 0) ) CM_RESULT_EXP_AMT, " +
       "  sum(NVL(b.RESULT_EQU_AMT, 0) + NVL(b.LS_RESULT_EQU_AMT, 0) ) CM_RESULT_EQU_AMT, " +
       "  sum(NVL(b.RESULT_SUB_AMT, 0) + NVL(b.LS_RESULT_SUB_AMT, 0) ) CM_RESULT_SUB_AMT, " +
       "  sum(NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0) ) CM_RESULT_AMT, " +
       "  sum(((NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0)) - (NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0))))  cm_cost_profit, " +
		 " sum(NVL(b.COST_QTY,0) + NVL(b.LS_COST_QTY, 0) ) TOT_COST_QTY, " +
		 " sum(NVL(b.COST_QTY,0)  ) COST_QTY, " +
		 " sum(NVL(b.LS_COST_QTY,0)  ) LS_COST_QTY, " +
		 " sum(NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0) ) TOT_COST_AMT, " +
		 " sum(NVL(b.COST_AMT,0)  ) COST_AMT, " +
		 " sum(NVL(b.LS_COST_AMT,0) )LS_COST_AMT, " +
		 " avg(NVL(b.COST_RATE,0) + NVL(b.LS_COST_RATE, 0) )TOT_COST_RATE, " +
       "  avg(NVL(b.COST_RATE,0)  )COST_RATE1, " +
       "  avg(NVL(b.LS_COST_RATE,0)  )LS_COST_RATE, " +
       "  sum(NVL(b.PRE_RESULT_AMT,0)  )PRE_RESULT_AMT  , " ;
if ( ( arg_col_tag.length() == 0 ) && ( arg_seq.length() < 2 ) )
{
	query +=   "	 decode(a.col_tag,'M','재료','L','노무','X','경비','S','외주',null,'[미연계]') name , " +
					"   decode(col_tag,'L','13','M','12','X','14','S','11',null,'999' ) seq " +
					"    FROM Y_BUDGET_DETAIL  a,  " +
					"         C_SPEC_CONST_DETAIL b  " +
					"   WHERE ( b.dept_code    = a.dept_code ) and " +
					"         ( b.spec_no_seq     = a.spec_no_seq ) and " +
					"         ( a.spec_unq_num = b.spec_unq_num ) and" + 
					"         ( b.dept_code    = '"+arg_dept_code+"') AND " +
					"         ( b.yymm         = '"+arg_yymm+"')  " +
					"group by   " +
					"b.dept_code,  " +
					"to_date(b.yymm,'yyyy.mm.dd') ,  " +
					"a.col_tag  " +
					"order by seq  )" ;
}
else if ( ( arg_col_tag.length() != 0 ) && arg_seq.length() > 1 && arg_seq.length() < 3)
{
query +=	 "nvl(a.cat_text,'[미연계]') name ,  '' seq" +
				  "  FROM Y_BUDGET_DETAIL  a, " +
				  "       C_SPEC_CONST_DETAIL b " +
				  " WHERE ( b.dept_code    = a.dept_code ) and " +
				  "       ( b.spec_no_seq     = a.spec_no_seq ) and " +
				  "       ( a.spec_unq_num = b.spec_unq_num ) and" + 
				  "       ( b.dept_code    = '"+arg_dept_code+"') AND " +
				  "       ( b.yymm         = '"+arg_yymm+"') and " +
	           " ( a.col_tag  = '"+arg_col_tag+"') " + 
	           " group by  " +
				  " b.dept_code, " +
				  " to_date(b.yymm,'yyyy.mm.dd') , " +
				  " a.cat_text  " + 
	           " order by a.cat_text  )";
}
else
{
query +=	 "nvl(a.cat_text,'[미연계]') name ,'' seq" +
				  "  FROM Y_BUDGET_DETAIL  a, " +
				  "       C_SPEC_CONST_DETAIL b " +
				  " WHERE ( b.dept_code    = a.dept_code ) and " +
				  "       ( b.spec_no_seq     = a.spec_no_seq ) and " +
				  "       ( b.dept_code    = '"+arg_dept_code+"') AND " +
				  "       ( a.spec_unq_num = b.spec_unq_num ) and" + 
				  "       ( b.yymm         = '"+arg_yymm+"') and " +
	           " ( a.col_tag is null) " + 
	           " group by  " +
				  " b.dept_code, " +
				  " to_date(b.yymm,'yyyy.mm.dd') , " +
				  " a.cat_text  " + 
	           " order by a.cat_text )";


}

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>