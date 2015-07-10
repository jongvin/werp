<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
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
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tmp_guarantee_receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
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
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date, " +
     "                       a.DEGREE_CODE,   " + 
     "                       a.DEGREE_SEQ,   " + 
     "                       to_char(a.guarantee_receipt_date,'YYYY.MM.DD') guarantee_receipt_date,   " + 
     "                       to_char(a.guarantee_receipt_date,'YYYYMMDD') tmp_guarantee_receipt_date,   " + 
     "                       a.DEPOSIT_NO,   " + 
     "                       a.R_AMT,   " + 
     "                       a.DELAY_DAYS,   " + 
     "                       a.DELAY_AMT,   " + 
     "                       a.DISCOUNT_DAYS,   " + 
     "                       a.DISCOUNT_AMT,   " + 
     "                       to_char(a.WORK_DATE,'YYYY.MM.DD') work_date,   " + 
     "                       a.WORK_NO,   " + 
     "                       a.input_id, " +
     "                       to_char(a.INPUT_DATE,'yyyy.mm.dd hh24:mi:ss') input_date,   " + 
     "                       a.modi_yn, " +
     "                       b.bank_name " +
     "                  FROM h_leas_guarantee_income a,  " + 
     "                       h_code_deposit b " +
     "                 WHERE ( a.deposit_no  = b.deposit_no (+) ) AND " +
	 "                            ( a.dept_code  = b.dept_code (+) ) AND "+
     "                       ( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( a.SELL_CODE = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( a.DONGHO = " + "'" + arg_dongho + "'" + " ) AND  " + 
     "                       ( a.SEQ = " + "'" + arg_seq + "'" + " ) AND  " + 
     "                       ( a.contract_date = '" + arg_contract_date + "' ) " +
     "              ORDER BY a.DEGREE_CODE ASC,   " + 
     "                       a.DEGREE_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>