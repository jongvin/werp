<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tmp_receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_supply",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       a.DEGREE_CODE,   " + 
     "                       to_char(a.AGREE_DATE,'YYYY.MM.DD') agree_date,   " + 
     "                       to_char(a.S_DATE,'YYYY.MM.DD') s_date,   " + 
     "                       to_char(a.E_DATE,'YYYY.MM.DD') e_date,   " + 
     "                       a.days, " +
     "                       nvl(a.lease_amt,0) lease_amt,   " + 
     "                       nvl(a.pay_tot_amt,0) pay_tot_amt, " +
     "                       nvl(b.DEGREE_SEQ,0) degree_seq,   " + 
     "                       to_char(b.RECEIPT_DATE,'YYYY.MM.DD') receipt_date,   " + 
     "                       to_char(b.RECEIPT_DATE,'YYYYMMDD') tmp_receipt_date,   " + 
     "                       nvl(b.R_AMT,0) r_amt,   " + 
     "                       nvl(b.LEASE_SUPPLY,0) lease_supply,   " + 
     "                       nvl(b.lease_vat,0) lease_vat,   " + 
     "                       nvl(b.DELAY_AMT,0) delay_amt,   " + 
     "                       nvl(b.DISCOUNT_AMT,0) discount_amt ," + 
     "                       nvl(b.delay_days,0) delay_days, " +
     "                       nvl(b.discount_days,0) discount_days, " +
     "                       a.f_pay_yn " +
     "                  FROM h_leas_lease_agree a,   " + 
     "                       h_leas_lease_income  b" + 
     "                 WHERE a.dept_code     = b.dept_code (+)" + 
     "                   AND a.SELL_CODE     = b.SELL_CODE (+) " + 
     "                   AND a.DONGHO        = b.DONGHO   (+)" + 
     "                   AND a.SEQ           = b.SEQ   (+)" + 
     "                   AND a.DEGREE_CODE   = b.DEGREE_CODE  (+)" + 
     "                   AND a.DEPT_CODE   = " + "'" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE   = " + "'" + arg_sell_code + "'" + 
     "                   AND a.DONGHO      = " + "'" + arg_dongho  + "'" + 
     "                   AND a.SEQ         = " + "'" + arg_seq + "'" + 
     "              ORDER BY a.DEPT_CODE ASC,   " + 
     "                       a.SELL_CODE ASC,   " + 
     "                       a.DONGHO ASC,   " + 
     "                       a.SEQ ASC,   " + 
     "                       a.DEGREE_CODE ASC,   " + 
     "                       b.DEGREE_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>