<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code"); 
 String arg_sell_code = req.getParameter("arg_sell_code"); 
 String arg_fr_date  = req.getParameter("arg_fr_date");
 String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("folder_code",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("biz_status",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("biz_type",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("cur_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT a.dongho," + 
     "             a.seq," + 
     "		       a.contract_code," + 
     "		       b.degree_code," + 
	  "		       b.degree_seq," +
     "             to_char(b.receipt_date, 'yyyy.mm.dd') receipt_date ," + 
     "             bank.folder_code,  " + 
     "             a.cust_code," + 
     "		       c.cust_name," + 
     "             c.cust_div," + 
     "             c.biz_status," + 
     "             c.biz_type," + 
     "             c.CUR_ZIP_CODE," + 
     "             c.CUR_ADDR1," + 
     "             c.CUR_ADDR2," + 
     "		       d.code_name," +
	  "             b.work_no, "+
     "             SUM(b.r_amt)     r_amt," + 
     "		       SUM(b.delay_amt)     delay_amt," + 
     "		       SUM(b.discount_amt)  discount_amt," + 
     "		       SUM(b.r_amt + b.delay_amt - b.discount_amt)  sell_amt" + 
     "		  FROM H_SALE_MASTER a," + 
     "		       H_SALE_INCOME  b," + 
     "		       H_CODE_CUST   c," + 
     "             H_CODE_COMMON d," + 
     "             (SELECT bank_account_number, folder_code " + 
     "                FROM efin_internal_bank_account_v ) bank" + 
     "		 WHERE (LENGTH(trim(b.work_no)) IS NULL OR            " + 
     "              b.work_no IN (SELECT invoice_group_id FROM v_invoice_reject )  " + 
     "             )" + 
     "         AND a.dept_code = b.dept_code" + 
     "		   AND a.sell_code = b.sell_code" + 
     "		   AND a.dongho    = b.dongho" + 
     "		   AND a.seq       = b.seq" + 
     "		   AND a.cust_code = c.cust_code (+)" + 
     "         AND b.degree_code = d.code (+)" + 
     "         AND d.code_div    = '02'" + 
     "		   AND a.dept_code = '"+arg_dept_code+"'" + 
     "		   AND a.sell_code = '"+arg_sell_code+"'" + 
     "		   AND b.receipt_date  BETWEEN '"+arg_fr_date+"' AND '"+arg_to_date+"'" + 
     "		   AND a.last_contract_date <= '"+arg_to_date+"'" + 
     "		   AND a.chg_date    > '"+arg_to_date+"'" + 
     "		   AND a.chg_div     <> '00'" + 
     "         AND b.degree_seq  < '99'" +
     "         AND REPLACE(b.deposit_no,'-','') = bank_account_number" + 
     "         AND b.receipt_code  IN ('11','12','15','18','19','1A','25','99') " + 
     "                                 " + 
     "		 GROUP BY a.dongho," + 
     "             a.seq," + 
     "		       a.contract_code," + 
     "		       b.receipt_date," + 
     "             bank.folder_code," + 
     "             b.degree_code," + 
	  "		       b.degree_seq," +
     "		       a.cust_code," + 
     "		       c.cust_name," + 
     "             c.cust_div," + 
     "             c.biz_status," + 
     "             c.biz_type," + 
     "             c.CUR_ZIP_CODE," + 
     "             c.CUR_ADDR1," + 
     "             c.CUR_ADDR2," + 
     "		       d.code_name," + 
	  "             b.work_no "+
     "		 HAVING  SUM(b.delay_amt) <> 0 OR SUM(b.discount_amt) <> 0 or" + 
     "		                  SUM(CASE WHEN b.degree_seq >= 70 AND b.r_amt > 0 THEN b.r_amt ELSE 0 END ) <> 0 OR	 "+
     "                        SUM(CASE WHEN b.degree_seq <  70 THEN b.r_amt ELSE 0 END) <> 0" + 
     "   ORDER BY  a.dongho," + 
     "             a.seq," + 
     "		       a.contract_code," + 
     "		       b.degree_code," + 
     "             b.receipt_date     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>