<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_deposit_no = req.getParameter("arg_deposit_no");
 String arg_apply_yn = req.getParameter("arg_apply_yn");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("deposit_no_key",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("receipt_date_key",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("receipt_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("deposit_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("fb_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("confirm_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("apply_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("error_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("error_msg",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
    String query = "SELECT DEPOSIT_NO, " + 
     "       to_char(RECEIPT_DATE, 'yyyy.mm.dd') RECEIPT_DATE, " + 
	  "       DEPOSIT_NO deposit_no_key, " + 
     "       to_char(RECEIPT_DATE, 'yyyy.mm.dd') RECEIPT_DATE_key, " + 
     "       RECEIPT_SEQ, " + 
     "       RECEIPT_CODE, " + 
     "       DEPOSIT_NAME, " + 
     "       FB_SEQ, " + 
     "		 AMT, " + 
     "       CONFIRM_AMT, " + 
     "       INPUT_ID, " + 
     "		 to_char(INPUT_DATE, 'yyyy.mm.dd hh:mi:ss') INPUT_DATE , " + 
     "       MEMO, " + 
     "       DEPT_CODE, " + 
     "		 SELL_CODE, " + 
     "       DONGHO, " + 
     "       SEQ, " + 
     "		 DAILY_SEQ, " + 
     "       APPLY_YN, " + 
     "       ERROR_CODE, " + 
     "		 ERROR_MSG, " + 
     "       WORK_NO, " + 
     "       WORK_DATE" + 
     " FROM H_SALE_INCOME_UNKNOWN" + 
     " where deposit_no like decode('"+arg_deposit_no+"' , 'ALL', '%', '" +arg_deposit_no+"')" + 
     "  and apply_yn = '"+arg_apply_yn     +"'" +
	  "  order by deposit_no , receipt_date, receipt_seq";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>