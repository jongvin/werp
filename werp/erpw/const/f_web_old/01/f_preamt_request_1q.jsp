<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_from_date = req.getParameter("arg_from_date");
     String arg_to_date = req.getParameter("arg_to_date");
	 String arg_wbs_code = req.getParameter("arg_wbs_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_request_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cont",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("cash_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bill_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("t_slip_no",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("t_slip_chk",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("f_close",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("as_long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.request_date,'yyyy.mm.dd') request_date," + 
     					 "          to_char(a.request_date,'yyyy.mm.dd') key_request_date," + 
     					 "          a.seq ," + 
     					 "          a.seq key_seq," + 
     					 "          a.class ," + 
     					 "          a.cont ," + 
     					 "          a.acntcode ," + 
     					 "          a.cash_amt ," + 
     					 "          a.bill_amt ," + 
     					 "          a.remark, " +       
     					 "          a.invoice_num, " +
     					 "          b.account_name, " +
     					 "          a.wbs_code, " +
				       "          decode(a.invoice_num ,null,null,f_slip_no(a.invoice_num)) t_slip_no," +
				       "          decode(a.invoice_num,null,'0',f_slip_status(a.invoice_num)) t_slip_chk, " +
				       "          nvl(d.f_close,'N') f_close, " +
					   "          nvl(e.LONG_NAME,' ') as_long_name " +
     					 "     FROM f_preamt_request  a ," +
     					 "          efin_accounts_v  b, " +
     					 "          c_spec_const_closing d, " +
						 "          z_code_dept e " +
     					 "    WHERE a.acntcode = b.account_code(+) " +
     					 "      AND a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      and a.dept_code = d.dept_code (+) " + 
						 "      AND a.wbs_code = e.dept_code(+) " +
     					 "      and trunc(a.request_date,'MM') = d.yymm (+) " + 
     					 "      AND to_char(a.request_date,'YYYYMMDD') >= '" + arg_from_date + "'" +
     					 "      AND to_char(a.request_date,'YYYYMMDD') <= '" + arg_to_date + "'";

	if (!arg_wbs_code.equals("")) {
		query = query + " And a.wbs_code = '" + arg_wbs_code + "' ";
	}

        query = query +  " ORDER BY a.request_date          DESC," + 
     					 "          a.seq          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>