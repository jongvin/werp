<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code"); 
 String arg_sell_code = req.getParameter("arg_sell_code"); 
 String arg_fr_date  = req.getParameter("arg_fr_date");
 String arg_to_date = req.getParameter("arg_to_date");

     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("biz_status",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("biz_type",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("cur_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("build_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));

 String query = "SELECT substr(a.dongho,1,4)||'-'||substr(a.dongho,5,4) dongho," + 
           "  a.seq," + 
           "  a.contract_code," + 
           "  to_char(b.agree_date,'yyyy.mm.dd') agree_date," + 
           "  b.degree_code," + 
           "  a.cust_code," + 
           "  c.cust_name," + 
           "  c.cust_div," + 
           "  c.biz_status," + 
           "  c.biz_type," + 
           "  c.cur_zip_code," + 
           "  c.cur_addr1," + 
           "  c.cur_addr2," + 
           "  d.code_name," + 
           "  to_char(b.work_date,'yyyy.mm.dd') work_date," + 
           "  b.work_no," + 
           "  b.land_amt," + 
           "  b.build_amt," + 
           "  b.vat_amt," + 
           "  b.sell_amt " + 
           " FROM H_SALE_MASTER a," + 
           "   ( select f.dept_code, f.sell_code, f.dongho, f.seq, f.degree_code," + 
           "            f.land_amt, f.build_amt, f.vat_amt, f.sell_amt, f.work_date, f.work_no," + 
           "       decode(f.degree_code,'50',case " + 
           "          when f.sell_amt <= f.r_amt and f.last_recp <= f.moveinto_fr_date " + 
           "               then f.moveinto_fr_date " + 
           "          when f.sell_amt <= f.r_amt and f.last_recp between f.moveinto_fr_date and f.moveinto_to_date " + 
           "               then f.last_recp" + 
           "          when f.sell_amt > f.r_amt and (f.moveinto_to_date <= "+"'"+arg_to_date+"'"+")  " + 
           "               then f.moveinto_to_date" + 
           "          when f.sell_amt > f.r_amt and (f.moveinto_to_date > "+"'"+arg_to_date+"'"+")  " + 
           "               then null " +              
           "          end, f.agree_date)  agree_date " + 
           "   from  ( " + 
           "          select agree.dept_code, agree.sell_code, agree.dongho, " + 
           "                 agree.seq, agree.sell_amt, agree.degree_code, agree.agree_date," + 
           "                 house.moveinto_fr_date, house.moveinto_to_date, " + 
           "                 agree.land_amt, agree.build_amt, agree.vat_amt, agree.work_date, agree.work_no," + 
           "                 nvl(max(income.receipt_date),Null) as last_recp, nvl(sum(income.r_amt),0) as r_amt" + 
           "            from h_sale_agree agree, h_sale_income income, h_code_house house" + 
           "            where  " + 
           "                 agree.dept_code = income.dept_code(+) and" + 
           "                 agree.sell_code = income.sell_code(+) and" + 
           "                 agree.dongho = income.dongho(+) and" + 
           "                 agree.seq = income.seq(+) and" + 
           "                 agree.degree_code = income.degree_code(+) and" + 
           "                 income.degree_seq < 70 and" + 
           "                 agree.dept_code = house.dept_code and" + 
           "                 agree.sell_code = house.sell_code and" + 
           "                 agree.dept_code = " + "'" + arg_dept_code + "' and " + 
           "                 agree.sell_code = " + "'" + arg_sell_code + "'" + 
           "              group by agree.dept_code, agree.sell_code, agree.dongho, " + 
           "                  agree.seq, agree.sell_amt, agree.degree_code, agree.agree_date," + 
           "                  house.moveinto_fr_date, house.moveinto_to_date, " + 
           "                  agree.land_amt, agree.build_amt, agree.vat_amt, agree.work_date, agree.work_no" + 
           "              ) f      " + 
           "    Where Case " + 
           "              when f.sell_amt <= f.r_amt and f.last_recp <= f.moveinto_fr_date " + 
           "                   then f.moveinto_fr_date " + 
           "              when f.sell_amt <= f.r_amt and f.last_recp between f.moveinto_fr_date and f.moveinto_to_date " + 
           "                   then f.last_recp" + 
           "              when f.sell_amt > f.r_amt and (f.moveinto_to_date <= "+"'"+arg_to_date+"'"+")  " + 
           "                   then f.moveinto_to_date" + 
           "              when f.sell_amt > f.r_amt and (f.moveinto_to_date > "+"'"+arg_to_date+"'"+")  " + 
           "                   then null   " +              
           "              end is Not Null " + 
           "       ) b,   " + 
           "  H_CODE_CUST   c," + 
           "  H_CODE_COMMON d " + 
           " WHERE (LENGTH(trim(b.work_no)) IS NULL OR  b.work_no IN (SELECT invoice_group_id FROM v_invoice_reject )) " + 
           "      AND a.dept_code = b.dept_code" + 
           "      AND a.sell_code = b.sell_code" + 
           "      AND a.dongho    = b.dongho" + 
           "      AND a.seq       = b.seq" + 
           "      AND a.cust_code = c.cust_code (+)" + 
           "      AND b.degree_code = d.code (+)" + 
           "      AND d.code_div    = '02'" + 
           "      AND a.dept_code = " + "'" + arg_dept_code + "'" + 
           "      AND a.sell_code = " + "'" + arg_sell_code + "'" + 
           "      AND b.agree_date  BETWEEN " + "'" + arg_fr_date + "'"+ " AND " + "'" + arg_to_date + "'" + 
           "      AND a.chg_date >  b.agree_date" + 
           "      AND a.last_contract_date <= b.agree_date" + 
           "      AND a.chg_div     <> '00'" + 
           "      AND (b.build_amt  <> 0 AND b.sell_amt = b.land_amt + b.build_amt + b.vat_amt ) " + 
           " ORDER BY  a.dongho, a.seq, b.degree_code ";

 /* 
 String query = "SELECT substr(a.dongho,1,4)||'-'||substr(a.dongho,5,4) dongho," + 
     "       a.seq," + 
     "       a.contract_code," + 
     "       to_char(b.agree_date,'yyyy.mm.dd') agree_date," + 
     "       b.degree_code," + 
     "       a.cust_code," + 
     "       c.cust_name," + 
     "       c.cust_div," + 
     "       c.biz_status," + 
     "       c.biz_type," + 
     "       c.CUR_ZIP_CODE," + 
     "       c.CUR_ADDR1," + 
     "       c.CUR_ADDR2," + 
     "       d.code_name," + 
     "       b.work_date ," + 
     "       b.work_no ," + 
     "       SUM(b.land_amt)  land_amt," + 
     "       SUM(b.build_amt) build_amt," + 
     "       SUM(b.vat_amt)   vat_amt," + 
     "       SUM(b.sell_amt)  sell_amt" + 
     "  FROM H_SALE_MASTER a," + 
     "       H_SALE_AGREE  b," + 
     "       H_CODE_CUST   c," + 
     "       H_CODE_COMMON d," +
   "       (SELECT TO_CHAR(invoice_group_id) invoice_group_id "+
     "         FROM v_invoice_reject                  "+
     "        WHERE dept_code = '"+arg_dept_code+"' UNION SELECT '-1' FROM dual) rej       "+
     " WHERE (LENGTH(trim(b.work_no)) IS NULL OR             "+
     "        b.work_no =  rej.invoice_group_id )"+
     "   AND a.dept_code = b.dept_code" + 
     "   AND a.sell_code = b.sell_code" + 
     "   AND a.dongho    = b.dongho" + 
     "   AND a.seq       = b.seq" + 
     "   AND a.cust_code = c.cust_code (+)" + 
     "   AND b.degree_code = d.code (+)" + 
     "   AND d.code_div    = '02'" + 
     "   AND a.dept_code = " + "'" + arg_dept_code + "'" + 
     "   AND a.sell_code = " + "'" + arg_sell_code + "'" + 
     "   AND b.agree_date  BETWEEN '"+arg_fr_date+"'"+" AND '"+ arg_to_date +"'"+
     "   AND a.chg_div     <> '00'" + 
   "   and   a.chg_date >  b.agree_date     "+
   "   and   a.last_contract_date <= b.agree_date "+
     " GROUP BY a.dongho," + 
     "          a.seq," + 
     "          a.contract_code," + 
     "          b.agree_date," + 
     "          b.degree_code," + 
     "          a.cust_code," + 
     "          c.cust_name," + 
     "          c.cust_div," + 
     "          c.biz_status," + 
     "          c.biz_type," + 
     "          c.CUR_ZIP_CODE," + 
     "          c.CUR_ADDR1," + 
     "          c.CUR_ADDR2," + 
     "          d.code_name,b.work_date,b.work_no " + 
     " HAVING  SUM(b.build_amt)  <> 0" + 
     "    AND (SUM(b.sell_amt) = (SUM(b.land_amt) + SUM(b.build_amt) + SUM(b.vat_amt)))" + 
     "" + 
     " ORDER BY  a.dongho," + 
     "           a.seq," + 
     "       b.degree_code      ";
*/
  
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>