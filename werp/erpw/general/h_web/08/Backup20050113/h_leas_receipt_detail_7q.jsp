<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code   	= req.getParameter("arg_dept_code");  
     String arg_sell_code   	= req.getParameter("arg_sell_code");
     String arg_dongho 			= req.getParameter("arg_dongho");
     String arg_seq    			= req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("credit_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("credit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("creditor",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("credit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("not_income_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("not_income_month",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("cancel_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cancel_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("key_1",GauceDataColumn.TB_STRING,2));
    String query = "select a.dept_code," + 
     "		 a.sell_code," + 
     "		 a.dongho," + 
     "		 nvl(a.seq, 0) seq," + 
     "       a.credit_code," + 
     "       to_char(a.receipt_date, 'yyyy.mm.dd') receipt_date," + 
     "       a.credit_no," + 
     "       a.creditor," + 
     "       nvl(a.credit_amt, 0) credit_amt," + 
     "       nvl(a.not_income_amt, 0) not_income_amt," + 
     "       a.not_income_month," + 
     "       a.cancel_yn," + 
     "       to_char(a.cancel_date, 'yyyy.mm.dd') cancel_date," + 
     "       a.remark," +
     "       a.credit_code key_1" +
     "  from h_leas_etc a" + 
     " where a.dept_code 	  = '" + arg_dept_code 		+ "'" + 
     "   and a.sell_code 	  = '" + arg_sell_code 		+ "'" + 
     "   and a.dongho    	  = '" + arg_dongho    		+ "'" + 
     "   and a.seq       	  = '" + arg_seq       		+ "'" ; 
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>