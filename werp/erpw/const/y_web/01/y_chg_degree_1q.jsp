<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //-----------------------------------------------------------
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_title",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("process_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,32759));
     dSet.addDataColumn(new GauceDataColumn("charge_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_class",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("chg_name",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  y_chg_degree.dept_code ," + 
     "          y_chg_degree.chg_no_seq ," + 
     "          y_chg_degree.chg_degree ," + 
     "          y_chg_degree.chg_title ," + 
     "          y_chg_degree.approve_class ," + 
     "          y_chg_degree.process_yn ," + 
     "          to_char(y_chg_degree.work_dt,'yyyy.mm.dd') work_dt," + 
     "          to_char(y_chg_degree.request_dt,'yyyy.mm.dd') request_dt ," + 
     "          to_char(y_chg_degree.approve_dt ,'yyyy.mm.dd') approve_dt," + 
     "          nvl(y_chg_degree.cnt_amt, 0) cnt_amt ," + 
     "          y_chg_degree.remark ," + 
     "          y_chg_degree.charge_name ," + 
     "          to_char(y_chg_degree.input_dt,'yyyy.mm.dd') input_dt ," + 
     "          y_chg_degree.input_name, " + 
     "          y_chg_degree.amt, " + 
     "          y_chg_degree.chg_class, " + 
	 "          decode(y_chg_degree.chg_class, '1', '부분실행', '2', '본실행', '3', '예정변경') chg_name "+
     "     FROM y_chg_degree      WHERE ( y_chg_degree.dept_code = " + "'" + arg_dept_code + "'" + " )  ORDER BY y_chg_degree.dept_code          ASC," + 
     "          y_chg_degree.chg_no_seq          DESC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>