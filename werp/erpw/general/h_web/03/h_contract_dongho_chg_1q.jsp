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
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("contract_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("last_contract_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("chg_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("b_pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("b_style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("b_class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("b_option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("b_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("a_option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("b_option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("a_class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("b_class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("temp_chk",GauceDataColumn.TB_STRING,1));
    String query = "	SELECT a.DEPT_CODE,   " + 
     "			  		       a.SELL_CODE,   " + 
     "			  		       a.DONGHO,   " + 
     "			  		       a.SEQ,   " + 
     "			  		       a.PYONG,   " + 
     "			  		       a.STYLE,   " + 
     "			  		       a.CLASS,   " + 
     "			  		       a.OPTION_CODE,   " + 
     "			  		       a.CUST_CODE,   " + 
     "			  		       a.CONTRACT_YN,   " + 
     "			  		       to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
     "			  		       a.CHG_DIV,   " + 
     "			  		       to_char(a.CHG_DATE,'YYYY.MM.DD') chg_date,   " + 
     "			  		       to_char(a.LAST_CONTRACT_DATE,'YYYY.MM.DD') last_contract_date,   " + 
     "			  		       a.CHG_DONGHO,   " + 
     "			  		       a.CHG_SEQ,   " + 
     "			  		       b.cust_code b_cust_code, " + 
     "			  		       b.pyong b_pyong, " + 
     "			  		       b.style b_style, " + 
     "			  		       b.class b_class, " + 
     "			  		       b.option_code b_option_code, " + 
     "			  		       b.seq b_seq," + 
     "			  		       c.CUST_NAME, " + 
     "			  		       c.cust_div, " + 
     "			  		       c.cur_addr1," + 
     "			  		       c.cur_addr2,  " + 
     "			  		       d.option_name a_option_name,  " + 
     "			  		       e.option_name b_option_name," + 
     "			   		    f.class_name  a_class_name," + 
     "			  		       g.class_name  b_class_name, " + 
     "                      'N'      temp_chk " +
     "			  	     FROM H_SALE_MASTER a,   " + 
     "			  		       H_SALE_MASTER b,   " + 
     "			  		       H_CODE_CUST c,   " + 
     "			  		       H_CODE_OPTION d,  " + 
     "			  		       H_CODE_OPTION e,  " + 
     "			  		       h_code_class f," + 
     "			  		       h_code_class g " + 
     "  	             WHERE a.dept_code   = f.dept_code" + 
     "  	               and a.sell_code   = f.sell_code" + 
     "  	               and a.class       = f.class" + 
     "  	               and b.dept_code   = g.dept_code" + 
     "  	               and b.sell_code   = g.sell_code" + 
     "  	               and b.class       = g.class" + 
     "  	               and a.dept_code   = d.dept_code" + 
     "  	               and a.sell_code   = d.sell_code" + 
     "  	               and a.option_code = d.option_code" + 
     "  	               and b.dept_code   = e.dept_code" + 
     "  	               and b.sell_code   = e.sell_code" + 
     "  	               and b.option_code = e.option_code" + 
     "  	               and b.CUST_CODE   = c.CUST_CODE" + 
     "  	               and a.DEPT_CODE   = b.DEPT_CODE" + 
     "  	               and a.SELL_CODE   = b.SELL_CODE" + 
     "  	               and a.CHG_DONGHO  = b.DONGHO  " + 
     "  	               and a.CHG_SEQ     = b.SEQ" + 
     "  	               and a.DEPT_CODE   = " + "'" + arg_dept_code + "'" + 
     "  	               and a.SELL_CODE   = " + "'" + arg_sell_code + "'" + 
     "  	               and a.CHG_DIV     = '04' " + 
     "             ORDER BY a.dongho asc, a.seq asc       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>