<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_cont_date = req.getParameter("arg_cont_date");
 String arg_cont_seq = req.getParameter("arg_cont_seq");req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cont_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rent_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rent_supply",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rent_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("pay_tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select d.dept_code," + 
     "       d.sell_code," + 
     "		 to_char(d.cont_date,'yyyy.mm.dd') cont_date," + 
     "		 d.cont_seq," + 
     "		 d.degree_code," + 
     "		 to_char(d.agree_date,'yyyy.mm.dd') agree_date," + 
     "		 to_char(d.s_date,'yyyy.mm.dd') s_date," + 
     "		 to_char(d.e_date,'yyyy.mm.dd') e_date," + 
     "		 d.days," + 
     "		 d.rent_amt," + 
     "		 d.vat_yn," + 
     "		 d.rent_supply," + 
     "		 d.rent_vat," + 
     "		 d.f_pay_yn," + 
     "		 d.pay_tot_amt" + 
     "  from h_lease_rent_agree d" + 
    " where d.dept_code = '"+arg_dept_code+"'" + 
     "   and d.sell_code = '"+arg_sell_code+"'" + 
     "	and d.cont_date = '"+arg_cont_date+"'" + 
     "	and d.cont_seq  = '"+arg_cont_seq+"'" +
	  "   order by degree_code" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>