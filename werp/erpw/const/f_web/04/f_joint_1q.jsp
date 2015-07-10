<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("rqst_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rqst_detail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fund_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cost_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receipt_rqst_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("credit_card_no",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("card_user",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT DEPT_CODE,   " + 
     "         to_char(RQST_DATE,'YYYY.MM.DD')   RQST_DATE, " + 
     "         SEQ,   " + 
     "         RES_TYPE,   " + 
     "         RQST_DETAIL,   " + 
     "         CUST_CODE,   " + 
     "         CUST_NAME,   " + 
     "         AMT,   " + 
     "         VAT,   " + 
     "         FUND_TYPE,   " + 
     "         COST_TYPE,   " + 
     "         RECEIPT_RQST_TYPE,   " + 
     "         to_char(RECEIPT_DATE,'YYYY.MM.DD')  RECEIPT_DATE,  " + 
     "         CREDIT_CARD_NO,   " + 
     "         CARD_USER" + 
     "    FROM F_REQUEST " + 
     "   WHERE ( DEPT_CODE = '" + arg_dept_code + "' ) AND  " + 
     "         substr(to_char(RQST_DATE,'YYYY.MM.DD'),1,7) = substr('" + arg_date + "',1,7) and " +
     "         ( fund_type <> '4' )" + 
     "ORDER BY RQST_DATE ASC, " +
     "         SEQ ASC,   " + 
     "         RES_TYPE ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>