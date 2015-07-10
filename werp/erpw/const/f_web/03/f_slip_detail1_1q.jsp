<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date   = req.getParameter("arg_to_date");
     String arg_cust_code = req.getParameter("arg_cust_code");
     String arg_res_type  = req.getParameter("arg_res_type");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("rqst_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rqst_detail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("vatcode",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("fund_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("acntname",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("vatname",GauceDataColumn.TB_STRING,40));
    String query = "SELECT to_char(a.rqst_date,'YYYY.MM.DD') rqst_date, " + 
     "		a.seq, " + 
     "		a.RES_TYPE,   " + 
     "		a.RQST_DETAIL,   " + 
     "		a.CUST_CODE,   " + 
     "		a.CUST_NAME,   " + 
     "		a.VATCODE,   " + 
     "		nvl(a.AMT,0) amt,   " + 
     "		nvl(a.VAT,0) vat,   " + 
     "		a.ACNTCODE,   " + 
     "		a.FUND_TYPE,   " + 
     "		to_char(a.RECEIPT_DATE,'YYYY.MM.DD') RECEIPT_DATE,  " + 
     "		to_char(a.work_date,'YYYY.MM.DD') work_date," + 
     "		nvl(a.work_no,0) work_no," + 
     "		b.ACNTNAME,   " + 
     "		c.VATNAME " + 
     " FROM F_REQUEST a,   " + 
     "		Z_CODE_ACNT b,   " + 
     "		Z_CODE_VAT_VIEW  c" + 
     " WHERE ( a.acntcode = b.acntcode (+) ) and  " + 
     "		( a.vatcode = c.vatcode (+) ) and  " + 
     "		( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "		( a.RQST_DATE >= " + "'" + arg_from_date + "'" + " )  AND" + 
     "		( a.RQST_DATE <= " + "'" + arg_to_date + "'" + " ) and" + 
     " 		( a.cust_code = " + "'" + arg_cust_code + "'" + " ) and" + 
     " 		( a.res_type  = " + "'" + arg_res_type + "'" + " ) and" + 
     "          ( a.ACNTCODE is not null) and " +
     "		( a.vatcode is null)" + 
     " order by a.rqst_date asc ,a.seq asc     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>