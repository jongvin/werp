<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
	 
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("paid_date",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("paid_seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("key_paid_date",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("key_paid_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("loan_interest_tag",GauceDataColumn.TB_STRING,2,0));
	  dSet.addDataColumn(new GauceDataColumn("loan_bank_code",GauceDataColumn.TB_STRING,8,0));
    String query = "select dept_code," + 
     "       sell_code," + 
     "       dongho," + 
     "       seq," + 
     "       to_char(paid_date,'yyyy.mm.dd') paid_date ," + 
	  "       paid_seq, "+
	  "       to_char(paid_date,'yyyy.mm.dd') key_paid_date ," + 
	  "       paid_seq key_paid_seq, "+
     "       amt," + 
     "		 memo," + 
	  "       loan_interest_tag, "+
	  "       loan_bank_code "+
     "  from h_sale_loan_interest" + 
     " where dept_code = '"+arg_dept_code+"'" + 
     "   and sell_code = '"+arg_sell_code+"'" + 
     "	and dongho    = '"+arg_dongho+"'" + 
     "	and seq       = '"+arg_seq+"'"+
	  "order by loan_interest_tag, paid_date, paid_seq";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>