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
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("raise_rate",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chk",GauceDataColumn.TB_STRING,0));
    String query = "select h_sale_master.pyong  ,    " + 
     "            h_sale_master.style ,    " + 
     "            h_sale_master.class ,     " + 
     "            h_sale_master.option_code ,    " + 
     "     	    c.class_name,  " + 
     "            d.option_name,  " + 
     "       		 guarantee.AMT guarantee_amt,    " + 
     "       		 count(distinct(h_sale_master.dongho)) cnt,    " + 
     "       		 guarantee.AMT chg_amt,    " + 
     "       		 0 raise_rate,    " + 
     "       		 '' chk    " + 
     "       from h_sale_master,    " + 
     "            h_code_class c,  " + 
     "            h_code_option d, " + 
     "	               		    (select max(dongho) dongho,max(seq) seq " + 
     "                   			  	 from h_sale_master " + 
     "                    		   where dept_code =   " + "'" + arg_dept_code + "'" + 
     "                   			 	  and sell_code =   " + "'" + arg_sell_code + "'" + 
     "                   		   group by dept_code,sell_code,dongho ) sale, " + 
     "     		 (select dongho, " + 
     "     			      seq, " + 
     "     					sum(nvl(sell_amt,0)) amt " + 
     "     			 from h_sale_agree " + 
     "     			where dept_code =  " + "'" + arg_dept_code + "'" + 
     "                and sell_code =  " + "'" + arg_sell_code + "'" + 
     "     		   group by dongho, " + 
     "     			       seq) guarantee " + 
     "     					   " + 
     "     		      " + 
     "      where h_sale_master.dept_code   = c.dept_code (+) "+ 
	 "        and h_sale_master.sell_code   = c.sell_code (+)  " + 
     "        and h_sale_master.class       = c.class (+)  " + 
     "        and h_sale_master.dept_code   = d.dept_code (+)  " + 
     "        and h_sale_master.sell_code   = d.sell_code (+)  " + 
     "        and h_sale_master.option_code = d.option_code (+)  " + 
     "        and h_sale_master.dept_code =  " + "'" + arg_dept_code + "'" + 
     "        and h_sale_master.sell_code =  " + "'" + arg_sell_code + "'" + 
     "       and h_sale_master.dongho = sale.dongho    " + 
     "        and h_sale_master.seq = sale.seq    " + 
     "        and h_sale_master.dongho = guarantee.dongho(+)    " + 
     "        and h_sale_master.seq    = guarantee.seq(+)    " + 
     "       and h_sale_master.contract_code = '02'" +
	 "       AND H_SALE_MASTER.CONTRACT_YN ='Y' "+
     "      group by  h_sale_master.pyong  ,    " + 
     "            h_sale_master.style ,    " + 
     "       		 h_sale_master.class ,     " + 
     "       		 h_sale_master.option_code ,    " + 
     "            c.class_name,  " + 
     "            d.option_name, " + 
     "     		 guarantee.AMT     " + 
     "     order by h_sale_master.pyong  ,    " + 
     "            h_sale_master.style ,    " + 
     "       		 h_sale_master.class ,     " + 
     "       		 h_sale_master.option_code           ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>