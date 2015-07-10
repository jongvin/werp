<%@ page session="true" contentType="text/html;charset=EUC_KR"         import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code"); 
 String arg_sell_code = req.getParameter("arg_sell_code"); 
 String arg_fr_date  = req.getParameter("arg_fr_date");
 String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,11));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("degree_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("build_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dui",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("penalty",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("refund",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT '1미수금대체' tag," + 
     "             a.dongho," + 
     "             a.seq," + 
     "		       a.contract_code," + 
     "		       a.chg_date," + 
     "		       a.cust_code," + 
     "             n.cust_name," + 
	  "             b.degree_code, "+
     "             z.code_name degree_name," + 
     "             to_char(b.agree_date, 'yyyy.mm.dd') agree_date," + 
     "             SUM(trunc(b.sell_amt * ch.share_rate /100, 0))  sell_amt, " + 
     "             SUM(trunc(b.land_amt * ch.share_rate /100, 0))  land_amt," + 
     "		       SUM(trunc(b.build_amt * ch.share_rate /100, 0))  build_amt, " + 
     "            SUM(trunc(vat_amt * ch.share_rate /100, 0))  vat_amt," + 
     "             0 dui," + 
     "             0 penalty," + 
     "             0 refund" + 
     "        FROM H_SALE_MASTER  a," + 
     "             H_SALE_AGREE b," + 
     "             H_SALE_ANNUL c," + 
     "             H_CODE_CUST n," + 
	  "             h_code_common  z,"+
	  "             h_code_house ch"+
     "       WHERE (LENGTH(trim(c.slip_no)) IS NULL OR            "+
     "        c.slip_no IN (SELECT invoice_group_id FROM v_invoice_reject )  ) "+
	  "         and  b.agree_date <= '"+ arg_to_date+"'" + 
	  "          and z.code_div = '02' and z.code = b.degree_code "+
	  "         and  a.dept_code = b.dept_code(+)" + 
     "		   AND a.sell_code = b.sell_code(+)" + 
     "         AND a.dongho    = b.dongho(+)" + 
     "		   AND a.seq       = b.seq(+)" + 
     "         AND a.dept_code = c.dept_code" + 
     "		   AND a.sell_code = c.sell_code" + 
     "         AND a.dongho    = c.dongho" + 
     "		   AND a.seq       = c.seq" + 
     "		   AND a.dept_code = '"+arg_dept_code+"'" + 
     "		   AND a.sell_code = '"+arg_sell_code+"'" + 
     "		   AND a.chg_date  BETWEEN  '"+arg_fr_date+"'  AND '"+ arg_to_date+"'" + 
     "         AND a.cust_code = n.cust_code(+)" + 
	  "         and a.dept_code = ch.dept_code(+) "+
	  "         and a.sell_code = ch.sell_code(+) "+
     "     GROUP BY a.dongho," + 
     "             a.seq," + 
     "		       a.contract_code," + 
     "		       a.chg_date," + 
     "		       a.cust_code," + 
     "             n.cust_name," +
	  "		       b.degree_code," + 
     "		       z.code_name," + 
     "             b.agree_date" + 
     "     " + 
     "      UNION ALL    " + 
     "         " + 
     "      SELECT '2납입' tag," + 
     "             a.dongho," + 
     "             a.seq," + 
     "		       a.contract_code," + 
     "		       a.chg_date," + 
     "		       a.cust_code," + 
     "             n.cust_name," + 
	  "		       '' degree_code," +
     "		       '' degree_name," + 
     "             '' agree_date," + 
     "             0 sell_amt, " + 
     "             0 land_amt," + 
     "		       0 build_amt, " + 
     "             0 vat_amt," + 
     "             b.sell - SUM( TRUNC(NVL(e.r_amt,0) * ch.share_rate /100, 0) )  dui," + 
     "             c.PENALTY ," + 
     "             SUM( TRUNC(NVL(e.r_amt,0) * ch.share_rate /100, 0) ) - c.PENALTY  refund " + 
     "        FROM H_SALE_MASTER  a," + 
     "             (SELECT dongho," + 
     "                     seq," + 
     "                     SUM(NVL(sell_amt,0)) sell" + 
     "                FROM H_SALE_AGREE" + 
     "               WHERE /*LENGTH(trim(work_no)) IS NOT  NULL" + 
     "                 AND*/ dept_code = '"+arg_dept_code+"'" + 
     "		           AND sell_code = '"+arg_sell_code+"'" + 
     "              GROUP BY dongho," + 
     "                     seq" + 
     "             ) b," + 
     "             H_SALE_ANNUL c," + 
     "             H_SALE_INCOME e," + 
     "             H_CODE_CUST n," + 
	  "             h_code_house ch"+
     "       WHERE (LENGTH(trim(c.slip_no)) IS NULL OR            "+
     "        c.slip_no IN (SELECT invoice_group_id FROM v_invoice_reject WHERE dept_code = '"+arg_dept_code+"')  ) "+
	  "         and a.dongho    = b.dongho(+)" + 
     "		   AND a.seq       = b.seq(+)" + 
     "         AND a.dept_code = c.dept_code" + 
     "		   AND a.sell_code = c.sell_code" + 
     "         AND a.dongho    = c.dongho" + 
     "		   AND a.seq       = c.seq" + 
     "         AND a.dept_code = e.dept_code(+)" + 
     "		   AND a.sell_code = e.sell_code(+)" + 
     "         AND a.dongho    = e.dongho(+)" + 
     "		   AND a.seq       = e.seq(+)" + 
     "         AND a.dept_code = '"+arg_dept_code+"'" + 
     "		   AND a.sell_code = '"+arg_sell_code+"'" + 
     "		   AND a.chg_date  BETWEEN  '"+arg_fr_date+"'  AND '"+ arg_to_date+"'" + 
     "         AND e.degree_code <> '99'" + 
     "         AND e.receipt_code <> '24'" + 
     "         AND a.cust_code = n.cust_code(+)" +
	   "         and a.dept_code = ch.dept_code(+) "+
	  "         and a.sell_code = ch.sell_code(+) "+
     "     GROUP BY a.dongho," + 
     "             a.seq," + 
     "		       a.contract_code," + 
     "		       a.chg_date," + 
     "		       a.cust_code," + 
     "             n.cust_name," + 
     "             c.PENALTY,b.sell" + 
     "     ORDER BY dongho, tag," + 
     "		       degree_code     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>