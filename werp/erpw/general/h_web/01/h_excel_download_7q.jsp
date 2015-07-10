<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
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
    String query = "select m.cont_num," +
	 "        m.cust_code,"+
	 "         c.cust_name,"+
     "		 to_char(d.cont_date,'yyyy.mm.dd') cont_date," + 
     "		 d.degree_code," + 
     "		 to_char(d.agree_date,'yyyy.mm.dd') agree_date," + 
     "		 d.rent_amt," + 
     "		 d.f_pay_yn," + 
     "		 d.pay_tot_amt" + 
     "  from h_lease_rent_agree d," +
	  "          	h_lease_master m, "+
	  "            h_code_cust c  "+
     " where d.dept_code = '"+arg_dept_code+"'" + 
     "   and d.sell_code = '"+arg_sell_code+"'" + 
	  "   and m.dept_code = d.dept_code "+
	  "   and m.dept_code = d.dept_code "+
	  "   and m.cont_date = d.cont_date "+
	  "   and m.cont_seq = d.cont_seq "+
	  "   and m.cust_code = c.cust_code "+
	  "   and m.exp_tag <> 'Y' "+
 	  " order by d.cont_date, d.cont_seq, d.degree_code";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>