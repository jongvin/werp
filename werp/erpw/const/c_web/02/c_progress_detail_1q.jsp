<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
     String arg_wbs_code = req.getParameter("arg_wbs_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("yyyy_mm",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("plan_mm_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("plan_mm_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_mm_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("real_mm_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT c_progress_detail.dept_code,   " + 
     "         c_progress_detail.chg_no_seq,   " + 
     "         c_progress_detail.wbs_code,   " + 
     "         to_char(c_progress_detail.year,'yyyy.mm') yyyy_mm,   " + 
     "         to_char(c_progress_detail.year,'yyyy.mm.dd') year,   " + 
     "         c_progress_detail.plan_mm_per,   " + 
     "         c_progress_detail.plan_mm_amt,   " + 
     "         c_progress_detail.real_mm_per,   " + 
     "         c_progress_detail.real_mm_amt  " + 
     "    FROM c_progress_detail  " + 
     "   WHERE ( c_progress_detail.dept_code = '" + arg_dept_code + "' ) AND  " + 
     "         ( c_progress_detail.chg_no_seq = " + arg_chg_no_seq + ") AND  " + 
     "         ( c_progress_detail.wbs_code = '" + arg_wbs_code  + "')   " + 
     "   order by year              ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>