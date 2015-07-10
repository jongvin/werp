<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_spec_unq_num = req.getParameter("arg_spec_unq_num");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
     String arg_contract_date = req.getParameter("arg_contract_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tmp_guarantee_receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       a.DEGREE_CODE,   " + 
     "                       to_char(a.AGREE_DATE,'YYYY.MM.DD') agree_date,   " + 
     "                       nvl(a.guarantee_amt,0) guarantee_amt,   " + 
     "                       nvl(c.tot_amt,0) tot_amt,   " + 
     "                       nvl(b.DEGREE_SEQ,0) degree_seq,   " + 
     "                       to_char(b.guarantee_receipt_date,'YYYY.MM.DD') guarantee_receipt_date,   " + 
     "                       to_char(b.guarantee_receipt_date,'YYYYMMDD') tmp_guarantee_receipt_date,   " + 
     "                       nvl(b.R_AMT,0) r_amt,   " + 
     "                       nvl(b.DELAY_AMT,0) delay_amt,   " + 
     "                       nvl(b.DISCOUNT_AMT,0) discount_amt ," + 
     "                       nvl(b.delay_days,0) delay_days, " +
     "                       nvl(b.discount_days,0) discount_days, " +
     "                       nvl(b.r_amt,0) + nvl(b.delay_amt, 0) - nvl(b.discount_amt, 0) real_amt, " +
     "                       a.f_pay_yn " +
     "                  FROM h_leas_guarantee_agree_temp a,   " + 
     "                       h_leas_guarantee_income_temp  b," + 
     "                       ( select nvl(sum(guarantee_amt),0) tot_amt " +
     "                           from h_leas_guarantee_agree_temp " +
     "                          where spec_unq_num =  " + "'" + arg_spec_unq_num + "'" + 
     "                            and dept_code = '" + arg_dept_code + "' and sell_code = '" + arg_sell_code + "'" +
     "                            and dongho = '" + arg_dongho + "' and seq = '" + arg_seq + "'" +
     "                            and contract_date = '" + arg_contract_date + "' ) c " +
     "                 WHERE a.spec_unq_num  = b.spec_unq_num (+) " + 
     "                   AND a.dept_code     = b.dept_code (+)" + 
     "                   AND a.SELL_CODE     = b.SELL_CODE (+) " + 
     "                   AND a.DONGHO        = b.DONGHO   (+)" + 
     "                   AND a.SEQ           = b.SEQ   (+)" + 
     "                   AND a.contract_date = b.contract_date (+) " +
     "                   AND a.DEGREE_CODE   = b.DEGREE_CODE  (+)" + 
     "                   AND a.spec_unq_num  = " + "'" + arg_spec_unq_num + "'" + 
     "                   AND a.DEPT_CODE   = " + "'" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE   = " + "'" + arg_sell_code + "'" + 
     "                   AND a.DONGHO      = " + "'" + arg_dongho  + "'" + 
     "                   AND a.SEQ         = " + "'" + arg_seq + "'" + 
     "                   AND a.contract_date = '" + arg_contract_date + "'" +
     "              ORDER BY a.DEPT_CODE ASC,   " + 
     "                       a.SELL_CODE ASC,   " + 
     "                       a.DONGHO ASC,   " + 
     "                       a.SEQ ASC,   " + 
     "                       a.contract_date asc, " +
     "                       a.DEGREE_CODE ASC,   " + 
     "                       b.DEGREE_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>