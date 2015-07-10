<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
  String arg_dept_code = req.getParameter("arg_dept_code"); 
   String arg_sell_code = req.getParameter("arg_sell_code"); 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cont_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_num",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cont_type",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("vat_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_supply",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("real_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("lease_chg_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rent_chg_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cont_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cont_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("moveinto_plan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("moveinto_code",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("moveinto_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("passwd",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
	  dSet.addDataColumn(new GauceDataColumn("exp_tag",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("exp_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("extra_1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("extra_2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("extra_3",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("extra_4",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
    String query = "SELECT DEPT_CODE, " + 
     "       SELL_CODE, " + 
     "		 to_char(CONT_DATE,'yyyy.mm.dd') cont_date, " + 
     "   	 CONT_SEQ, " + 
     "		 CONT_NUM, " + 
     "		 CONT_TYPE, " + 
     "   	 CUST_CODE," + 
     "		 (select cust_name " + 
     "		    from h_code_cust" + 
     "			where cust_code = m.cust_code) cust_name,  " + 
     "		 VAT_YN, " + 
     "		 GUARANTEE_AMT, " + 
     "   	 LEASE_SUPPLY, " + 
     "		 LEASE_VAT, " + 
     "		 to_char(S_DATE,'yyyy.mm.dd') s_date, " + 
     "   	 to_char(E_DATE,'yyyy.mm.dd') e_date, " + 
     "		 to_char(MOVEINTO_DATE,'yyyy.mm.dd') MOVEINTO_DATE, " + 
     "		 REAL_NAME, " + 
     "   	 LEASE_CHG_SEQ, " + 
     "		 RENT_CHG_SEQ," + 
     "       cont_zip_code," + 
     "       cont_addr1," + 
     "       cont_addr2," + 
     "       to_char(moveinto_plan_date, 'yyyy.mm.dd') moveinto_plan_date," + 
     "       moveinto_code," + 
     "       passwd," + 
     "	    to_char(input_date, 'yyyy.mm.dd') input_date," + 
     "	    input_id," + 
     "       remark," + 
	  "       exp_tag," +
	  "       to_char(exp_date, 'yyyy.mm.dd') exp_date ," +
     "       extra_1," + 
     "       extra_2," + 
     "       extra_3," + 
     "       extra_4," + 
	  "      (select cust_div from h_code_cust where cust_code = m.cust_code) cust_div "+
     "  FROM H_LEASE_MASTER m" + 
	  "  where dept_code = '"+arg_dept_code+"'"+
     "   and sell_code = '"+arg_sell_code+"'"+
	  "   order by cont_date, cont_seq       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>