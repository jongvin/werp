<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_seq = req.getParameter("arg_chg_seq");
	 String arg_year = req.getParameter("arg_year");
	 String arg_cat_text = req.getParameter("arg_cat_text");
	
 //---------------------------------------------------------- 
	 dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	 dSet.addDataColumn(new GauceDataColumn("chg_seq",GauceDataColumn.TB_DECIMAL,2,0));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,7));	
	 dSet.addDataColumn(new GauceDataColumn("year_name",GauceDataColumn.TB_STRING,10));	
	 dSet.addDataColumn(new GauceDataColumn("year_org",GauceDataColumn.TB_STRING,10));	
	 dSet.addDataColumn(new GauceDataColumn("plan_mm_qty",GauceDataColumn.TB_DECIMAL,11,3));
	 dSet.addDataColumn(new GauceDataColumn("plan_mm_amt",GauceDataColumn.TB_DECIMAL,14,0));

    String query = " SELECT   cd.dept_code,"   +
"          cd.chg_seq,"   +
"          cd.chg_no_seq,"   +
"          cd.spec_unq_num,"   +
"          TO_CHAR (cd.YEAR, 'yyyy.mm') YEAR,"   +
"          TO_CHAR (cd.YEAR, 'yyyy.mm') year_name,"   +
"          TO_CHAR (cd.YEAR, 'yyyy.mm.dd') year_org,"   +
"          cd.plan_mm_qty,"   +
"          cd.plan_mm_amt"   +
"     FROM c_progress_detail cd, "   +
"          y_chg_budget_detail bd, "   +
"          c_chg_progress pp"   +
"    WHERE pp.dept_code = '"+arg_dept_code+"'"   +
"      AND pp.chg_seq   = "+arg_chg_seq+
"      AND pp.dept_code = cd.dept_code"   +
"      AND pp.chg_seq   = cd.chg_seq"   +
"      AND cd.dept_code    = bd.dept_code"   +
"      AND cd.chg_no_seq   = bd.chg_no_seq"   +
"      AND cd.spec_unq_num = bd.spec_unq_num"   +
"      AND cd.spec_no_seq  = bd.spec_no_seq"   +
"      and nvl(bd.cat_text,'')  like '"+arg_cat_text+"'"   +
"      and cd.year between '"+arg_year+"' and add_months(to_date('"+arg_year+"'), 35)"   +
" union all"   +
" SELECT   cd.dept_code,"   +
"          cd.chg_seq,"   +
"          cd.chg_no_seq,"   +
"          cd.spec_unq_num,"   +
"          '1900.01' YEAR,"   +
"          '전년누계' year_name,"   +
"          '1900.01.01' year_org,"   +
"          sum(nvl(cd.plan_mm_qty,0)) plan_mm_qty ,"   +
"          sum(nvl(cd.plan_mm_amt,0)) plan_mm_amt "   +
"     FROM c_progress_detail cd, "   +
"          y_chg_budget_detail bd, "   +
"          c_chg_progress pp"   +
"    WHERE pp.dept_code = '"+arg_dept_code+"'"   +
"      AND pp.chg_seq   = "+arg_chg_seq+
"      AND pp.dept_code = cd.dept_code"   +
"      AND pp.chg_seq   = cd.chg_seq"   +
"      AND cd.dept_code    = bd.dept_code"   +
"      AND cd.chg_no_seq   = bd.chg_no_seq"   +
"      AND cd.spec_unq_num = bd.spec_unq_num"   +
"      AND cd.spec_no_seq  = bd.spec_no_seq"   +
"      and nvl(bd.cat_text,'')  like '"+arg_cat_text+"'"   +
"      and cd.year < '"+arg_year+"'"   +
"  group by cd.dept_code,"   +
"          cd.chg_seq,"   +
"          cd.chg_no_seq,"   +
"          cd.spec_unq_num,"   +
"          '1900.01' ,"   +
"          '1900.01.01'"   +
"  union all"   +
" SELECT   cd.dept_code,"   +
"          cd.chg_seq,"   +
"          cd.chg_no_seq,"   +
"          cd.spec_unq_num,"   +
"          '2999.01' YEAR,"   +
"          '잔여누계' year_name,"   +
"          '2999.01.01' year_org,"   +
"          sum(nvl(cd.plan_mm_qty,0)) plan_mm_qty ,"   +
"          sum(nvl(cd.plan_mm_amt,0)) plan_mm_amt "   +
"     FROM c_progress_detail cd, "   +
"          y_chg_budget_detail bd, "   +
"          c_chg_progress pp, dual"   +
"    WHERE pp.dept_code = '"+arg_dept_code+"'"   +
"      AND pp.chg_seq   = "+arg_chg_seq+
"      AND pp.dept_code = cd.dept_code"   +
"      AND pp.chg_seq   = cd.chg_seq"   +
"      AND cd.dept_code    = bd.dept_code"   +
"      AND cd.chg_no_seq   = bd.chg_no_seq"   +
"      AND cd.spec_unq_num = bd.spec_unq_num"   +
"      AND cd.spec_no_seq  = bd.spec_no_seq"   +
"      and nvl(bd.cat_text,'')  like '"+arg_cat_text+"'"   +
"      and cd.year > add_months(to_date('"+arg_year+"'), 35)"   +
"  group by cd.dept_code,"   +
"          cd.chg_seq,"   +
"          cd.chg_no_seq,"   +
"          cd.spec_unq_num,"   +
"          '2999.01' ,"   +
"          '2999.01.01'   "   +
" ORDER BY spec_unq_num, YEAR"  ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>