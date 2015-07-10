<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code"); 
 String arg_sell_code = req.getParameter("arg_sell_code"); 
 String arg_fr_date  = req.getParameter("arg_fr_date");
 String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("receipt_seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("deposit_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("folder_code",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,50));

    String query = "SELECT (select print_deposit_no from h_code_deposit where deposit_no = a.deposit_no) deposit_no ,  "+
										"						 to_char(a.receipt_date, 'yyyy.mm.dd') receipt_date ,	"+
										"						 a.receipt_seq,		"+
										"						 a.deposit_name,		"+
										"						 bank.folder_code,		 "+
										"						 a.amt,										  "+
										"						 a.memo 											"+
										"				  FROM H_SALE_INCOME_UNKNOWN a, "+
										"						 (SELECT bank_account_number, folder_code "+
										"							 FROM efin_internal_bank_account_v ) bank			"+
										"				 WHERE a.receipt_date  BETWEEN '"+arg_fr_date+"' AND '"+arg_to_date +"'"+
										"					AND REPLACE(A.deposit_no,'-','') = bank_account_number(+)		 "+
										"					AND (LENGTH(trim(a.work_no)) IS NULL OR            "+
										"						  a.work_no IN (SELECT invoice_group_id FROM v_invoice_reject ))"; //WHERE dept_code = '"+arg_dept_code+"')" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>