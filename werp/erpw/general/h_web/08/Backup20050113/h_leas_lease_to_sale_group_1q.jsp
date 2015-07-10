<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT a.pyong  ,   " + 
     "            a.style ,   " + 
     "            a.class ,    " + 
     "            a.option_code ,   " + 
     "     	    c.class_name, " + 
     "            d.option_name," + 
     "				leas.guarantee_amt" + 
     "                            FROM H_SALE_MASTER a,    " + 
     "                                 H_CODE_CUST  b," + 
     "											h_code_class c, " + 
     "                                 h_code_option d," + 
     "     									 (select a.dongho," + 
     "     									         a.seq," + 
     "     												a.contract_date," + 
     "     												a.contract_div," + 
     "     												a.guarantee_amt," + 
     "     												a.lease_supply+lease_vat leas_amt" + 
     "     												" + 
     "     									    from h_leas_master a," + 
     "     										      ( select dongho, seq," + 
     "     												         max(contract_date) contract_date" + 
     "     												    from h_leas_master" + 
     "     													where dept_code = " + "'" + arg_dept_code + "'" + 
     "     													  and sell_code = " + "'" + arg_sell_code + "'" + 
     "     												  group by dongho, seq" + 
     "     												 ) max" + 
     "     										where a.dept_code = " + "'" + arg_dept_code + "'" + 
     "     										  and a.sell_code = " + "'" + arg_sell_code + "'" + 
     "     										  and contract_div <> 05" + 
     "     										  and a.dongho = max.dongho" + 
     "     										  and a.seq    = max.seq" + 
     "     										  and a.contract_date = max.contract_date" + 
     "     									 ) leas		 " + 
     "                           WHERE a.sell_code   = c.sell_code (+) " + 
     "        and a.class       = c.class (+) " + 
     "        and a.dept_code   = d.dept_code (+) " + 
     "        and a.sell_code   = d.sell_code (+) " + 
     "        and a.option_code = d.option_code (+) " + 
     "									and a.dongho = leas.dongho" + 
     "     							   and a.seq    = leas.seq" + 
     "     							   and a.CUST_CODE = b.CUST_CODE (+) " + 
     "                             AND a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                             AND a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "     	                     " + 
     "                             AND a.SEQ = 2  " + 
     "                             AND a.CONTRACT_CODE = 02    " + 
     "                        	  AND a.contract_yn = 'Y'" + 
     "								group by a.pyong  ,   " + 
     "            a.style ,   " + 
     "            a.class ,    " + 
     "            a.option_code ,   " + 
     "     	    c.class_name, " + 
     "            d.option_name," + 
     "				leas.guarantee_amt" + 
     "				order by a.pyong, a.style, a.class, a.option_code, leas.guarantee_amt      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>