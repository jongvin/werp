<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
	  String arg_yn = req.getParameter("arg_yn");
	  String arg_from = req.getParameter("arg_from");
	  String arg_to = req.getParameter("arg_to");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("receipt_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("bank_head_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("receipt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cancel_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("process_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("prgss_status",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
	  dSet.addDataColumn(new GauceDataColumn("receipt_class_code",GauceDataColumn.TB_STRING,4));
	  dSet.addDataColumn(new GauceDataColumn("work_seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       to_char(a.RECEIPT_DATE,'YYYY.MM.DD') receipt_date,   " + 
     "                       a.RECEIPT_SEQ,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       a.RECEIPT_CODE,   " + 
     "                       a.BANK_HEAD_CODE,   " + 
     "                       a.DEPOSIT_NO,   " + 
     "                       a.RECEIPT_AMT,   " + 
     "                       a.CANCEL_YN,   " + 
     "                       a.PROCESS_YN,   " + 
     "                       a.PRGSS_STATUS,  " + 
     "                       b.bank_name, " +
	  "                       a.receipt_class_code, " +
	  "                       a.work_seq " +
     "                  FROM H_SALE_BANK a, " + 
     "                       h_code_deposit b " +
     "                 WHERE a.deposit_no = b.deposit_no(+) and " +
	 "                             a.dept_code = b.dept_code(+) and " +
     "                       ( a.DEPT_CODE = '" + arg_dept_code + "' ) AND  " + 
     "                       ( a.SELL_CODE = '" + arg_sell_code + "' )   and " +
	  "                         a.prgss_status = '" + arg_yn +"'  and "  +
	  "                         a.receipt_date between  '"+ arg_from + "' and '" + arg_to + "'" +
     "              ORDER BY a.RECEIPT_SEQ ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>