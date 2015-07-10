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
     dSet.addDataColumn(new GauceDataColumn("dong",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("ho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("temp_cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_id",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("contract_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ontime_tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fund_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("loan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("chg_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("transfer_reason",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("moveinto_plan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("moveinto_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("moveinto_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("passwd",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("lease_supply",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("lease_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lease_s_date",GauceDataColumn.TB_STRING,20)); 
	 dSet.addDataColumn(new GauceDataColumn("lease_e_date",GauceDataColumn.TB_STRING,20)); 
	 dSet.addDataColumn(new GauceDataColumn("lease_real_name",GauceDataColumn.TB_STRING,20)); 
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("contract_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("contract_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("contract_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("home_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("office_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "              		     substr(a.dongho,1,4) dong," + 
     "              		     substr(a.dongho,5,4) ho," + 
     "                       a.SEQ,   " + 
     "                       a.PYONG,   " + 
     "                       a.STYLE,   " + 
     "                       a.CLASS,   " + 
     "                       a.OPTION_CODE,   " + 
     "                       a.CUST_CODE,   " + 
     "                       decode(e.cust_div,'01',substrb(a.CUST_CODE,1,6) || '-' || substrb(a.cust_code,7,7),substrb(a.cust_code,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,6,5)) temp_cust_code,   " + 
     "                       a.UNION_CODE,   " + 
     "                       a.UNION_ID,   " + 
     "                       a.CONTRACT_CODE,   " + 
     "                       a.CONTRACT_YN,   " + 
     "                       to_char(a.CONTRACT_DATE,'YYYY.MM.DD') contract_date,   " + 
     "                       a.CHG_DIV,   " + 
     "                       to_char(a.CHG_DATE,'YYYY.MM.DD') chg_date,   " + 
     "                       to_char(a.LAST_CONTRACT_DATE,'YYYY.MM.DD') last_contract_date,   " + 
     "                       a.ONTIME_TOT_AMT,   " + 
     "                       a.FUND_AMT,   " + 
     "                       a.LOAN_AMT,   " + 
     "                       a.GUARANTEE_AMT,   " + 
     "                       a.CHG_DONGHO,   " + 
     "                       a.CHG_SEQ,   " + 
     "                       a.TRANSFER_REASON,   " + 
     "                       to_char(a.MOVEINTO_PLAN_DATE,'YYYY.MM.DD') moveinto_plan_date,   " + 
     "                       a.MOVEINTO_CODE,   " + 
     "                       to_char(a.MOVEINTO_DATE,'YYYY.MM.DD') moveinto_date,   " + 
     "                       a.PASSWD,   " + 
     "                       to_char(a.INPUT_DATE,'yyyy.mm.dd hh24:mi:ss') input_date,   " + 
     "                       a.INPUT_ID,   " + 
     "                       a.REMARK,  " +
	 "                       a.lease_supply, "+
	 "                       a.lease_vat, "+
	 "                       to_char(a.lease_s_date,'YYYY.MM.DD') lease_s_date, "+
	 "                       to_char(a.lease_e_date,'YYYY.MM.DD') lease_e_date, "+
	 "                       a.lease_real_name, "+
     "                       c.class_name, " +
     "                       d.option_name, " +
     "                       e.cust_name, " +
     "                       e.cust_div ," +
     "                       e.cur_zip_code contract_zip_code, " +
     "                       e.cur_addr1 contract_addr1," +
     "                       e.cur_addr2 contract_addr2, " +
     "                       e.home_phone, " +
     "                       e.office_phone, " +
     "                       e.cell_phone " +
     "                  FROM H_SALE_MASTER a," + 
     "              		    (select max(dongho) dongho,max(seq) seq" + 
     "              			  	 from h_sale_master" + 
     "               		   where dept_code = " + "'" + arg_dept_code + "'" + 
     "              			 	  and sell_code = " + "'" + arg_sell_code + "'" + 
	 "                                and dongho like " + "'%" + arg_dongho + "'" + 
	 "                                and seq like " + "'%" + arg_seq + "'" + 
     "              		   group by dept_code,sell_code,dongho ) b," + 
     "                       h_code_class c, " +
     "                       h_code_option d, " +
     "                       h_code_cust e " +
     "                 WHERE  a.dept_code   = c.dept_code (+) " +
     "                   and a.sell_code   = c.sell_code (+) " +
     "                   and a.class       = c.class (+) " +
     "                   and a.dept_code   = d.dept_code (+) " +
     "                   and a.sell_code   = d.sell_code (+) " +
     "                   and a.option_code = d.option_code (+) " +
     "                   and a.cust_code   = e.cust_code (+) " +
     "                   and a.dongho = b.dongho" + 
     "              	    and a.seq = b.seq " + 
     "                   and a.CONTRACT_YN = 'Y' " +
	 "                    and (a.CONTRACT_CODE = '02' or  (a.CONTRACT_CODE = '01' and a.lease_to_sale_tag = 'Y'))"+
     "              	    and a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                   and a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
	 "                                and a.dongho like " + "'%" + arg_dongho + "'" + 
	 "                                and a.seq like " + "'%" + arg_seq + "'" + 
     "              ORDER BY a.DONGHO ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>