<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
    
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_workym= req.getParameter("arg_workym");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cont_num",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
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
    String query = "select m.cont_num, " + 
     "       c.cust_name," + 
     "		 d.dept_code," + 
     "		 d.sell_code," + 
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
     "  from h_lease_master m," + 
     "       h_lease_rent_agree d," + 
     "		 h_code_cust c" + 
     " where m.dept_code = d.dept_code" + 
     "   and m.sell_code = d.sell_code" + 
     "	and m.cont_date = d.cont_date" + 
     "	and m.cont_seq  = d.cont_seq" + 
     "	and m.cust_code = c.cust_code" + 
     "	and m.dept_code = '"+arg_dept_code+"'" + 
     "	and m.sell_code = '"+arg_sell_code+"'" + 
     "	and to_char(d.s_date,'yyyy.mm')    = '"+arg_workym+"'"  ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>