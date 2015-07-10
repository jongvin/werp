<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
	  String arg_style = req.getParameter("arg_style");
	   String arg_class = req.getParameter("arg_class");
	    String arg_option_code = req.getParameter("arg_option_code");
		String arg_guarantee_amt = req.getParameter("arg_guarantee_amt");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("contract_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("chk_cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("contract_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("leas_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING,1));
    String query = "SELECT a.DEPT_CODE,    " + 
     "                            a.SELL_CODE,    " + 
     "                            a.DONGHO,    " + 
     "                            a.SEQ,    " + 
     "                            a.pyong," + 
     "                            a.CONTRACT_YN,    " + 
     "                            to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date,    " + 
     "                            a.CONTRACT_CODE,    " + 
     "                            a.cust_code chk_cust_code," + 
     "                            decode(b.cust_div,'01',substrb(a.CUST_CODE,1,6) || '-' || substrb(a.cust_code,7,7),substrb(a.cust_code,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,7,5)) cust_code,    " + 
     "                            b.CUST_NAME," + 
     "									 leas.contract_date," + 
     "									 leas.contract_div," + 
     "									 leas.guarantee_amt," + 
     "									 leas.leas_amt ,  " +
	 "                                   '' chk " + 
     "                       FROM H_SALE_MASTER a,    " + 
     "                            H_CODE_CUST  b," + 
     "									 (select a.dongho," + 
     "									         a.seq," + 
     "												a.contract_date," + 
     "												a.contract_div," + 
     "												a.guarantee_amt," + 
     "												a.lease_supply+lease_vat leas_amt" + 
     "												" + 
     "									    from h_leas_master a," + 
     "										      ( select dongho, seq," + 
     "												         max(contract_date) contract_date" + 
     "												    from h_leas_master" + 
     "													where dept_code = '" + arg_dept_code + "'" + 
     "													  and sell_code = '" + arg_sell_code + "'" + 
     "												  group by dongho, seq" + 
     "												 ) max" + 
     "										where a.dept_code = '" + arg_dept_code + "'" +  
     "										  and a.sell_code = '" + arg_sell_code + "'" + 
     "										  and contract_div <> '05'" + 
     "										  and a.dongho = max.dongho" + 
     "										  and a.seq    = max.seq" + 
     "										  and a.contract_date = max.contract_date" + 
     "									 ) leas		 " + 
     "                      WHERE a.dongho = leas.dongho" + 
     "							   and a.seq    = leas.seq" + 
     "							   and a.CUST_CODE = b.CUST_CODE (+) " + 
     "                        AND a.DEPT_CODE = '" + arg_dept_code + "'" +  
     "                        AND a.SELL_CODE = '" + arg_sell_code + "'" + 
	 "						  and a.style = '" + arg_style + "'" + 
	 "						  and a.class = '" + arg_class + "'" + 
	 "						  and a.option_code = '" + arg_option_code + "'" + 
	 "                        and leas.guarantee_amt = '" + arg_guarantee_amt + "'" +
     "	                     " + 
     "                        AND a.SEQ = 2  " + 
     "                        AND a.CONTRACT_CODE = '02'    " + 
     "                   	  AND a.contract_yn = 'Y'  " + 
     "                   ORDER BY a.DONGHO ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>