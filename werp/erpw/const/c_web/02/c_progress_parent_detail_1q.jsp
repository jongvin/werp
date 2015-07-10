<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,53));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invest_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("plan_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_per_y",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("plan_amt_y",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_per_y",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("real_amt_y",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_plan_mm_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("sum_plan_mm_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("yyyy_mm",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("plan_mm_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("plan_mm_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_mm_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("real_mm_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.dept_code,   " + 
     "         a.chg_no_seq,   " + 
     "         a.wbs_code,   " + 
     "         decode(length(a.wbs_code),1,b.name,'   ' || b.name) name," + 
     "         a.seq,   " + 
     "         a.invest_class,   " + 
     "         a.plan_per,   " + 
     "         a.plan_amt,   " + 
     "         a.real_per,   " + 
     "         a.real_amt,  " + 
     "         decode(a.invest_class,'Y',a.plan_per,0)  plan_per_y, " + 
     "         decode(a.invest_class,'Y',a.plan_amt,0)  plan_amt_y, " + 
     "         decode(a.invest_class,'Y',a.real_per,0)  real_per_y, " + 
     "         decode(a.invest_class,'Y',a.real_amt,0)  real_amt_y, " + 
     "         c.sum_plan_mm_per,  " + 
     "         c.sum_plan_mm_amt,  " + 
     "         to_char(d.year,'yyyy.mm') yyyy_mm,   " + 
     "         to_char(d.year,'yyyy.mm.dd') year,   " + 
     "         d.plan_mm_per,   " + 
     "         d.plan_mm_amt,   " + 
     "         d.real_mm_per,   " + 
     "         d.real_mm_amt  " + 
     "    FROM c_progress_parent a," + 
     "         y_wbs_code b, " + 
     "        (select dept_code,chg_no_seq,wbs_code,sum(plan_mm_per)  sum_plan_mm_per, " + 
     "                sum(plan_mm_amt) sum_plan_mm_amt        " + 
     "            from c_progress_detail        " + 
     "            where ( dept_code = '" + arg_dept_code + "' ) " + 
     "              and ( chg_no_seq = " + arg_chg_no_seq + ") " + 
     "             Group by dept_code,chg_no_seq,wbs_code order by  dept_code,chg_no_seq,wbs_code) c, " + 
     "         c_progress_detail d " + 
     "   WHERE a.wbs_code = b.wbs_code" + 
     "     and ( a.dept_code = '" + arg_dept_code + "' ) " + 
     "     and ( a.chg_no_seq = " + arg_chg_no_seq + ") " + 
     "     and ( a.dept_code = c.dept_code (+)) " + 
     "     and ( a.chg_no_seq = c.chg_no_seq (+)) " + 
     "     and ( a.wbs_code = c.wbs_code (+)) " + 
     "     and ( a.dept_code = d.dept_code) " + 
     "     and ( a.chg_no_seq = d.chg_no_seq) " + 
     "     and ( a.wbs_code = d.wbs_code) " + 
     "  order by a.seq,d.year      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>