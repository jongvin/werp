<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("pay_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pay_detail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fund_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("key_pay_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.PAY_DATE,'YYYY.MM.DD')  PAY_DATE,   " + 
     "         a.SEQ,   " + 
     "         a.RES_TYPE,   " + 
     "         a.PAY_DETAIL,   " + 
     "         decode(b.cust_type,'1',substrb(a.CUST_CODE,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,6,5),decode(b.cust_type,'2',substrb(a.cust_code,1,6) || '-' || substrb(a.cust_code,7,7),a.cust_code)) cust_code,   " + 
     "         a.CUST_NAME,   " + 
     "         a.AMT,   " + 
     "         a.VAT,   " + 
     "         a.FUND_TYPE," + 
     "         to_char(a.PAY_DATE,'YYYY.MM.DD') key_pay_date," + 
     "         a.SEQ      key_seq   "  + 
     "    FROM F_PAYMENT a, " + 
     "         z_code_cust_code b " +
     "   WHERE a.cust_code = b.cust_code (+) and " +
     "         a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " AND  " + 
     "         substr(to_char(a.PAY_DATE,'YYYY.MM.DD'),1,7) = substr(" + "'" + arg_date + "'" +  ",1,7) " +
     " ORDER BY a.PAY_DATE ASC," + 
     "		a.SEQ ASC,   " + 
     "          a.RES_TYPE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>