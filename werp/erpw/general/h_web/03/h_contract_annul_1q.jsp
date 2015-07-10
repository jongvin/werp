<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("tot_sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_build_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "	SELECT a.DEPT_CODE,   " + 
     "            			 a.SELL_CODE,   " + 
     "            			 a.DONGHO,   " + 
     "            			 a.SEQ,   " + 
     "            			 a.PYONG,   " + 
     "            			 a.STYLE,   " + 
     "            			 a.CLASS,   " + 
     "            			 a.OPTION_CODE,   " + 
     "            			 a.cust_code," + 
     "            			 to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
     "            			 to_char(a.CHG_DATE,'YYYY.MM.DD') chg_date,   " + 
     "            			 b.CUST_NAME, " + 
     "            			 b.cust_div, " + 
     "            			 c.option_name ,  " + 
     "             			 d.class_name," + 
     "            			 nvl(e.sell_amt,0) sell_amt," + 
	  "                       nvl(z.tot_sell_amt,0) tot_sell_amt,   " + 
     "            			 nvl(f.r_amt,0)   r_amt," + 
     "            			 nvl(f.r_land_amt,0)  r_land_amt," + 
     "            			 nvl(f.r_build_amt,0)  r_build_amt," + 
     "            			 nvl(f.r_vat_amt,0)  r_vat_amt," + 
     "            			 nvl(f.delay_amt,0) delay_amt," + 
     "            			 nvl(f.discount_amt,0) discount_amt," + 
     "            			 nvl(f.r_amt,0) + nvl(f.delay_amt,0) - nvl(f.discount_amt,0)  real_amt" + 
     "            	  FROM H_SALE_MASTER a,   " + 
     "            			 H_CODE_CUST b,   " + 
     "            			 H_CODE_OPTION c,  " + 
     "            			 h_code_class d," +
	  "                       ( select nvl(sum(sell_amt),0) tot_sell_amt " +
     "                           from h_sale_agree " +
     "                          where dept_code = '" + arg_dept_code + "' and sell_code = '" + arg_sell_code + "'" +
     "                            and dongho = '" + arg_dongho + "' and seq = '" + arg_seq + "' ) z, " +
     "            			 ( select max(dept_code) dept_code," + 
     "            						 max(sell_code) sell_code," + 
     "            						 max(dongho) dongho," + 
     "            						 max(seq) seq," + 
     "            						 sum(nvl(sell_amt,0)) sell_amt" + 
	  "            				  from h_sale_agree" + 
     "            				 where degree_code <> '99'" + 
	  "            		and DEPT_CODE   = " + "'" + arg_dept_code + "'" + 
     "            		and SELL_CODE   = " + "'" + arg_sell_code + "'" + 
     "            		and dongho      = " + "'" + arg_dongho + "'" + 
     "            		and seq         = " + "'" + arg_seq + "'" + 
     "            		    group by dept_code,sell_code,dongho,seq ) e," + 
     "            			 ( select max(dept_code) dept_code," + 
     "            						 max(sell_code) sell_code," + 
     "            						 max(dongho) dongho," + 
     "            						 max(seq) seq," + 
     "            						 sum(nvl(r_amt,0)) r_amt," + 
     "            						 sum(nvl(r_land_amt,0)) r_land_amt," + 
     "            						 sum(nvl(r_build_amt,0)) r_build_amt," + 
     "            						 sum(nvl(r_vat_amt,0)) r_vat_amt," + 
     "            						 sum(nvl(delay_amt,0)) delay_amt," + 
     "            						 sum(nvl(discount_amt,0)) discount_amt" + 
     "            				  from h_sale_income" + 
     "            				 where degree_code <> '99'" + 
	  "            		and DEPT_CODE   = " + "'" + arg_dept_code + "'" + 
     "            		and SELL_CODE   = " + "'" + arg_sell_code + "'" + 
     "            		and dongho      = " + "'" + arg_dongho + "'" + 
     "            		and seq         = " + "'" + arg_seq + "'" + 
     "            		    group by dept_code,sell_code,dongho,seq ) f" + 
     "            	 WHERE a.dept_code   = f.dept_code (+)" + 
     "            		and a.sell_code   = f.sell_code (+)" + 
     "            		and a.dongho      = f.dongho (+)" + 
     "            		and a.seq         = f.seq (+)" + 
     "            		and a.dept_code   = e.dept_code (+)" + 
     "            		and a.sell_code   = e.sell_code (+)" + 
     "            		and a.dongho      = e.dongho (+)" + 
     "            		and a.seq         = e.seq (+)" + 
     "            		and a.dept_code   = d.dept_code" + 
     "            		and a.sell_code   = d.sell_code" + 
     "            		and a.class       = d.class" + 
     "            		and a.dept_code   = c.dept_code" + 
     "            	   and a.sell_code   = c.sell_code" + 
     "            		and a.option_code = c.option_code" + 
     "            		and a.CUST_CODE   = b.CUST_CODE" + 
     "            		and a.DEPT_CODE   = " + "'" + arg_dept_code + "'" + 
     "            		and a.SELL_CODE   = " + "'" + arg_sell_code + "'" + 
     "            		and a.dongho      = " + "'" + arg_dongho + "'" + 
     "            		and a.seq         = " + "'" + arg_seq + "'" + 
     "     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>