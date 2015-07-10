<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
   
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_from_date = req.getParameter("arg_from_date");
 String arg_to_date = req.getParameter("arg_to_date");
 String arg_process_tag = req.getParameter("arg_process_tag");
 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sell_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("jan",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("feb",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("mar",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("arp",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("may",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("jun",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("jul",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("aug",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("sep",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("oct",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("nov",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("dec",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("r_vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("delay_discount_amt",GauceDataColumn.TB_DECIMAL,18,0));

     String query = "" + 
     "  SELECT a.dept_code, "+
     "       c.long_name,						"+
     "       a.sell_code,								"+
     "       d.code_name sell_name, "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '01', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS jan, "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '02', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS feb,	  "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '03', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS mar,	 "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '04', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS arp,	  "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '05', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS may,		"+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '06', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS jun,			 "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '07', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS jul,			  "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '08', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS aug,		  "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '09', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS sep,		  "+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '10', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS oct,				"+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '11', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS nov,			"+
     "       TRUNC(NVL(SUM(DECODE(TO_CHAR(a.receipt_date, 'MM'), '12', a.r_amt + a.delay_amt -a.discount_amt, 0)), 0)/1000000,0) AS DEC, 		"+
     "       TRUNC(NVL(SUM(a.r_amt), 0) /1000000,0) AS r_amt, 	"+
     "       TRUNC(NVL(SUM(a.r_amt - a.r_vat_amt), 0)/1000000,0)  AS supply_amt,   "+
     "       TRUNC(NVL(SUM(a.r_vat_amt), 0)/1000000,0)    AS r_vat_amt,  							"+
     "       TRUNC(NVL(SUM(a.discount_amt - a.delay_amt), 0)/1000000,0) AS delay_discount_amt  "+
   " FROM H_SALE_INCOME a,	  "+
    "        H_SALE_MASTER b,			"+
    "        H_CODE_DEPT c,					"+
    "       H_CODE_COMMON d			"+
   " WHERE a.dept_code like '"+arg_dept_code+"'||'%' " +
	"  and  a.sell_code like '"+arg_sell_code+"'||'%' " +
	"  AND TO_CHAR(a.receipt_date, 'YYYY.MM') BETWEEN '"+arg_from_date+"' AND '"+arg_to_date+"'   "+
	"  AND ((b.last_contract_date <= '"+arg_to_date+"'  "+
	"  AND b.chg_date > '"+arg_to_date+"'  "+
	"  AND b.chg_div <> '00') OR (b.chg_div = '03'))  "+
	"  AND b.chg_div <> '00'                                           "+
	"  AND c.process_code LIKE DECODE('"+arg_process_tag+"', 'ALL', '%', '"+arg_process_tag+"')  "+
   "             AND a.dept_code = b.dept_code "+
   "             AND a.sell_code = b.sell_code		"+
   "             AND a.dongho = b.dongho					"+
   "             AND a.seq = b.seq									"+
	"  AND a.dept_code = c.dept_code					"+
	"  AND a.sell_code = d.code									"+
	"  AND d.code_div = '03'											"+
   "             AND a.degree_seq < '90'						"+
 "GROUP BY c.long_name, a.dept_code, a.sell_code, d.code_name  order by c.long_name, a.sell_code";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>