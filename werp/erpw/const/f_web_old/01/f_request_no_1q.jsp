<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_form_dt = req.getParameter("arg_form_dt");
     String arg_to_dt = req.getParameter("arg_to_dt");
	 String arg_wbs_code = req.getParameter("arg_wbs_code"); 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("rqst_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("slip_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("slip_spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_rqst_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_slip_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cont",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("vatcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("fund_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cost_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receipt_rqst_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("credit_card_no",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("card_user",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("slipdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cr_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("profit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tax_code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("prepay_date1",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("prepay_date2",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("prepay_acntcode",GauceDataColumn.TB_STRING,8));
	 dSet.addDataColumn(new GauceDataColumn("prepay_account_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fa_qnty",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mdfy_yn",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("t_slip_no",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("t_slip_chk",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.rqst_date,'YYYY.MM.DD') rqst_date ," + 
     					 "          a.slip_seq ," + 
     					 "          a.slip_spec_unq_num, " +
     					 "          a.seq ," + 
     					 "          to_char(a.rqst_date,'YYYY.MM.DD')  key_rqst_date," + 
     					 "          a.slip_seq  key_slip_seq," + 
     					 "          a.seq  key_seq," + 
     					 "          a.res_type ," + 
     					 "          a.cont ," + 
     					 "          a.order_number ," + 
     					 "          a.cust_code ," + 
     					 "          a.cust_name ," + 
     					 "          a.vatcode ," + 
     					 "          a.amt ," + 
     					 "          a.vat ," + 
     					 "          a.acntcode ," + 
     					 "          a.fund_type ," + 
     					 "          a.cost_type ," + 
     					 "          a.receipt_rqst_type ," + 
     					 "          to_char(a.receipt_date,'YYYY.MM.DD') receipt_date," + 
     					 "          a.credit_card_no ," + 
     					 "          a.card_user ," + 
     					 "          a.spec_no_seq ," + 
     					 "          a.spec_unq_num ," + 
     					 "          to_char(a.slipdate,'YYYY.MM.DD') slipdate," + 
     					 "          a.invoice_num ," +
     					 "          a.cr_class , " +
     					 "          a.profit_amt, " +
     					 "          b.tax_code_name, " +
     					 "          c.account_name, " +
     					 "          F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) spec_name,  " + 
						 "          a.wbs_code, " +
						 "          to_char(a.prepay_date1,'YYYY.MM.DD') prepay_date1," + 
						 "          to_char(a.prepay_date2,'YYYY.MM.DD') prepay_date2," + 
						 "          a.prepay_acntcode," + 
						 "          d.account_name prepay_account_name, " +
                         "          nvl(a.fa_qnty,0) fa_qnty, " +
						 "          mdfy_yn, " +
						 "          decode(a.invoice_num ,null,null,f_slip_no(a.invoice_num)) t_slip_no," +
				         "          decode(a.invoice_num,null,'0',f_slip_status(a.invoice_num)) t_slip_chk " +
     					 "     FROM f_request a,  " +
     					 "          efin_tax_codes_v b, " +
     					 "          efin_accounts_v c, " +
						 "          efin_accounts_v d " +
     					 "    WHERE a.vatcode = b.tax_id (+) " +
     					 "      AND a.acntcode = c.account_code(+) " +
      					 "      AND a.prepay_acntcode = d.account_code(+) " +
     					 "      AND a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      And to_char(a.RQST_DATE,'YYYYMMDD') >= '" + arg_form_dt + "'" +
     					 "      And to_char(a.RQST_DATE,'YYYYMMDD') <= '" + arg_to_dt + "'" +
						 "      And a.SPEC_NO_YN = 'N' ";
	if (!arg_wbs_code.equals("")) {
		query = query + " And wbs_code = '" + arg_wbs_code + "' ";
	}
	query = query + " ORDER BY a.rqst_date desc,a.slip_seq desc,a.seq asc       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>