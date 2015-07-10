<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rqst_detail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("key_cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("vatcode",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("fund_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("acntname",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("vatname",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("rqst_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,10,0));
     dSet.addDataColumn(new GauceDataColumn("slip_check",GauceDataColumn.TB_STRING,1));
    String query = "SELECT max(a.RES_TYPE) res_type,   " + 
     "		max(a.RQST_DETAIL) RQST_DETAIL,   " + 
     "          max(a.cust_code) key_cust_code, " + 
     "         decode(max(d.cust_type),'1',substrb(max(a.CUST_CODE),1,3) || '-' || substrb(max(a.cust_code),4,2) || '-' || substrb(max(a.cust_code),6,5),decode(max(d.cust_type),'2',substrb(max(a.cust_code),1,6) || '-' || substrb(max(a.cust_code),7,7),max(a.cust_code))) cust_code,   " + 
     "		max(a.CUST_NAME) CUST_NAME,   " + 
     "		max(a.VATCODE) VATCODE,   " + 
     "		sum(a.AMT) AMT,   " + 
     "		sum(a.VAT) VAT,   " + 
     "		max(a.ACNTCODE) ACNTCODE,   " + 
     "		max(a.FUND_TYPE) FUND_TYPE,   " + 
     "		to_char(max(a.RECEIPT_DATE),'YYYY.MM.DD') RECEIPT_DATE,   " + 
     "		max(b.ACNTNAME) ACNTNAME,   " + 
     "		max(c.VATNAME) VATNAME, " + 
     "          to_char(max(a.rqst_date),'YYYY.MM.DD') rqst_date, " +
     "          max(a.seq) seq, " +
     "          'F' slip_check " +
     " FROM F_REQUEST a,   " + 
     "		Z_CODE_ACNT b,   " + 
     "		Z_CODE_VAT_VIEW  c, " + 
     "          Z_CODE_CUST_CODE d " +
     " WHERE ( a.acntcode = b.acntcode (+) ) and  " + 
     "		( a.cust_code = d.cust_code (+) ) and  " + 
     "		( a.vatcode = c.vatcode (+) ) and  " + 
     "		( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "		( a.RQST_DATE >= " + "'" + arg_from_date + "'" + " )  AND" + 
     "		( a.RQST_DATE <= " + "'" + arg_to_date + "'" + " ) and" + 
     "          ( a.ACNTCODE is not null) and " +
     "		( a.vatcode is null)" + 
     " GROUP BY a.dept_code ,a.res_type,a.cust_code" + 
     " union all " + 
     " SELECT a.RES_TYPE,   " + 
     "		a.RQST_DETAIL,   " + 
     "          a.cust_code key_cust_code, " + 
     "         decode(d.cust_type,'1',substrb(a.CUST_CODE,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,6,5),decode(d.cust_type,'2',substrb(a.cust_code,1,6) || '-' || substrb(a.cust_code,7,7),a.cust_code)) cust_code,   " + 
     "		a.CUST_NAME,   " + 
     "		a.VATCODE,   " + 
     "		a.AMT,   " + 
     "		a.VAT,   " + 
     "		a.ACNTCODE,   " + 
     "		a.FUND_TYPE,   " + 
     "		to_char(a.RECEIPT_DATE,'YYYY.MM.DD') RECEIPT_DATE,   " + 
     "		b.ACNTNAME,   " + 
     "		c.VATNAME, " + 
     "          to_char(a.rqst_date,'YYYY.MM.DD') rqst_date, " +
     "          a.seq, " +
     "          'F' slip_check " +
     " FROM F_REQUEST a,   " + 
     "		Z_CODE_ACNT b,   " + 
     "		Z_CODE_VAT_VIEW  c, " + 
     "          Z_CODE_CUST_CODE d " +
     " WHERE ( a.acntcode = b.acntcode (+) ) and  " + 
     "		( a.cust_code = d.cust_code (+) ) and  " + 
     "		( a.vatcode = c.vatcode (+) ) and  " + 
     "		( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "		( a.RQST_DATE >= " + "'" + arg_from_date + "'" + " )  AND" + 
     "		( a.RQST_DATE <= " + "'" + arg_to_date + "'" + " ) and" + 
     "          ( a.ACNTCODE is not null) and " +
     "		( a.vatcode is not null)     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>