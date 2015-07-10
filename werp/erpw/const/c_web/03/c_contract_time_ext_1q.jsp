<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_cont_no = req.getParameter("arg_cont_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("extablish_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("extablish_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("issue_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("reservation_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("prepay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("membership_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
    String query = "SELECT  a.dept_code,                                       " + 
		     "                a.cont_no,													    " + 
		     "                a.chg_degree,													 " + 
		     "                a.extablish_time,											 " + 
		     "                a.extablish_tag,											    " + 
		     "                to_char(a.issue_date,'yyyy.mm.dd')  issue_date,    " + 
		     "                a.reservation_amt,											 " + 
		     "                a.supply_amt,													 " + 
		     "                a.vat_amt,	                    							 " + 
		     "                a.sum_amt,    												 " + 
		     "                a.prepay_amt,													 " + 
		     "                a.remark, 														 " +
		     "                a.membership_no, 												 " + 
		     "                to_char(a.request_dt,'yyyy.mm.dd')  request_dt    " + 
		     "           FROM R_CONTRACT_TIME_EXTABLISHED a							 " + 
		     "          WHERE a.dept_code = '" + arg_dept_code + "'              " + 
		     "            AND a.cont_no   = " + arg_cont_no + "                  " + 
		     "       ORDER BY a.EXTABLISH_TIME DESC       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>