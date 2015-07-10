<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("contract_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("last_contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("refund_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("refund_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chk_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("temp_chk",GauceDataColumn.TB_STRING,1));
    String query = "	SELECT a.DEPT_CODE,   " + 
     "            			 a.SELL_CODE,   " + 
     "            			 a.DONGHO,   " + 
     "            			 a.SEQ,   " + 
     "            			 a.CUST_CODE,   " + 
     "            			 a.CONTRACT_YN,   " + 
     "            			 a.CONTRACT_CODE,   " + 
     "            			 to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
     "            			 a.CHG_DIV,   " + 
     "            			 to_char(a.CHG_DATE,'YYYY.MM.DD') chg_date,   " + 
     "            			 to_char(a.LAST_CONTRACT_DATE,'YYYY.MM.DD') last_contract_date,   " + 
     "            			 b.CUST_NAME, " + 
     "            			 b.cust_div, " + 
     "                      to_char(c.refund_date,'YYYY.MM.DD') refund_date," + 
     "            			 nvl(c.refund_amt,0) refund_amt," + 
     "            			 decode(nvl(c.refund_amt,0),0,'N',decode(c.refund_date,'','N','Y')) chk_yn," + 
     "                      'N'  temp_chk " + 
     "            	  FROM H_SALE_MASTER a,   " + 
     "            			 H_CODE_CUST b,   " + 
     "            			 h_sale_annul c  " + 
     "            	 WHERE a.dept_code   = c.dept_code (+)" + 
     "            		and a.sell_code   = c.sell_code (+)" + 
     "            		and a.dongho      = c.dongho (+)" + 
	  "                  AND a.seq         = c.seq (+)"+
     "            		and a.CUST_CODE   = b.CUST_CODE (+)" + 
     "            		and a.DEPT_CODE   = " + "'" + arg_dept_code + "'" + 
     "            		and a.SELL_CODE   = " + "'" + arg_sell_code + "'" + 
     "            		and a.CHG_DIV     = '03' " + 
     "             ORDER BY a.dongho asc, a.seq asc       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>