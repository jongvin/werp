<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,17));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("home_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("office_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("e_mail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("contract_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("contract_addr1",GauceDataColumn.TB_STRING,100));
    String query = "select a.pyong," + 
     "       substr(a.dongho, 1,4)||'-'||substr(a.dongho, 5,4) dongho," + 
     "		 a.style," + 
     "		 c.class_name," + 
     "		 d.option_name," + 
     "		 e.cust_name," + 
     "		 e.cust_code," + 
     "		 contract_code.code_name," + 
     "		 contract_date," + 
     "		 e.home_phone," + 
     "		 e.office_phone," + 
     "		 e.cell_phone," + 
     "		 e.e_mail," + 
     "		 e.contract_zip_code," + 
     "		 e.contract_addr1" + 
     "  FROM H_SALE_MASTER a,  " + 
     "       (select max(dongho) dongho,max(seq) seq " + 
     "  	       from h_sale_master " + 
     "         where dept_code =  " + "'" + arg_dept_code + "'" + 
     " 	        and sell_code =  " + "'" + arg_sell_code + "'" + 
     "        group by dept_code,sell_code,dongho ) b, " + 
     "       h_code_class c, " + 
     "       h_code_option d, " + 
     "       h_code_cust e," + 
     "		 (select code , " + 
     "		         code_name   " + 
     "			 from h_code_common  " + 
     "			where code_div = '04' ) contract_code " + 
     " WHERE a.dept_code   = c.dept_code (+) " + 
     "   and a.sell_code   = c.sell_code (+) " + 
     "   and a.class       = c.class (+) " + 
     "   and a.dept_code   = d.dept_code (+) " + 
     "   and a.sell_code   = d.sell_code (+) " + 
     "   and a.option_code = d.option_code (+) " + 
     "   and a.cust_code   = e.cust_code (+) " + 
     "   and a.dongho = b.dongho " + 
     "   and a.seq = b.seq" + 
     "	and a.contract_code = contract_code.code(+)  " + 
     "   and a.DEPT_CODE =  " + "'" + arg_dept_code + "'" + 
     "   and a.SELL_CODE =  " + "'" +arg_sell_code    + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>