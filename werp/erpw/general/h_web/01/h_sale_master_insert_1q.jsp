<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("dong",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("ho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
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
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
	  dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("v_account_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chk_st",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "                       a.SELL_CODE,   " + 
     "                       a.DONGHO,   " + 
     "            		     substr(a.dongho,1,4) dong," + 
     "             		     substr(a.dongho,5,4) ho," + 
     "                       a.SEQ,   " + 
     "                       a.PYONG,   " + 
     "                       a.STYLE,   " + 
     "                       a.CLASS,   " + 
     "                       a.OPTION_CODE,   " + 
     "                       a.CUST_CODE,   " + 
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
     "                       to_char(a.INPUT_DATE,'YYYY.MM.DD') input_date,   " + 
     "                       a.INPUT_ID,   " + 
     "                       a.REMARK , " + 
	  "                       a.deposit_no, " + 
	  "                       a.v_account_no, " + 
     "                       'N'  chk_st, " +
     "                       c.sell_amt " +
     "                  FROM H_SALE_MASTER a, " +
	 "                          (select t.dept_code, t.sell_code, t.dongho, t.seq, sum(t.sell_amt) as sell_amt " +
	 "                             from H_SALE_AGREE t where  " +
     "               		                    t.dept_code = " + "'" + arg_dept_code + "'" + 
     "              			             and t.sell_code = " + "'" + arg_sell_code + "'" + 
     "                              Group by t.dept_code, t.sell_code, t.dongho, t.seq) c, " +  
     "              		    (select max(dongho) dongho,max(seq) seq" + 
     "              			  	 from h_sale_master" + 
     "               		   where dept_code = " + "'" + arg_dept_code + "'" + 
     "              			 	  and sell_code = " + "'" + arg_sell_code + "'" + 
     "              		   group by dept_code,sell_code,dongho ) b" + 
     "                 WHERE    a.DEPT_CODE = " + "'" + arg_dept_code + "'" + 
     "                      and a.SELL_CODE = " + "'" + arg_sell_code + "'" + 
     "                      and a.dongho = b.dongho" + 
     "              	    and a.seq = b.seq " + 
     "                      and a.dongho = c.dongho(+)" + 
     "              	    and a.seq = c.seq(+) " + 
	 "              ORDER BY a.DONGHO ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>