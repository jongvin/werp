<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date      = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("rqst_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("exe_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rqst_detail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("vatcode",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,20));
	 dSet.addDataColumn(new GauceDataColumn("acntname",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("fund_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cost_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receipt_rqst_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("pay_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("credit_card_no",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("card_user",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,40));
	 dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("use_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cash_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bill_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deduct_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bill_cash_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("det_code",GauceDataColumn.TB_STRING,3));
	 dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("dr_class",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("income_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("income_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("civi_amt",GauceDataColumn.TB_DECIMAL,18,0));
       dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("temp_chk",GauceDataColumn.TB_STRING,1));
   
    String query = " SELECT a.DEPT_CODE,"   +
"          to_char(a.RQST_DATE,'YYYY.MM.DD')   RQST_DATE,"   +
"          a.SEQ,"   +
"          a.RES_TYPE,"   +
"          a.exe_TYPE,"   +
"          a.RQST_DETAIL,"   +
"          a.ORDER_NUMBER,"   +
"          a.CUST_CODE cust_code,"   +
"          a.CUST_NAME,"   +
"          a.VATCODE,"   +
"          a.AMT,"   +
"          a.VAT,"   +
"          a.ACNTCODE,"   +
" 				a.acntname,"   +
"          a.FUND_TYPE,"   +
"          a.COST_TYPE,"   +
"          a.RECEIPT_RQST_TYPE,"   +
"          to_char(a.RECEIPT_DATE,'YYYY.MM.DD')   RECEIPT_DATE,"   +
"          to_char(a.pay_date,'YYYY.MM.DD')   pay_date,"   +
"          a.CREDIT_CARD_NO,"   +
"          a.CARD_USER,"   +
"          a.SPEC_NO_SEQ,"   +
"          a.SPEC_UNQ_NUM,"   +
"          e.name  spec_name,"   +
"          e.detail_code," +
"          a.SEQ   key_seq,"   +
"          a.use_name ,"   +
"          a.cash_amt,"   +
"          a.bill_amt,"   +
"          a.deduct_amt,"   +
"          (a.cash_amt+a.bill_amt) bill_cash_amt,"   +
"          a.code,"   +
"          a.det_code,"   +
"          a.item_code ,a.invoice_num,a.dr_class,"+
"          a.income_type,a.income_amt,a.civi_amt, " +
"          to_char(a.work_date,'YYYY.MM.DD') work_date, " +
"          a.temp_chk " + 
"     FROM F_REQUEST a,"   +
"          y_budget_detail e"   +
"    WHERE a.dept_code    = e.dept_code (+)    and"   +
"          a.spec_no_seq  = e.spec_no_seq(+)   and"   +
"          a.spec_unq_num = e.spec_unq_num (+) and"   +
"          a.DEPT_CODE = '"+arg_dept_code+"' and"   +
"          a.RQST_DATE = '"+arg_date+"' and"   +
"          a.res_class = 'X'  and "+
"          a.cost_type = '1' " +
" ORDER BY a.SEQ ASC,"   +
"          a.RES_TYPE ASC"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>