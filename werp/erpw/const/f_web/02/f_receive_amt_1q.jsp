<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("receive_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bill_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("check_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bank_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rqst_detail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("comp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_receive_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_tag",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("input_tag1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invoice_num1",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "         to_char(RECEIVE_DATE,'YYYY.MM.DD') RECEIVE_DATE,   " + 
     "         SEQ,   " + 
     "         CASH_AMT,   " + 
     "         BILL_AMT,   " + 
     "         CHECK_AMT,   " + 
     "         BANK_AMT,   " + 
     "         ETC_AMT,   " + 
     "         RQST_DETAIL   ," + 
     "         CASH_AMT + BILL_AMT + CHECK_AMT + BANK_AMT + ETC_AMT     comp_amt, " +
     "         to_char(RECEIVE_DATE,'YYYY.MM.DD') KEY_RECEIVE_DATE,   " + 
     "         SEQ   KEY_SEQ, " + 
     "         INPUT_TAG, " +
     "         INPUT_TAG INPUT_TAG1, " +
     "         INVOICE_NUM, " +
     "         INVOICE_NUM1 " +
     "    FROM F_RECEIVE_AMT  " + 
     "   WHERE DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "  ORDER BY RECEIVE_DATE ASC," + 
     "			SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>