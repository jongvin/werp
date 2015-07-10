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
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
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
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tax_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tax_no",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT DEPT_CODE,   " + 
     "                       SELL_CODE,   " + 
     "                       DONGHO,   " + 
     "                       SEQ,   " + 
     "                       DEGREE_CODE,   " + 
     "                       DEGREE_SEQ,   " + 
     "                       to_char(RECEIPT_DATE,'YYYY.MM.DD') RECEIPT_DATE,   " + 
     "                       RECEIPT_CODE,   " + 
     "                       DEPOSIT_NO,   " + 
     "                       R_AMT,   " + 
     "                       R_LAND_AMT,   " + 
     "                       R_BUILD_AMT,   " + 
     "                       R_VAT_AMT,   " + 
     "                       DELAY_DAYS,   " + 
     "                       DELAY_AMT,   " + 
     "                       DISCOUNT_DAYS,   " + 
     "                       DISCOUNT_AMT,   " + 
     "                       R_AMT + DELAY_AMT - DISCOUNT_AMT   real_amt,   " + 
     "                       INPUT_ID,   " + 
     "                       to_char(INPUT_DATE,'YYYY.MM.DD') input_date,   " + 
     "                       to_char(WORK_DATE,'YYYY.MM.DD') work_date,   " + 
     "                       WORK_NO,   " + 
     "                       to_char(TAX_DATE,'YYYY.MM.DD') tax_date,   " + 
     "                       TAX_NO  " + 
     "                  FROM H_SALE_INCOME   " + 
     "                 WHERE ( DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( SELL_CODE = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( DONGHO = " + "'" + arg_dongho + "'" + " ) AND  " + 
     "                       ( SEQ = " + "'" + arg_seq + "'" + " )   " + 
     "              ORDER BY DEGREE_CODE ASC,   " + 
     "                       DEGREE_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>