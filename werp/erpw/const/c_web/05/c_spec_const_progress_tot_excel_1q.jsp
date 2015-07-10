<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
     arg_parent_sum_code = arg_parent_sum_code + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
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
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("ls_cnt_result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("cm_cnt_result_rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("col_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cat_text",GauceDataColumn.TB_STRING,20));


    String query = " select     z_code_dept.long_name, " + 
     "                  a.no_seq, " + 
     "                  a.llevel, " + 
     "     					a.sum_code, " + 
     "     					a.parent_sum_code," + 
     "						a.direct_class," + 
     "     					decode(a.tag,'1',F_PARENT_NAME(a.dept_code,a.sum_code,a.llevel + 1),a.name) name, " + 
     "     					a.ssize, " + 
     "     					a.unit, " + 
     "			         a.QTY," + 
     "			         a.PRICE," + 
     "                  a.AMT, " + 
     "                  a.RESULT_QTY, " + 
     "                  a.RESULT_RATE, " + 
     "                  a.RESULT_AMT, " + 
     "                  a.LS_RESULT_QTY, " + 
     "                  a.LS_RESULT_RATE, 	" + 
     "			         a.LS_RESULT_AMT, " + 
     "			         a.CM_RESULT_QTY, " + 
     "                  a.CM_RESULT_RATE, " + 
     "                  a.CM_RESULT_AMT, " + 
     "                  a.cm_cost_profit," + 
     "			         a.TOT_COST_QTY, " + 
     "			         a.COST_QTY, " + 
     "			         a.LS_COST_QTY, " + 
	  "			         a.TOT_COST_AMT, " + 
     "			         a.COST_AMT, " + 
     "			         a.LS_COST_AMT, " + 
	  "                  a.PRE_RESULT_AMT, " + 
      "			         a.TOT_COST_RATE," + 
     "                  a.COST_RATE, " + 
     "			         a.LS_COST_RATE, " + 
	  "                  a.SUP_QTY, " + 
     "                  a.SUP_UNIT_AMT, " + 
     "                  a.SUP_UNIT_FIX, " + 
     "                  a.MAT_UNIT_FIX,  " + 
     "                  a.remark,  " + 
     "     					a.tag, " + 
	  "					   a.cnt_result_qty , " +
	  "					   a.ls_cnt_result_qty ,  " +
	  "					  ( a.cnt_result_qty + a.ls_cnt_result_qty ) cm_cnt_result_qty ,  " +
	  "					   a.cnt_result_amt , " +
	  "					   a.ls_cnt_result_amt ,  " +
	  "					  ( a.cnt_result_amt + a.ls_cnt_result_amt ) cm_cnt_result_amt ,  " +
	  "					   a.cnt_result_rate , " +
	  "					   a.ls_cnt_result_rate ,  " +
	  "					  ( a.cnt_result_rate + a.ls_cnt_result_rate ) cm_cnt_result_rate ,  " +
	  "					   decode(a.col_tag,'L','노무','M','재료','X','경비','S','외주',null,'[미연계]') col_tag,  " +
  	  "						decode(a.cat_text,'','[미연계]',a.cat_text) cat_text  " +  
     "                 from   " + 
     "                   ( SELECT  a.dept_code, " + 
     "     					         a.chg_no_seq, " + 
     "     					         a.spec_no_seq, " + 
     "                           a.no_seq * 100000  no_seq, " + 
     "                           to_number(a.llevel) llevel, " + 
     "     					         a.sum_code, " + 
     "     					         a.parent_sum_code," + 
     "								   a.direct_class direct_class," + 
     "     					         a.name, " + 
     "     					         a.ssize, " + 
     "     					         a.unit, " + 
     "			                  1 QTY," + 
     "			                  0 PRICE," + 
     "                           NVL(b.AMT,0) AMT, " + 
     "                           NVL(b.RESULT_QTY,0) RESULT_QTY, " + 
     "                           NVL(b.RESULT_RATE,0) RESULT_RATE, " + 
     "                           NVL(b.RESULT_AMT,0) RESULT_AMT, " + 
     "                           NVL(b.LS_RESULT_QTY, 0) LS_RESULT_QTY, " + 
     "                           NVL(b.LS_RESULT_RATE, 0) LS_RESULT_RATE, 	" + 
     "			                  NVL(b.LS_RESULT_AMT, 0) LS_RESULT_AMT, " + 
     "			                  NVL(b.RESULT_QTY, 0) + NVL(b.LS_RESULT_QTY, 0) CM_RESULT_QTY, " + 
     "                           NVL(b.RESULT_RATE, 0) + NVL(b.LS_RESULT_RATE, 0) CM_RESULT_RATE, " + 
     "                           NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0) CM_RESULT_AMT, " + 
     "                           ((NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0)) - (NVL(b.cost_amt,0) + NVL(b.ls_cost_amt, 0))) cm_cost_profit," + 
     "			                  NVL(b.COST_QTY,0) + NVL(b.LS_COST_QTY, 0) TOT_COST_QTY, " + 
     "			                  NVL(b.COST_QTY,0)  COST_QTY, " + 
     "			                  NVL(b.LS_COST_QTY,0)  LS_COST_QTY, " + 
	  "			                  NVL(b.cost_amt,0) + NVL(b.ls_cost_amt, 0) TOT_COST_AMT, " + 
     "			                  NVL(b.cost_amt,0)  COST_AMT, " + 
     "			                  NVL(b.ls_cost_amt,0)  LS_COST_AMT, " + 
	  "                           NVL(b.PRE_RESULT_AMT,0) PRE_RESULT_AMT, " + 
	  "	 decode( NVL(b.pre_result_amt, 0), 0, 0 ,(NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0)) / NVL(b.pre_result_amt, 0) * 100)  TOT_COST_RATE,  " +
     "   decode( NVL(pre_result_amt,0),0,0, NVL(b.COST_AMT,0) / pre_result_amt * 100) COST_RATE,  " +
     "   decode( NVL(pre_result_amt,0),0,0, NVL(b.LS_COST_AMT,0) / pre_result_amt * 100) LS_COST_RATE, " + 
	  "                           0 SUP_QTY, " + 
     "                           0 SUP_UNIT_AMT, " + 
     "                           '' SUP_UNIT_FIX, " + 
     "                           '' MAT_UNIT_FIX,  " + 
     "                           '' remark,  " + 
     "     					         1 tag, " + 
	  "								   b.cnt_result_qty , " +
	  "								   b.ls_cnt_result_qty ,  " +
	  "								  ( b.cnt_result_qty + b.ls_cnt_result_qty ) cm_cnt_result_qty ,  " +
	  "								   b.cnt_result_amt , " +
	  "								   b.ls_cnt_result_amt ,  " +
	  "								  ( b.cnt_result_amt + b.ls_cnt_result_amt ) cm_cnt_result_amt ,  " +
	  "								   b.cnt_result_rate , " +
	  "								   b.ls_cnt_result_rate ,  " +
	  "								  ( b.cnt_result_rate + b.ls_cnt_result_rate ) cm_cnt_result_rate ,  " +
	  "								   '' col_tag , " + 
	  "							      '' cat_text " + 
     "                       FROM Y_BUDGET_parent a,  " + 
     "                            C_SPEC_CONST_parent b      " + 
     "                       WHERE ( b.dept_code    = a.dept_code ) and " + 
     "                             ( b.spec_no_seq     = a.spec_no_seq ) and " + 
     "                             ( b.dept_code    = '" + arg_dept_code + "') AND " + 
     "                             ( b.yymm         = '" + arg_yymm + "')  and " + 
     "                             ( a.sum_code     like '" + arg_parent_sum_code  + "') and " + 
     "                             ( a.llevel > 1 )    " + 
     "                    union all  " + 
     "     					 SELECT  a.dept_code, " + 
     "     					         a.chg_no_seq, " + 
     "     					         a.spec_no_seq, " + 
     "                           c.no_seq  * 100000 + a.no_seq no_seq, " + 
     "                           to_number(c.llevel) + 1 llevel, " + 
     "     					         c.sum_code, " + 
     "     					         c.sum_code," + 
     "								   ' ' direct_class, " + 
     "     					         a.name, " + 
     "     					         a.ssize, " + 
     "     					         a.unit, " + 
     "			                  NVL(b.QTY,0) QTY," + 
     "			                  NVL(b.PRICE,0) PRICE," + 
     "                           NVL(b.AMT,0) AMT," + 
     "                           NVL(b.RESULT_QTY,0) RESULT_QTY," + 
     "                           NVL(b.RESULT_RATE,0) RESULT_RATE," + 
     "			                  NVL(b.RESULT_AMT,0) RESULT_AMT," + 
     "                           NVL(b.LS_RESULT_QTY, 0) LS_RESULT_QTY," + 
     "                           NVL(b.LS_RESULT_RATE, 0) LS_RESULT_RATE,	" + 
     "			                  NVL(b.LS_RESULT_AMT, 0) LS_RESULT_AMT,         " + 
     "			                  NVL(b.RESULT_QTY, 0) + NVL(b.LS_RESULT_QTY, 0) CM_RESULT_QTY," + 
     "                           NVL(b.RESULT_RATE, 0) + NVL(b.LS_RESULT_RATE, 0) CM_RESULT_RATE," + 
     "                           NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0) CM_RESULT_AMT," + 
     "                           ((NVL(b.RESULT_AMT, 0) + NVL(b.LS_RESULT_AMT, 0)) - (NVL(b.cost_amt,0) + NVL(b.ls_cost_amt, 0))) cm_cost_profit," + 
     "			                  NVL(b.COST_QTY,0)  + NVL(b.LS_COST_QTY, 0) COST_QTY," + 
     "			                  NVL(b.COST_QTY,0)  COST_QTY1," + 
     "			                  NVL(b.LS_COST_QTY,0)  LS_COST_QTY," + 
     "			                  NVL(b.cost_amt,0) + NVL(b.ls_cost_amt, 0) tot_cost_amt," + 
     "			                  NVL(b.cost_amt,0)  cost_amt," + 
     "			                  NVL(b.ls_cost_amt,0)  ls_cost_amt," + 
	  "                           NVL(b.PRE_RESULT_AMT,0) PRE_RESULT_AMT, " + 
	  "	 decode( NVL(b.pre_result_amt, 0), 0, 0 ,(NVL(b.COST_AMT,0) + NVL(b.LS_COST_AMT, 0)) / NVL(b.pre_result_amt, 0) * 100)  TOT_COST_RATE,  " +
     "   decode( NVL(pre_result_amt,0),0,0, NVL(b.COST_AMT,0) / pre_result_amt * 100) COST_RATE,  " +
     "   decode( NVL(pre_result_amt,0),0,0, NVL(b.LS_COST_AMT,0) / pre_result_amt * 100) LS_COST_RATE, " + 
     "                           NVL(b.SUP_QTY,0) SUP_QTY, " + 
     "                           NVL(b.SUP_UNIT_AMT,0) SUP_UNIT_AMT, " + 
     "                           b.SUP_UNIT_FIX, " + 
     "                           b.MAT_UNIT_FIX,  " + 
     "                           b.remark,  " + 
     "     					         2 tag ," + 
	  "								   b.cnt_result_qty , " +
	  "								   b.ls_cnt_result_qty ,  " +
	  "								  ( b.cnt_result_qty + b.ls_cnt_result_qty ) cm_cnt_result_qty ,  " +
	  "								   b.cnt_result_amt , " +
	  "								   b.ls_cnt_result_amt ,  " +
	  "								  ( b.cnt_result_amt + b.ls_cnt_result_amt ) cm_cnt_result_amt ,  " +
	  "								   b.cnt_result_rate , " +
	  "								   b.ls_cnt_result_rate ,  " +
	  "								  ( b.cnt_result_rate + b.ls_cnt_result_rate ) cm_cnt_result_rate ,  " +
	  "								   a.col_tag , " + 
	  "							      a.cat_text " + 
     "                 FROM Y_BUDGET_PARENT c," + 
     "                      Y_BUDGET_DETAIL a," + 
     "                      C_SPEC_CONST_DETAIL b " + 
     "                WHERE ( a.dept_code    = c.dept_code ) and" + 
     "                      ( a.spec_no_seq     = c.spec_no_seq) and" + 
     "                      ( a.dept_code    = b.dept_code ) and" + 
     "                      ( a.spec_no_seq     = b.spec_no_seq) and" + 
     "                      ( a.spec_unq_num = b.spec_unq_num ) and" + 
     "                      ( a.dept_code    = '" + arg_dept_code + "') AND  " + 
     "                      ( b.yymm         = '" + arg_yymm + "') and" + 
     "                      ( c.sum_code like  '" + arg_parent_sum_code + "')  " + 
     "                  ) A, " + 
     "                 z_code_dept " + 
     "                  where z_code_dept.dept_code = a.dept_code  " + 
     "            order by a.sum_code asc, a.no_seq     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>