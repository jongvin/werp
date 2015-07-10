<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_wbs_code = req.getParameter("arg_wbs_code");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_approve = req.getParameter("arg_approve");
     String arg_text = req.getParameter("arg_text");
     arg_wbs_code = '%' + arg_wbs_code + '%';
     arg_dept_code = '%' + arg_dept_code + '%';
     arg_approve = '%' + arg_approve + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("check_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ebid_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("br_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("estimate_dt",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT b.LONG_NAME,   " + 
     "	 		a.dept_code," + 
     "         a.ORDER_NUMBER,   " + 
     "         a.APPROVE_CLASS,   " + 
     "         to_char(decode(a.approve_class,'2',a.request_dt,decode(a.approve_class,'3',a.approve_dt,decode(a.approve_class,'4',a.br_date,a.check_date))),'YYYY.MM.DD') work_dt, " +
     "         to_char(a.REQUEST_DT,'YYYY.MM.DD') REQUEST_DT,  " + 
     "         to_char(a.APPROVE_DT,'YYYY.MM.DD') APPROVE_DT,  " + 
     "         to_char(a.CHECK_DATE,'YYYY.MM.DD') CHECK_DATE,  " + 
     "         a.ORDER_NAME,   " + 
     "         to_char(a.START_DT,'YYYY.MM.DD')   START_DT," + 
     "         to_char(a.END_DT,'YYYY.MM.DD')     END_DT, " + 
     "         a.CNT_AMT,   " + 
     "         a.EXE_AMT,  " + 
     "         a.profession_wbs_code, " +
     "         c.profession_wbs_name, " +
     "         a.ebid_yn, " +
     "         a.order_class, " + 
     "         to_char(a.br_date,'yyyy.mm.dd hh24:mi') br_date,   " + 
     "         to_char(a.estimate_dt,'yyyy.mm.dd hh24:mi') estimate_dt   " + 
     "    FROM Z_CODE_DEPT b,   " + 
     "         S_ORDER_LIST  a," + 
     "         s_profession_wbs c " +
     "   WHERE a.profession_wbs_code = c.profession_wbs_code (+)" +
     "     and a.DEPT_CODE = b.DEPT_CODE     " + 
     "     and b.long_name like '" + arg_dept_code + "'" +
     "     AND decode(a.profession_wbs_code,null,' ',a.profession_wbs_code) like '" + arg_wbs_code + "'" + 
     "     and a.approve_class > '0' " +
     "     and a.approve_class like '" + arg_approve + "'" +
     "     and " + arg_text + 
     "   order by a.dept_code asc, a.request_dt desc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>