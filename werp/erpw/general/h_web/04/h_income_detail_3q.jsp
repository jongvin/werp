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
     dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("key_degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tmp_receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("receipt_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_build_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tax_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tax_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("modi_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
	 dSet.addDataColumn(new GauceDataColumn("receipt_class_code",GauceDataColumn.TB_STRING,4));
	 dSet.addDataColumn(new GauceDataColumn("receipt_number",GauceDataColumn.TB_STRING,6));
	 dSet.addDataColumn(new GauceDataColumn("card_app_num",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("card_bank_code",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("card_bank_name",GauceDataColumn.TB_STRING,40));
	 dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       a.DEGREE_CODE,   " + 
     "                       a.DEGREE_SEQ,   " + 
	  "                       a.DEGREE_CODE key_degree_code,    " + 
     "                       a.DEGREE_SEQ key_degree_seq,   " + 
     "                       to_char(a.RECEIPT_DATE,'YYYY.MM.DD') RECEIPT_DATE,   " + 
     "                       to_char(a.RECEIPT_DATE,'YYYYMMDD') TMP_RECEIPT_DATE,   " + 
     "                       a.RECEIPT_CODE,   " + 
     "                       a.DEPOSIT_NO,   " + 
     "                       a.R_AMT,   " + 
     "                       a.R_LAND_AMT,   " + 
     "                       a.R_BUILD_AMT,   " + 
     "                       a.R_VAT_AMT,   " + 
     "                       a.DELAY_DAYS,   " + 
     "                       a.DELAY_AMT,   " + 
     "                       a.DISCOUNT_DAYS,   " + 
     "                       a.DISCOUNT_AMT,   " + 
     "                       a.INPUT_ID,   " + 
     "                       to_char(a.INPUT_DATE,'yyyy.mm.dd hh24:mi:ss') input_date,   " + 
     "                       to_char(a.WORK_DATE,'YYYY.MM.DD') work_date,   " + 
     "                       a.WORK_NO,   " + 
     "                       to_char(a.TAX_DATE,'YYYY.MM.DD') tax_date,   " + 
     "                       a.TAX_NO,  " + 
     "                       a.modi_yn, " +
     "                       b.bank_name, " +
	 "                       a.receipt_class_code, " +
	 "                       a.receipt_number, " +
	 "                       a.card_app_num, " +
	 "                       a.card_bank_code, " +
	 "                       a.card_bank_code  card_bank_name," +
	 "                       a.daily_seq, "+
	 "                       a.note "+
     "                  FROM H_SALE_INCOME a,  " + 
     "                       h_code_deposit b " +
	  "                 WHERE ( a.deposit_no  = b.print_deposit_no (+) ) AND " +
	  "                      ( a.sell_code  = b.sell_code (+) ) AND " +
	 "                       ( a.dept_code  = b.dept_code (+) ) AND " +
     "                       ( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( a.SELL_CODE = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( a.DONGHO = " + "'" + arg_dongho + "'" + " ) AND  " + 
     "                       ( a.SEQ = " + "'" + arg_seq + "'" + " )   " + 
     "              ORDER BY a.DEGREE_CODE ASC,   " + 
     "                       a.DEGREE_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>