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
     dSet.addDataColumn(new GauceDataColumn("refund_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("penalty",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("term_interest",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("income_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("residence_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_tax",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_deduct_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("subtr_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("loan_cap",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("refund_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bank_head_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("bank_head_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("annul_reason",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       to_char(a.REFUND_DATE,'YYYY.MM.DD') refund_date,   " + 
     "                       a.PENALTY,   " + 
     "                       a.TERM_INTEREST,   " + 
     "                       a.INCOME_TAX,   " + 
     "                       a.RESIDENCE_TAX,   " + 
     "                       a.INCOME_TAX + RESIDENCE_TAX COMP_TAX," +
     "                       a.LEASE_DEDUCT_AMT,   " + 
     "                       a.SUBTR_AMT,   " + 
     "                       a.LOAN_CAP,   " + 
     "                       a.REFUND_AMT,   " + 
     "                       a.BANK_HEAD_CODE,   " + 
     "					        a.bank_head_name ," + 
     "                       a.DEPOSIT_NO,   " + 
     "                       a.ANNUL_REASON  " + 
     "                  FROM H_SALE_ANNUL a  " + 
     "                 WHERE a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   AND a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "                   AND a.DONGHO = " + "'" + arg_dongho  + "'" + 
     "                   AND a.SEQ = " + "'" + arg_seq + "'" + 
     "                 ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>