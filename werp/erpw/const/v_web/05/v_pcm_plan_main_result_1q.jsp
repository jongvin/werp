<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
    
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_order_number = req.getParameter("arg_order_number");
 String arg_seq = req.getParameter("arg_seq");
 
 //---------------------------------------------------------- 
	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("schedule_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("exe_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("supervisor",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("meeting_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("meeting_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("meeting_time",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("append_owner",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("append_sbcr",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("wbs_description",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("work_plan",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("quality_notice",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("safety_notice",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("relation_wbc_comm",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("forecast_defect",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("etc",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("append_doc",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("make_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("make_user_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("section",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.dept_code,												" + 
     "                       a.order_number,											" + 
     "                       a.order_number key_order_number,					" + 
     "                       a.seq,														" + 
     "                       a.sbcr_code,												" + 
     "                       a.order_name,											" + 
     "                       to_char(a.schedule_dt, 'yyyy.mm.dd')	schedule_dt,	" + 
     "                       to_char(a.exe_dt, 'yyyy.mm.dd') exe_dt,					" + 
     "                       a.supervisor,											" + 
     "                       a.remark,													" + 
     "                       a.sbcr_name,												" + 
     "                       a.meeting_name,											" + 
     "                       a.meeting_dt,											" + 
     "                       a.meeting_time,											" + 
     "                       a.append_owner,											" + 
     "                       a.append_sbcr,											" + 
     "                       a.wbs_description,										" + 
     "                       a.work_plan,												" + 
     "                       a.quality_notice,										" + 
     "                       a.safety_notice,										" + 
     "                       a.relation_wbc_comm,									" + 
     "                       a.forecast_defect,										" + 
     "                       a.etc,														" + 
     "                       a.append_doc,											" + 
     "                       a.make_dt,												" + 
     "                       a.make_user_no,											" +
     "                       a.section,												" +
     "                       a.code														" +
     "                  FROM v_pcm_plan a   											" +
     "                 WHERE a.dept_code='" + arg_dept_code + "'				" +
	  "						 and a.order_number = '"+arg_order_number+"'			" +
	  "						 and a.seq = '"+arg_seq+"'									" + 
     "              ORDER BY a.dept_code ASC,										" + 
     "                       a.sbcr_code ASC,										" +
     "                       a.order_number ASC,                           " + 
     "                       a.seq DESC                                    " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>