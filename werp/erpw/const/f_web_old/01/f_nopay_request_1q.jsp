<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_form_dt = req.getParameter("arg_form_dt");
     String arg_to_dt = req.getParameter("arg_to_dt");
	 String arg_wbs_code = req.getParameter("arg_wbs_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("req_spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("vatcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bill_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dis_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("tax_code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("t_slip_no",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("t_slip_chk",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("f_close",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("as_long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.request_date,'YYYY.MM.DD') request_date ," + 
     					 "          to_char(a.request_date,'YYYY.MM.DD') key_request_date ," + 
     					 "          a.req_spec_unq_num ," + 
     					 "          a.cont ," + 
     					 "          a.cust_code ," + 
     					 "          a.cust_name ," + 
     					 "          a.acntcode ," + 
     					 "          a.vatcode ," + 
     					 "          a.amt ," + 
     					 "          a.vat ," + 
     					 "          a.cash_amt ," + 
     					 "          a.bill_amt ," + 
     					 "          to_char(a.receipt_date,'YYYY.MM.DD') receipt_date ," + 
     					 "          a.dis_class ," + 
     					 "          a.remark ," + 
     					 "          a.invoice_num,  " +
     					 "          b.tax_code_name, " +
     					 "          c.account_name ," +
     					 "          a.wbs_code, " +
     					 "          a.spec_no_seq ," + 
     					 "          a.spec_unq_num ," + 
     					 "          F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) spec_name,  " + 
				       "          decode(a.invoice_num ,null,null,f_slip_no(a.invoice_num)) t_slip_no," +
				       "          decode(a.invoice_num,null,'0',f_slip_status(a.invoice_num)) t_slip_chk ," +
				       "          a.res_type, " +
				       "          nvl(d.f_close,'N') f_close, " +
					   "          nvl(e.LONG_NAME,' ') as_long_name " +
     					 "     FROM f_nopay_request a, " +
     					 "          efin_tax_codes_v  b, " +
     					 "          efin_accounts_v  c, " +
     					 "          c_spec_const_closing d, " +
						 "          z_code_dept e " +
     					 "    WHERE a.vatcode = b.tax_id (+) " +
     					 "      AND a.acntcode = c.account_code(+) " +
     					 "      and a.dept_code = d.dept_code (+) " + 
     					 "      and trunc(a.request_date,'MM') = d.yymm (+) " + 
						 "      and a.wbs_code = e.dept_code(+) " +
     					 "      AND a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      And to_char(a.REQUEST_DATE,'YYYYMMDD') >= '" + arg_form_dt + "'" +
     					 "      And to_char(a.REQUEST_DATE,'YYYYMMDD') <= '" + arg_to_dt + "'";
	if (!arg_wbs_code.equals("")) {
	     query = query + " And a.wbs_code = '" + arg_wbs_code + "' ";
	}
        query = query +  " ORDER BY a.request_date          DESC," + 
     					 "          a.req_spec_unq_num          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>