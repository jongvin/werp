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
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_class_code",GauceDataColumn.TB_STRING,4));
	 dSet.addDataColumn(new GauceDataColumn("loan_interest_tag",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("loan_rdm_yn",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("loan_degree_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "                       a.SEQ,   " + 
     "                       to_char(a.receipt_date,'yyyy.mm.dd') receipt_date,   " + 
     "                       a.daily_seq,   " + 
	  "                       a.amt,   " + 
     "                       a.receipt_class_code, " +
	 "                       a.loan_interest_tag, "+
	 "                       a.loan_rdm_yn, "+
	 "                       a.loan_degree_code "+
     "                  FROM H_SALE_INCOME_daily a  " + 
   "                 WHERE  ( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "                       ( a.SELL_CODE = " + "'" + arg_sell_code + "'" + " ) AND  " + 
     "                       ( a.DONGHO = " + "'" + arg_dongho + "'" + " ) AND  " + 
     "                       ( a.SEQ = " + "'" + arg_seq + "'" + " )   and" +
	  "                          length(trim(a.receipt_class_code)) is not null "+
     "              ORDER BY a.receipt_date ASC,   " + 
     "                       a.daily_seq ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>