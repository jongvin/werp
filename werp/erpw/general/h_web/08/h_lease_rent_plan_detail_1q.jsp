<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_spec_unq_num = req.getParameter("arg_spec_unq_num");
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
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tmp_receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("modi_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_real_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       to_char(a.cont_date,'yyyy.mm.dd') cont_date,   " + 
     "                       a.cont_SEQ,   " + 
     "                       a.DEGREE_CODE,   " + 
     "                       to_char(a.AGREE_DATE,'YYYY.MM.DD') agree_date,   " + 
     "                       nvl(a.rent_AMT,0) amt,   " + 
     "                       nvl(c.tot_amt,0) tot_amt,   " + 
     "                       nvl(b.DEGREE_SEQ,0) degree_seq,   " + 
     "                       to_char(b.RECEIPT_DATE,'YYYY.MM.DD') receipt_date,   " + 
     "                       to_char(b.RECEIPT_DATE,'YYYYMMDD') tmp_receipt_date,   " + 
     "                       nvl(b.R_AMT,0) r_amt,   " + 
     "                       nvl(b.DELAY_AMT,0) delay_amt,   " + 
     "                       nvl(b.DISCOUNT_AMT,0) discount_amt ," + 
     "                       nvl(b.delay_days,0) delay_days, " +
     "                       nvl(b.discount_days,0) discount_days, " +
     "                       decode(b.modi_yn,'Y','C',decode(a.f_pay_yn,'N','N',decode(a.f_pay_yn_tmp,'N','C','Y'))) f_pay_yn, " +
     "                       b.modi_yn, " +
     "                       b.r_amt + b.delay_amt - b.discount_amt real_amt, " +
     "                       d.tot_r_amt, " +
     "                       d.tot_delay_amt, " +
     "                       d.tot_discount_amt, " +
     "                       d.tot_r_amt + d.tot_delay_amt - d.tot_discount_amt tot_real_amt " +
     "                  FROM H_LEASE_rent_AGREE_TEMP a,   " + 
     "                       H_LEASE_rent_INCOME_TEMP  b," + 
     "                       ( select nvl(sum(rent_amt),0) tot_amt " +
     "                           from h_lease_rent_agree_temp " +
     "                          where spec_unq_num = '" + arg_spec_unq_num + "' and dept_code = '" + arg_dept_code + "'" +
     "                            and sell_code = '" + arg_sell_code + "'" +
     "                            and cont_date = '" + arg_cont_date + "' and cont_seq = '" + arg_cont_seq + "' ) c, " +
     "                       ( select nvl(sum(r_amt),0) tot_r_amt,nvl(sum(delay_amt),0) tot_delay_amt, " +
     "                                nvl(sum(discount_amt),0) tot_discount_amt " +
     "                           from h_lease_rent_income_temp " +
     "                          where spec_unq_num = '" + arg_spec_unq_num + "' and dept_code = '" + arg_dept_code + "'" +
     "                            and sell_code = '" + arg_sell_code + "'" +
     "                            and cont_date = '" + arg_cont_date + "' and cont_seq = '" + arg_cont_seq + "' and modi_yn = 'Y') d " +
     "                 WHERE a.spec_unq_num = b.spec_unq_num (+) " +
     "                   AND a.dept_code   = b.dept_code (+)" + 
     "                   AND a.SELL_CODE   = b.SELL_CODE (+) " + 
     "                   AND a.cont_date      = b.cont_date   (+)" + 
     "                   AND a.cont_SEQ         = b.cont_SEQ   (+)" + 
     "                   AND a.DEGREE_CODE = b.DEGREE_CODE  (+)" + 
     "                   AND a.spec_unq_num = '" + arg_spec_unq_num + "'" +
     "                   AND a.DEPT_CODE   = " + "'" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE   = " + "'" + arg_sell_code + "'" + 
     "                   AND a.CONT_DATE      = " + "'" + arg_cont_date  + "'" + 
     "                   AND a.CONT_SEQ         = " + "'" + arg_cont_seq + "'" + 
     "              ORDER BY a.DEPT_CODE ASC,   " + 
     "                       a.SELL_CODE ASC,   " + 
     "                       a.cont_date ASC,   " + 
     "                       a.cont_SEQ ASC,   " + 
     "                       a.DEGREE_CODE ASC,   " + 
     "                       b.DEGREE_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>