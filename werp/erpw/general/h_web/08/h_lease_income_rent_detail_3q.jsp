<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_cont_date = req.getParameter("arg_cont_date");
     String arg_cont_seq = req.getParameter("arg_cont_seq");
   
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cont_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tmp_receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rent_supply",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rent_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("modi_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
	 dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       to_char(a.cont_date,'yyyy.mm.dd') cont_date,   " + 
     "                       a.cont_seq,   " + 
     "                       a.DEGREE_CODE,   " + 
     "                       a.DEGREE_SEQ,   " + 
     "                       to_char(a.RECEIPT_DATE,'YYYY.MM.DD') receipt_date,   " + 
     "                       to_char(a.RECEIPT_DATE,'YYYYMMDD') tmp_receipt_date,   " + 
     "                       a.DEPOSIT_NO,   " + 
     "                       a.R_AMT,   " + 
     "                       a.rent_SUPPLY,   " + 
     "                       a.rent_VAT,   " + 
     "                       a.DELAY_DAYS,   " + 
     "                       a.DELAY_AMT,   " + 
     "                       a.DISCOUNT_DAYS,   " + 
     "                       a.DISCOUNT_AMT,   " + 
     "                       to_char(a.WORK_DATE,'YYYY.MM.DD') work_date,   " + 
     "                       a.WORK_NO,   " + 
     "                       a.input_id, " +
     "                       to_char(a.INPUT_DATE,'yyyy.mm.dd hh24:mi:ss') input_date,   " + 
     "                       a.modi_yn, " +
     "                       b.BANK_NAME,  " +
	 "                       a.daily_seq "+
     "                  FROM H_LEASE_RENT_INCOME a,   " + 
     "                       H_CODE_DEPOSIT b " + 
     "                 WHERE a.DEPT_CODE = b.DEPT_CODE (+)" + 
     "                   AND a.DEPOSIT_NO = b.DEPOSIT_NO (+)" + 
     "                   AND a.DEPT_CODE = '" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE = '" + arg_sell_code + "'" + 
     "                   AND a.cont_date = '" + arg_cont_date + "'" + 
     "                   AND a.cont_seq = '" + arg_cont_seq  + "'" + 
     "              order by a.degree_code asc," + 
     "                       a.degree_seq asc     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>