<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String arg_dept = req.getParameter("arg_dept");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,70));
    String query = " select '1' tag, to_char(yymm, 'yyyy.mm') yymm, count(*) cnt, a.dept_code, b.long_name  " + 
						 "	  from s_pay           a,   " + 
						 "	       z_code_dept      b  " + 
						 "	 where a.dept_code = b.dept_code  " + 
						 "	   and a.dept_code in (select distinct dept_code from y_chg_budget_parent)   " + 
						 "	   and a.dept_code <> '5030040'      " + 
						 "	 group by a.dept_code, to_char(yymm, 'yyyy.mm'), b.long_name    " + 
						 "	union  " + 
						 "	select '2' tag, to_char(yymmdd,'yyyy.mm') yymm, count(*) cnt, a.dept_code, b.long_name    " + 
						 "	  from m_input_detail a,   " + 
						 "	       z_code_dept    b  " + 
						 "	 where a.dept_code = b.dept_code  " + 
						 "	   and a.dept_code in (select distinct dept_code from y_chg_budget_parent)   " + 
						 "	   and a.dept_code <> '5030040'      " + 
						 "	 group by a.dept_code, to_char(yymmdd,'yyyy.mm'), b.long_name    " + 
						 "	union  " + 
						 "	select '3' tag, to_char(work_date,'yyyy.mm') yymm, count(*) cnt, a.dept_code, b.long_name    " + 
						 "	  from l_labor_dailywork a,   " + 
						 "	       z_code_dept      b  " + 
						 "	 where a.dept_code = b.dept_code  " + 
						 "	   and a.dept_code in (select distinct dept_code from y_chg_budget_parent)   " + 
						 "	   and a.dept_code <> '5030040'      " + 
						 "	 group by a.dept_code, to_char(work_date,'yyyy.mm'), b.long_name    " + 
						 "	union  " + 
						 "	select '4' tag, to_char(run_date,'yyyy.mm') yymm, count(*) cnt, a.dept_code, b.long_name    " + 
						 "	  from q_daily_run      a,   " + 
						 "	       z_code_dept      b  " + 
						 "	 where a.dept_code = b.dept_code  " + 
						 "	   and a.dept_code in (select distinct dept_code from y_chg_budget_parent)   " + 
						 "	   and a.dept_code <> '5030040'      " + 
						 "	 group by a.dept_code, to_char(run_date,'yyyy.mm'), b.long_name    " + 
						 "	union  " + 
						 "	select '5' tag, to_char(yymm,'yyyy.mm') yymm, count(*) cnt, a.dept_code, b.long_name    " + 
						 "	  from f_request_detail a,   " + 
						 "	       z_code_dept      b  " + 
						 "	 where a.dept_code = b.dept_code  " + 
						 "	   and a.dept_code in (select distinct dept_code from y_chg_budget_parent)   " + 
						 "	   and a.dept_code <> '5030040'      " + 
						 "	 group by a.dept_code, to_char(yymm,'yyyy.mm'), b.long_name    " + 
						 "	union  " + 
						 "	select '6' tag, to_char(rqst_date,'yyyy.mm') yymm, count(*) cnt, a.dept_code, b.long_name    " + 
						 "	  from f_request        a,   " + 
						 "	       z_code_dept      b  " + 
						 "	 where a.dept_code = b.dept_code  " + 
						 "	   and a.dept_code in (select distinct dept_code from y_chg_budget_parent)   " + 
						 "	   and a.dept_code <> '5030040'      " + 
						 "	 group by a.dept_code, to_char(rqst_date,'yyyy.mm'), b.long_name    " + 
						 "	order by dept_code, yymm, tag   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>