<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,17));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("degree_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
    String query = "select a.pyong, " + 
     "            substr(a.dongho, 1,4)||'-'||substr(a.dongho, 5,4) dongho, " + 
     "     		 a.style, " + 
     "     		 c.class_name, " + 
     "     		 d.option_name, " + 
     "     		 e.cust_name, " + 
     "     		 e.cust_code, " + 
     "     		 contract_code.code_name, " + 
     "     		 to_char(contract_date, 'yyyy.mm.dd') contract_date, " + 
     "     		 f.degree_code, " + 
     "     		 degree_code.code_name degree_name, " + 
     "     		 to_char(f.agree_date, 'yyyy.mm.dd') agree_date, " + 
     "     		 f.sell_amt, " + 
     "     		 f.tot_amt, " + 
     "     		 f.f_pay_yn " + 
     "       FROM H_SALE_MASTER a,   " + 
     "            (select max(dongho) dongho,max(seq) seq  " + 
     "       	       from h_sale_master  " + 
     "              where dept_code =   " + "'" + arg_dept_code + "'" + 
     "      	        and sell_code =   " + "'" + arg_sell_code + "'" +
     "             group by dept_code,sell_code,dongho ) b,  " + 
     "            h_code_class c,  " + 
     "            h_code_option d,  " + 
     "            h_code_cust e, " + 
     "     		 h_sale_agree f, " + 
     "     		 (select code ,  " + 
     "     		         code_name    " + 
     "     			 from h_code_common   " + 
     "     			where code_div = '04' ) contract_code, " + 
     "     		 (select code ,  " + 
     "     		         code_name    " + 
     "     			 from h_code_common   " + 
     "     			where code_div = '02' ) degree_code   " + 
     "      WHERE a.dept_code   = c.dept_code (+)  " + 
     "        and a.sell_code   = c.sell_code (+)  " + 
     "        and a.class       = c.class (+)  " + 
     "        and a.dept_code   = d.dept_code (+)  " + 
     "        and a.sell_code   = d.sell_code (+)  " + 
     "        and a.option_code = d.option_code (+)  " + 
     "        and a.cust_code   = e.cust_code (+)  " + 
     "     	and a.contract_yn = 'Y' " + 
     "        and a.dongho = b.dongho  " + 
     "        and a.seq = b.seq " + 
     "     	and a.contract_code = contract_code.code(+)   " + 
     "        and a.DEPT_CODE =   " + "'" + arg_dept_code + "'" + 
     "        and a.SELL_CODE =  " + "'" + arg_sell_code + "'" +
     "     	and a.dept_code = f.dept_code " + 
     "     	and a.sell_code = f.sell_code " + 
     "     	and a.dongho = f.dongho " + 
     "     	and a.seq = f.seq " + 
     "     	and f.degree_code = degree_code.code " + 
     "     order by a.dongho, f.degree_code     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>