<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_from = req.getParameter("arg_from");
 String arg_to = req.getParameter("arg_to");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cont_num",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("rent_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pay_tot_amt",GauceDataColumn.TB_DECIMAL,18,0));

	  dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select m.cont_num," +
	 "        m.cust_code,"+
	 "         c.cust_name,"+
     "		 to_char(d.cont_date,'yyyy.mm.dd') cont_date," + 
     "		 to_char(d.agree_date,'yyyy.mm.dd') agree_date," + 
     "		 d.degree_code," + 
     "		 to_char(d.agree_date,'yyyy.mm.dd') agree_date," + 
     "		 d.rent_amt," + 
     "		 d.f_pay_yn," + 
     "		 d.pay_tot_amt," + 
     "		 i.degree_seq," + 
     "		 to_char(i.receipt_date,'yyyy.mm.dd') receipt_date ," + 
     "		 i.daily_seq," + 
     "		 i.deposit_no," + 
     "		 i.r_amt," + 
     "		 i.delay_days," + 
     "		 i.delay_amt," + 
     "		 i.discount_days," + 
     "		 i.discount_amt" + 
     
     "  from h_lease_rent_agree d," +
	  "          	h_lease_master m, "+
	  "            h_code_cust c, "+
	   "       h_lease_rent_income i" + 
     " where d.dept_code = i.dept_code(+)" + 
     "   and d.sell_code = i.sell_code(+)" + 
     "	and d.cont_date = i.cont_date(+)" + 
     "	and d.cont_seq  = i.cont_seq(+)" + 
	  "	and d.degree_code  = i.degree_code(+)" +
	  "   and d.dept_code = '"+arg_dept_code+"'" + 
     "   and d.sell_code = '"+arg_sell_code+"'" + 
	  "   and m.dept_code = d.dept_code(+) "+
	  "   and m.dept_code = d.dept_code(+) "+
	  "   and m.cont_date = d.cont_date(+) "+
	  "   and m.cont_seq = d.cont_seq(+) "+
	  "   and m.cust_code = c.cust_code(+) "+
	  "   and m.exp_tag <> 'Y' "+
	   "  and i.receipt_date between " + "'" + arg_from + "'  and '"  + arg_to + "'" +  
 	  " order by d.cont_date, d.cont_seq, d.degree_code, i.degree_seq";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>