<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)//
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_yymm = req.getParameter("arg_yymm");
	 String arg_chg_seq = req.getParameter("arg_chg_seq");
 
	 dSet.addDataColumn(new GauceDataColumn("col_tag",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cat_text",GauceDataColumn.TB_STRING,50));
	 
     dSet.addDataColumn(new GauceDataColumn("cntp_pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cntp_this",GauceDataColumn.TB_DECIMAL,18,0));
	 
	 dSet.addDataColumn(new GauceDataColumn("cnts_pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnts_this",GauceDataColumn.TB_DECIMAL,18,0));

	 dSet.addDataColumn(new GauceDataColumn("exep_pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exep_this",GauceDataColumn.TB_DECIMAL,18,0));

	 dSet.addDataColumn(new GauceDataColumn("exes_pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exes_this",GauceDataColumn.TB_DECIMAL,18,0));

	 dSet.addDataColumn(new GauceDataColumn("cosp_pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cosp_this",GauceDataColumn.TB_DECIMAL,18,0));

	 dSet.addDataColumn(new GauceDataColumn("coss_pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("coss_this",GauceDataColumn.TB_DECIMAL,18,0));

	 dSet.addDataColumn(new GauceDataColumn("cnte_pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("cnte_this",GauceDataColumn.TB_DECIMAL,18,0));

	 dSet.addDataColumn(new GauceDataColumn("exee_pre",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exee_this",GauceDataColumn.TB_DECIMAL,18,0));

	 
    String query = "select '[전체]' col_tag, "+
"                0 col_tag_order,"+
"                '[총계]' cat_text,"+
"                '[총계]' cat_order,"+
"                "   +
"                 /*도급계획 cntp */"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.cnt_amt,0) else 0 end ) cntp_pre,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.cnt_amt,0), 0 )) cntp01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.cnt_amt,0), 0 )) cntp02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.cnt_amt,0), 0 )) cntp03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.cnt_amt,0), 0 )) cntp04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.cnt_amt,0), 0 )) cntp05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.cnt_amt,0), 0 )) cntp06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.cnt_amt,0), 0 )) cntp07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.cnt_amt,0), 0 )) cntp08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.cnt_amt,0), 0 )) cntp09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.cnt_amt,0), 0 )) cntp10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.cnt_amt,0), 0 )) cntp11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.cnt_amt,0), 0 )) cntp12,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cnt_amt,0) else 0 end ) cntp_this, "   +
"                /*도급실적 cnts */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cnt_result_amt,0) else 0 end ) cnts_pre, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cnt_result_amt,0), 0 )) cnts01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cnt_result_amt,0), 0 )) cnts02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cnt_result_amt,0), 0 )) cnts03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cnt_result_amt,0), 0 )) cnts04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cnt_result_amt,0), 0 )) cnts05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cnt_result_amt,0), 0 )) cnts06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cnt_result_amt,0), 0 )) cnts07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cnt_result_amt,0), 0 )) cnts08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cnt_result_amt,0), 0 )) cnts09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cnt_result_amt,0), 0 )) cnts10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cnt_result_amt,0), 0 )) cnts11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cnt_result_amt,0), 0 )) cnts12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cnt_result_amt,0) else 0 end ) cnts_this,"   +
"                /*실행계획 exep */"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.plan_mm_amt,0) else 0 end ) exep_pre,    "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.plan_mm_amt,0), 0 )) exep01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.plan_mm_amt,0), 0 )) exep02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.plan_mm_amt,0), 0 )) exep03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.plan_mm_amt,0), 0 )) exep04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.plan_mm_amt,0), 0 )) exep05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.plan_mm_amt,0), 0 )) exep06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.plan_mm_amt,0), 0 )) exep07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.plan_mm_amt,0), 0 )) exep08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.plan_mm_amt,0), 0 )) exep09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.plan_mm_amt,0), 0 )) exep10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.plan_mm_amt,0), 0 )) exep11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.plan_mm_amt,0), 0 )) exep12,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.plan_mm_amt,0) else 0 end ) exep_this, "   +
"                "   +
"                /*실행실적 exes */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.result_amt,0) else 0 end ) exes_pre, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.result_amt,0), 0 )) exes01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.result_amt,0), 0 )) exes02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.result_amt,0), 0 )) exes03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.result_amt,0), 0 )) exes04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.result_amt,0), 0 )) exes05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.result_amt,0), 0 )) exes06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.result_amt,0), 0 )) exes07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.result_amt,0), 0 )) exes08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.result_amt,0), 0 )) exes09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.result_amt,0), 0 )) exes10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.result_amt,0), 0 )) exes11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.result_amt,0), 0 )) exes12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.result_amt,0) else 0 end ) exes_this,"   +
"                "   +
"                /*원가계획 cosp */"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.cost_amt,0) else 0 end ) cosp_pre,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.cost_amt,0), 0 )) cosp01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.cost_amt,0), 0 )) cosp02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.cost_amt,0), 0 )) cosp03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.cost_amt,0), 0 )) cosp04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.cost_amt,0), 0 )) cosp05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.cost_amt,0), 0 )) cosp06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.cost_amt,0), 0 )) cosp07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.cost_amt,0), 0 )) cosp08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.cost_amt,0), 0 )) cosp09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.cost_amt,0), 0 )) cosp10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.cost_amt,0), 0 )) cosp11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.cost_amt,0), 0 )) cosp12,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cost_amt,0) else 0 end ) cosp_this, "   +
"                "   +
"                /*원가실적 coss */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end ) coss_pre, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cost_amt,0), 0 )) coss01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cost_amt,0), 0 )) coss02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cost_amt,0), 0 )) coss03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cost_amt,0), 0 )) coss04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cost_amt,0), 0 )) coss05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cost_amt,0), 0 )) coss06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cost_amt,0), 0 )) coss07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cost_amt,0), 0 )) coss08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cost_amt,0), 0 )) coss09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cost_amt,0), 0 )) coss10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cost_amt,0), 0 )) coss11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cost_amt,0), 0 )) coss12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) coss_this,"   +
"                /*도급손익 cnte */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cnt_result_amt,0) else 0 end )"   +
"                - sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end ) cnte_pre, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cost_amt,0), 0 )) cnte01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cost_amt,0), 0 )) cnte02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cost_amt,0), 0 )) cnte03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cost_amt,0), 0 )) cnte04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cost_amt,0), 0 )) cnte05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cost_amt,0), 0 )) cnte06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cost_amt,0), 0 )) cnte07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cost_amt,0), 0 )) cnte08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cost_amt,0), 0 )) cnte09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cost_amt,0), 0 )) cnte10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cost_amt,0), 0 )) cnte11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cost_amt,0), 0 )) cnte12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cnt_result_amt,0) else 0 end )"   +
"                - sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) cnte_this,"   +
"                /*실행손익 exee */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.result_amt,0) else 0 end )"   +
"                - sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end ) exee_pre,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.result_amt,0), 0 )) "   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cost_amt,0), 0 )) exee01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cost_amt,0), 0 )) exee02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cost_amt,0), 0 )) exee03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cost_amt,0), 0 )) exee04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cost_amt,0), 0 )) exee05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cost_amt,0), 0 )) exee06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cost_amt,0), 0 )) exee07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cost_amt,0), 0 )) exee08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cost_amt,0), 0 )) exee09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cost_amt,0), 0 )) exee10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cost_amt,0), 0 )) exee11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cost_amt,0), 0 )) exee12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.result_amt,0) else 0 end )"   +
"                - sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) exee_this                "   +
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
"                  "   +
"      union all "   +
"         select decode(b.col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]') col_tag,"   +
"                decode(b.col_tag, 'S', 1, 'M', 2, 'L', 3, 'X', 4, 5) col_tag_order,"   +
"                nvl(b.cat_text,'[미연계]') cat_text,"   +
"                b.cat_text cat_order,"   +
"                "   +
"                 /*도급계획 cntp */"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.cnt_amt,0) else 0 end ) cntp_pre,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.cnt_amt,0), 0 )) cntp01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.cnt_amt,0), 0 )) cntp02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.cnt_amt,0), 0 )) cntp03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.cnt_amt,0), 0 )) cntp04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.cnt_amt,0), 0 )) cntp05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.cnt_amt,0), 0 )) cntp06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.cnt_amt,0), 0 )) cntp07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.cnt_amt,0), 0 )) cntp08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.cnt_amt,0), 0 )) cntp09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.cnt_amt,0), 0 )) cntp10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.cnt_amt,0), 0 )) cntp11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.cnt_amt,0), 0 )) cntp12,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cnt_amt,0) else 0 end ) cntp_this, "   +
"                /*도급실적 cnts */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cnt_result_amt,0) else 0 end ) cnts_pre, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cnt_result_amt,0), 0 )) cnts01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cnt_result_amt,0), 0 )) cnts02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cnt_result_amt,0), 0 )) cnts03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cnt_result_amt,0), 0 )) cnts04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cnt_result_amt,0), 0 )) cnts05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cnt_result_amt,0), 0 )) cnts06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cnt_result_amt,0), 0 )) cnts07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cnt_result_amt,0), 0 )) cnts08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cnt_result_amt,0), 0 )) cnts09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cnt_result_amt,0), 0 )) cnts10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cnt_result_amt,0), 0 )) cnts11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cnt_result_amt,0), 0 )) cnts12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cnt_result_amt,0) else 0 end ) cnts_this,"   +
"                /*실행계획 exep */"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.plan_mm_amt,0) else 0 end ) exep_pre,    "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.plan_mm_amt,0), 0 )) exep01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.plan_mm_amt,0), 0 )) exep02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.plan_mm_amt,0), 0 )) exep03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.plan_mm_amt,0), 0 )) exep04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.plan_mm_amt,0), 0 )) exep05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.plan_mm_amt,0), 0 )) exep06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.plan_mm_amt,0), 0 )) exep07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.plan_mm_amt,0), 0 )) exep08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.plan_mm_amt,0), 0 )) exep09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.plan_mm_amt,0), 0 )) exep10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.plan_mm_amt,0), 0 )) exep11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.plan_mm_amt,0), 0 )) exep12,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.plan_mm_amt,0) else 0 end ) exep_this, "   +
"                "   +
"                /*실행실적 exes */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.result_amt,0) else 0 end ) exes_pre, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.result_amt,0), 0 )) exes01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.result_amt,0), 0 )) exes02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.result_amt,0), 0 )) exes03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.result_amt,0), 0 )) exes04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.result_amt,0), 0 )) exes05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.result_amt,0), 0 )) exes06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.result_amt,0), 0 )) exes07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.result_amt,0), 0 )) exes08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.result_amt,0), 0 )) exes09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.result_amt,0), 0 )) exes10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.result_amt,0), 0 )) exes11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.result_amt,0), 0 )) exes12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.result_amt,0) else 0 end ) exes_this,"   +
"                "   +
"                /*원가계획 cosp */"   +
"                sum( case when to_char(c.year,'yyyy') < a.yr then nvl(c.cost_amt,0) else 0 end ) cosp_pre,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(c.cost_amt,0), 0 )) cosp01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(c.cost_amt,0), 0 )) cosp02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(c.cost_amt,0), 0 )) cosp03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(c.cost_amt,0), 0 )) cosp04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(c.cost_amt,0), 0 )) cosp05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(c.cost_amt,0), 0 )) cosp06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(c.cost_amt,0), 0 )) cosp07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(c.cost_amt,0), 0 )) cosp08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(c.cost_amt,0), 0 )) cosp09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(c.cost_amt,0), 0 )) cosp10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(c.cost_amt,0), 0 )) cosp11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(c.cost_amt,0), 0 )) cosp12,"   +
"                sum( case when to_char(c.year,'yyyy') = a.yr then nvl(c.cost_amt,0) else 0 end ) cosp_this, "   +
"                "   +
"                /*원가실적 coss */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end ) coss_pre, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cost_amt,0), 0 )) coss01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cost_amt,0), 0 )) coss02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cost_amt,0), 0 )) coss03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cost_amt,0), 0 )) coss04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cost_amt,0), 0 )) coss05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cost_amt,0), 0 )) coss06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cost_amt,0), 0 )) coss07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cost_amt,0), 0 )) coss08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cost_amt,0), 0 )) coss09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cost_amt,0), 0 )) coss10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cost_amt,0), 0 )) coss11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cost_amt,0), 0 )) coss12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) coss_this,"   +
"                /*도급손익 cnte */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cnt_result_amt,0) else 0 end )"   +
"                - sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end ) cnte_pre, "   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cost_amt,0), 0 )) cnte01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cost_amt,0), 0 )) cnte02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cost_amt,0), 0 )) cnte03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cost_amt,0), 0 )) cnte04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cost_amt,0), 0 )) cnte05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cost_amt,0), 0 )) cnte06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cost_amt,0), 0 )) cnte07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cost_amt,0), 0 )) cnte08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cost_amt,0), 0 )) cnte09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cost_amt,0), 0 )) cnte10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cost_amt,0), 0 )) cnte11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cnt_result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cost_amt,0), 0 )) cnte12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cnt_result_amt,0) else 0 end )"   +
"                - sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) cnte_this,"   +
"                /*실행손익 exee */"   +
"                sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.result_amt,0) else 0 end )"   +
"                - sum( case when to_char(sp.yymm,'yyyy') < a.yr then nvl(sp.cost_amt,0) else 0 end ) exee_pre,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.result_amt,0), 0 )) "   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'01', nvl(sp.cost_amt,0), 0 )) exee01,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'02', nvl(sp.cost_amt,0), 0 )) exee02,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'03', nvl(sp.cost_amt,0), 0 )) exee03,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'04', nvl(sp.cost_amt,0), 0 )) exee04,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'05', nvl(sp.cost_amt,0), 0 )) exee05,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'06', nvl(sp.cost_amt,0), 0 )) exee06,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'07', nvl(sp.cost_amt,0), 0 )) exee07,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'08', nvl(sp.cost_amt,0), 0 )) exee08,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'09', nvl(sp.cost_amt,0), 0 )) exee09,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'10', nvl(sp.cost_amt,0), 0 )) exee10,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'11', nvl(sp.cost_amt,0), 0 )) exee11,"   +
"                sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.result_amt,0), 0 ))"   +
"                - sum(decode(to_char(c.year,'yyyymm'), a.yr||'12', nvl(sp.cost_amt,0), 0 )) exee12,"   +
"                sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.result_amt,0) else 0 end )"   +
"                - sum( case when to_char(sp.yymm,'yyyy') = a.yr then nvl(sp.cost_amt,0) else 0 end ) exee_this                "   +
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
"                  b.cat_text,"   +
"                  decode(b.col_tag, 'S', 1, 'M', 2, 'L', 3, 'X', 4, 5),"   +
"                  decode(b.col_tag, 'S', '외주', 'M', '자재', 'L', '노무', 'X', '경비', '[미연계]') "   +
"                  "   +
"         order by col_tag_order, cat_order"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>