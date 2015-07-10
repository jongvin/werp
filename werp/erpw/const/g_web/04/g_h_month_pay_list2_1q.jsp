<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
   
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_from_date = req.getParameter("arg_from_date");
 String arg_to_date = req.getParameter("arg_to_date");
 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sell_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
	  
     String query = "" + 
     "   SELECT a.dept_code,  "+
     "   c.long_name,							 "+
     "   a.sell_code,									 "+
     "   d.code_name sell_name, 	  "+
     "   TO_CHAR(a.receipt_date, 'YYYY.MM') month, "+
     "   TRUNC(SUM(NVL(a.r_amt,0) + NVL(a.delay_amt, 0) -NVL(a.discount_amt, 0))/1000000,0) amt  "+
  " FROM H_SALE_INCOME a,	"+  
  "      H_SALE_MASTER b,					"+
  "      H_CODE_DEPT c,							"+
  "      H_CODE_COMMON d						"+
 " WHERE a.dept_code = '"+arg_dept_code+"'"+
 "   AND a.sell_code = '"+arg_sell_code+"'"+
 "   AND TO_CHAR(a.receipt_date, 'YYYY.MM') BETWEEN '"+arg_from_date+"' AND '"+arg_to_date +"'"+
 "   AND ((b.last_contract_date <= '"+arg_to_date+"'"+
 "   AND b.chg_date > '"+arg_to_date+"'"+
 "   AND b.chg_div <> '00') OR (b.chg_div = '03'))  																												"+
 "   AND b.chg_div <> '00'                                           																												"+
 "   AND a.dept_code = b.dept_code 																																				 "+
 "   AND a.sell_code = b.sell_code																																					 "+
 "   AND a.dongho = b.dongho																																								"+
 "   AND a.seq = b.seq																																												"+
 "   AND a.dept_code = c.dept_code																																				"+
 "   AND a.sell_code = d.code																																								"+
 "   AND d.code_div = '03'																																											"+
 "   AND a.degree_seq < '90'																																									"+
" GROUP BY c.long_name, a.dept_code, a.sell_code, d.code_name,TO_CHAR(a.receipt_date, 'YYYY.MM')  "+
" ORDER BY c.long_name, a.sell_code, TO_CHAR(a.receipt_date, 'YYYY.MM')";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>