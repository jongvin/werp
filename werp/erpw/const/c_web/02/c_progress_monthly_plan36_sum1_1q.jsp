<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)//
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_chg_seq = req.getParameter("arg_chg_seq");
	 String arg_year = req.getParameter("arg_year");
	 dSet.addDataColumn(new GauceDataColumn("grp",GauceDataColumn.TB_STRING,250));
	 dSet.addDataColumn(new GauceDataColumn("col_tag",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("year_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("y_cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cost_amt",GauceDataColumn.TB_DECIMAL,18,0));

	String query = "  select aa.col_tag grp, "+
"           aa.col_tag,"   +
"           aa.col_tag_order,"   +
"           aa.YEAR,"   +
"           aa.year_name,"   +
"           aa.year_org,"   +
"           budget.amt,"   +
"           budget.cnt_amt y_cnt_amt,"   +
"           aa.mm_amt,"   +
"           aa.cnt_amt,"   +
"           aa.cost_amt"   +
"   from ( SELECT   decode(cd.col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]') col_tag,"   +
"                   decode(cd.col_tag, 'S', 1, 'M', 2, 'L', 3, 'X', 4, 5) col_tag_order,"   +
"                   TO_CHAR (cd.YEAR, 'yyyy.mm') YEAR,"   +
"                   TO_CHAR (cd.YEAR, 'yyyy.mm') year_name,"   +
"                   TO_CHAR (cd.YEAR, 'yyyy.mm.dd') year_org,"   +
"                   sum(nvl(cd.plan_mm_amt,0)) mm_amt,"   +
"                   sum(nvl(cd.cnt_amt,0)) cnt_amt,"   +
"                   sum(nvl(cd.cost_amt,0)) cost_amt"   +
"              FROM c_progress_cattext cd,"   +
"                   c_chg_progress pp"   +
"             WHERE pp.dept_code = '"+arg_dept_code+"'"   +
"               AND pp.chg_seq   = '"+arg_chg_seq+"'"   +
"               AND pp.dept_code = cd.dept_code"   +
"               AND pp.chg_seq   = cd.chg_seq"   +
"               and cd.year between '"+arg_year+"' and add_months(to_date('"+arg_year+"'), 35)"   +
"          group by decode(cd.col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]'),"   +
"                   decode(cd.col_tag, 'S', 1, 'M', 2, 'L', 3, 'X', 4, 5) ,"   +
"                   TO_CHAR (cd.YEAR, 'yyyy.mm') ,"   +
"                   TO_CHAR (cd.YEAR, 'yyyy.mm') ,"   +
"                   TO_CHAR (cd.YEAR, 'yyyy.mm.dd')"   +
"          union all"   +
"          SELECT   decode(cd.col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]') col_tag,"   +
"                   decode(cd.col_tag, 'S', 1, 'M', 2, 'L', 3, 'X', 4, 5) col_tag_order,"   +
"                   '1900.01' YEAR,"   +
"                   '전년누계' year_name,"   +
"                   '1900.01.01' year_org,"   +
"                   sum(nvl(cd.plan_mm_amt,0)) plan_mm_amt,"   +
"                   sum(nvl(cd.cnt_amt,0)) cnt_amt,"   +
"                   sum(nvl(cd.cost_amt,0)) cost_amt"   +
"              FROM c_progress_cattext cd,"   +
"                   c_chg_progress pp"   +
"             WHERE pp.dept_code = '"+arg_dept_code+"'"   +
"               AND pp.chg_seq   = '"+arg_chg_seq+"'"   +
"               AND pp.dept_code = cd.dept_code"   +
"               AND pp.chg_seq   = cd.chg_seq"   +
"               and cd.year < '"+arg_year+"'"   +
"           group by decode(cd.col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]'),"   +
"                   decode(cd.col_tag, 'S', 1, 'M', 2, 'L', 3, 'X', 4, 5) "   +
"          union all"   +
"          SELECT   decode(cd.col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]') col_tag,"   +
"                   decode(cd.col_tag, 'S', 1, 'M', 2, 'L', 3, 'X', 4, 5) col_tag_order,"   +
"                   '2999.01' YEAR,"   +
"                   '잔여누계' year_name,"   +
"                   '2999.01.01' year_org,"   +
"                   sum(nvl(cd.plan_mm_amt,0)) plan_mm_amt,"   +
"                   sum(nvl(cd.cnt_amt,0)) cnt_amt,"   +
"                   sum(nvl(cd.cost_amt,0)) cost_amt"   +
"              FROM c_progress_cattext cd,"   +
"                   c_chg_progress pp, dual"   +
"             WHERE pp.dept_code = '"+arg_dept_code+"'"   +
"               AND pp.chg_seq   = '"+arg_chg_seq+"'"   +
"               AND pp.dept_code = cd.dept_code" +
"               AND pp.chg_seq   = cd.chg_seq"   +
"               and cd.year > add_months(to_date('"+arg_year+"'), 35)"   +
"           group by decode(cd.col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]'),"   +
"                   decode(cd.col_tag, 'S', 1, 'M', 2, 'L', 3, 'X', 4, 5) "   +
"           ) aa,"   +
"           ( select decode(col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]') col_tag,"   +
"                    sum(nvl(amt,0)) amt,"   +
"                    sum(nvl(cnt_amt,0)) cnt_amt"   +
"               from y_chg_budget_detail"   +
"              where dept_code = '"+arg_dept_code+"'"   +
"                AND chg_no_seq   = (select chg_no_seq from c_chg_progress where dept_code = '"+arg_dept_code+"' and chg_seq = '"+arg_chg_seq+"')"   +
"             group by col_tag"   +
"         ) budget"   +
"  where aa.col_tag(+)  = budget.col_tag"   +
"  ORDER BY aa.col_tag_order,  aa.YEAR"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>