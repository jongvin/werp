<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_yymm = req.getParameter("arg_yymm");
	 String arg_chg_seq = req.getParameter("arg_chg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cat_text",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("amt_name",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("ps",GauceDataColumn.TB_STRING,50));

     dSet.addDataColumn(new GauceDataColumn("pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("this",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mm12",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " "   +
" select plan.cat_text,"   +
"        plan.amt_name,"   +
"        plan.ps,"   +
"        plan.pre," +
"        plan.this, " +
"        plan.mm01,"   +
"        plan.mm02,"   +
"        plan.mm03,"   +
"        plan.mm04,"   +
"        plan.mm05,"   +
"        plan.mm06,"   +
"        plan.mm07,"   +
"        plan.mm08,"   +
"        plan.mm09,"   +
"        plan.mm10,"   +
"        plan.mm11,"   +
"        plan.mm12"   +
"   from (select nvl(b.cat_text,'[미연계]') cat_text,"   +
"                b.cat_text cat_order,"   +
"                '2실행' amt_tag,"   +
"                '실행' amt_name,"   +
"                '계획' ps,"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.plan_mm_amt,0) else 0 end ) pre,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.plan_mm_amt,0) else 0 end ) this, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.plan_mm_amt,0), 0 )) mm01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.plan_mm_amt,0), 0 )) mm02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.plan_mm_amt,0), 0 )) mm03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.plan_mm_amt,0), 0 )) mm04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.plan_mm_amt,0), 0 )) mm05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.plan_mm_amt,0), 0 )) mm06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.plan_mm_amt,0), 0 )) mm07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.plan_mm_amt,0), 0 )) mm08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.plan_mm_amt,0), 0 )) mm09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.plan_mm_amt,0), 0 )) mm10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.plan_mm_amt,0), 0 )) mm11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.plan_mm_amt,0), 0 )) mm12"   +
"                "   +
"           from c_progress_detail c,"   +
"                y_chg_budget_detail b,"   +
"                (select substr('"+arg_yymm+"', 1,4) yr from dual) a"   +
"          where c.dept_code = '"+arg_dept_code+"'"   +
"            and to_char(c.year,'yyyy') <= a.yr"   +
"            and c.chg_seq = "+arg_chg_seq+""   +
"            and c.dept_code = b.dept_code "   +
"            and c.chg_no_seq = b.chg_no_seq"   +
"            and c.spec_unq_num = b.spec_unq_num"   +
"            and c.spec_no_seq  = b.spec_no_seq"   +
"         group by nvl(b.cat_text,'[미연계]'),"   +
"                  b.cat_text"   +
"                  "   +
"         union all"   +
"         "   +
"         select nvl(b.cat_text,'[미연계]') cat_text,"   +
"                b.cat_text cat_order,"   +
"                '2실행' amt_tag,"   +
"                '실행' amt_name,"   +
"                '실적' ps, "   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.result_amt,0) else 0 end ) pre, "   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.result_amt,0) else 0 end ) this,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.result_amt,0), 0 )) mm01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.result_amt,0), 0 )) mm02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.result_amt,0), 0 )) mm03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.result_amt,0), 0 )) mm04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.result_amt,0), 0 )) mm05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.result_amt,0), 0 )) mm06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.result_amt,0), 0 )) mm07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.result_amt,0), 0 )) mm08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.result_amt,0), 0 )) mm09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.result_amt,0), 0 )) mm10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.result_amt,0), 0 )) mm11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.result_amt,0), 0 )) mm12"   +
"                "   +
"           from c_progress_detail c,"   +
"                y_chg_budget_detail b,"   +
"                c_spec_const_detail sp,"   +
"                (select substr('"+arg_yymm+"', 1,4) yr from dual) a"   +
"          where c.dept_code = '"+arg_dept_code+"'"   +
"            and to_char(c.year,'yyyy') <= a.yr"   +
"            and c.chg_seq = "+arg_chg_seq+""   +
"            and c.dept_code = b.dept_code "   +
"            and c.chg_no_seq = b.chg_no_seq"   +
"            and c.spec_unq_num = b.spec_unq_num"   +
"            and c.spec_no_seq  = b.spec_no_seq"   +
"            and c.dept_code    = sp.dept_code"   +
"            and c.year         = sp.yymm"   +
"            and c.spec_unq_num = sp.spec_unq_num"   +
"            and c.spec_no_seq  = sp.spec_no_seq"   +
"            and sp.yymm <= '"+arg_yymm+"'"   +
"         group by nvl(b.cat_text,'[미연계]'),"   +
"                  b.cat_text"   +
"         "   +
"         union all         "   +
"         select nvl(b.cat_text,'[미연계]') cat_text,"   +
"                b.cat_text cat_order,"   +
"                '1도급' amt_tag,"   +
"                '도급' amt_name,"   +
"                '계획' ps,"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.cnt_amt,0) else 0 end ) pre,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cnt_amt,0) else 0 end ) this, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.cnt_amt,0), 0 )) mm01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.cnt_amt,0), 0 )) mm02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.cnt_amt,0), 0 )) mm03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.cnt_amt,0), 0 )) mm04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.cnt_amt,0), 0 )) mm05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.cnt_amt,0), 0 )) mm06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.cnt_amt,0), 0 )) mm07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.cnt_amt,0), 0 )) mm08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.cnt_amt,0), 0 )) mm09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.cnt_amt,0), 0 )) mm10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.cnt_amt,0), 0 )) mm11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.cnt_amt,0), 0 )) mm12"   +
"                "   +
"           from c_progress_detail c,"   +
"                y_chg_budget_detail b,"   +
"                (select substr('"+arg_yymm+"', 1,4) yr from dual) a"   +
"          where c.dept_code = '"+arg_dept_code+"'"   +
"            and to_char(c.year,'yyyy') <= a.yr"   +
"            and c.chg_seq = "+arg_chg_seq+""   +
"            and c.dept_code = b.dept_code "   +
"            and c.chg_no_seq = b.chg_no_seq"   +
"            and c.spec_unq_num = b.spec_unq_num"   +
"            and c.spec_no_seq  = b.spec_no_seq"   +
"         group by nvl(b.cat_text,'[미연계]'),"   +
"                  b.cat_text"   +
"                  "   +
"         union all"   +
"         "   +
"         select nvl(b.cat_text,'[미연계]') cat_text,"   +
"                b.cat_text cat_order,"   +
"                '1도급' amt_tag,"   +
"                '도급' amt_name,"   +
"                '실적' ps, "   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cnt_result_amt,0) else 0 end ) pre, "   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cnt_result_amt,0) else 0 end ) this,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cnt_result_amt,0), 0 )) mm01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cnt_result_amt,0), 0 )) mm02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cnt_result_amt,0), 0 )) mm03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cnt_result_amt,0), 0 )) mm04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cnt_result_amt,0), 0 )) mm05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cnt_result_amt,0), 0 )) mm06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cnt_result_amt,0), 0 )) mm07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cnt_result_amt,0), 0 )) mm08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cnt_result_amt,0), 0 )) mm09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cnt_result_amt,0), 0 )) mm10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cnt_result_amt,0), 0 )) mm11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cnt_result_amt,0), 0 )) mm12"   +
"                "   +
"           from c_progress_detail c,"   +
"                y_chg_budget_detail b,"   +
"                c_spec_const_detail sp,"   +
"                (select substr('"+arg_yymm+"', 1,4) yr from dual) a"   +
"          where c.dept_code = '"+arg_dept_code+"'"   +
"            and to_char(c.year,'yyyy') <= a.yr"   +
"            and c.chg_seq = "+arg_chg_seq+""   +
"            and c.dept_code = b.dept_code "   +
"            and c.chg_no_seq = b.chg_no_seq"   +
"            and c.spec_unq_num = b.spec_unq_num"   +
"            and c.spec_no_seq  = b.spec_no_seq"   +
"            and c.dept_code    = sp.dept_code"   +
"            and c.year         = sp.yymm"   +
"            and c.spec_unq_num = sp.spec_unq_num"   +
"            and c.spec_no_seq  = sp.spec_no_seq"   +
"            and sp.yymm <= '"+arg_yymm+"'"   +
"         group by nvl(b.cat_text,'[미연계]'),"   +
"                  b.cat_text"   +
"         union all"   +
"         "   +
"         select nvl(b.cat_text,'[미연계]') cat_text,"   +
"                b.cat_text cat_order,"   +
"                '2원가' amt_tag,"   +
"                '원가' amt_name,"   +
"                '계획' ps,"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.cost_amt,0) else 0 end ) ppre,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cost_amt,0) else 0 end ) this, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.cost_amt,0), 0 )) mm01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.cost_amt,0), 0 )) mm02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.cost_amt,0), 0 )) mm03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.cost_amt,0), 0 )) mm04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.cost_amt,0), 0 )) mm05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.cost_amt,0), 0 )) mm06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.cost_amt,0), 0 )) mm07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.cost_amt,0), 0 )) mm08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.cost_amt,0), 0 )) mm09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.cost_amt,0), 0 )) mm10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.cost_amt,0), 0 )) mm11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.cost_amt,0), 0 )) mm12"   +
"                "   +
"           from c_progress_detail c,"   +
"                y_chg_budget_detail b,"   +
"                (select substr('"+arg_yymm+"', 1,4) yr from dual) a"   +
"          where c.dept_code = '"+arg_dept_code+"'"   +
"            and to_char(c.year,'yyyy') <= a.yr"   +
"            and c.chg_seq = "+arg_chg_seq+""   +
"            and c.dept_code = b.dept_code "   +
"            and c.chg_no_seq = b.chg_no_seq"   +
"            and c.spec_unq_num = b.spec_unq_num"   +
"            and c.spec_no_seq  = b.spec_no_seq"   +
"         group by nvl(b.cat_text,'[미연계]'),"   +
"                  b.cat_text"   +
"                  "   +
"         union all"   +
"         "   +
"         select nvl(b.cat_text,'[미연계]') cat_text,"   +
"                b.cat_text cat_order,"   +
"                '2원가' amt_tag,"   +
"                '원가' amt_name,"   +
"                '실적' ps, "   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end ) pre, "   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) this,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cost_amt,0), 0 )) mm01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cost_amt,0), 0 )) mm02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cost_amt,0), 0 )) mm03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cost_amt,0), 0 )) mm04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cost_amt,0), 0 )) mm05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cost_amt,0), 0 )) mm06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cost_amt,0), 0 )) mm07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cost_amt,0), 0 )) mm08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cost_amt,0), 0 )) mm09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cost_amt,0), 0 )) mm10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cost_amt,0), 0 )) mm11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cost_amt,0), 0 )) mm12"   +
"                "   +
"           from c_progress_detail c,"   +
"                y_chg_budget_detail b,"   +
"                c_spec_const_detail sp,"   +
"                (select substr('"+arg_yymm+"', 1,4) yr from dual) a"   +
"          where c.dept_code = '"+arg_dept_code+"'"   +
"            and to_char(c.year,'yyyy') <= a.yr"   +
"            and c.chg_seq = "+arg_chg_seq+""   +
"            and c.dept_code = b.dept_code "   +
"            and c.chg_no_seq = b.chg_no_seq"   +
"            and c.spec_unq_num = b.spec_unq_num"   +
"            and c.spec_no_seq  = b.spec_no_seq"   +
"            and c.dept_code    = sp.dept_code"   +
"            and c.year         = sp.yymm"   +
"            and c.spec_unq_num = sp.spec_unq_num"   +
"            and c.spec_no_seq  = sp.spec_no_seq"   +
"            and sp.yymm <= '"+arg_yymm+"'"   +
"         group by nvl(b.cat_text,'[미연계]'),"   +
"                  b.cat_text"   +
"                  "   +
"         order by cat_order , amt_tag, ps"   +
"  ) plan"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>