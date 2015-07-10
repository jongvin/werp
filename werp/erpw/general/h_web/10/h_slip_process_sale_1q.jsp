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
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("biz_status",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("biz_type",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("cur_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("r_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("regist_date",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("moveinto_date",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("moveinto_fr_date",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("min_date",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("sell_slip_no",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("build_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
     
    String query =          " SELECT a.dongho,"+
  "        a.seq," +
  " 	      a.contract_code,"+
  " 	      a.cust_code,"+
  "        c.cust_name,"+
  "        c.cust_div,"+
  "        c.biz_status,"+
  "        c.biz_type,"+
  "        c.CUR_ZIP_CODE,"+
  "        c.CUR_ADDR1,"+
  "        c.CUR_ADDR2,"+
  "        to_char(r_dt.r_date,'yyyy.mm.dd') r_date ,"+
  "        to_char(a.regist_date, 'yyyy.mm.dd') regist_date,"+
  "        to_char(a.moveinto_date, 'yyyy.mm.dd') moveinto_date,"+
  "        to_char(h.moveinto_fr_date, 'yyyy.mm.dd') moveinto_fr_date, "+
  "        case when least(nvl(moveinto_date,to_date('2999.12.31')),nvl(regist_date,to_date('2999.12.31')), r_dt.r_date) = r_dt.r_date and "+
  "                          to_char(least(nvl(moveinto_date,to_date('2999.12.31')),nvl(regist_date,to_date('2999.12.31')), r_dt.r_date),'yyyy') <> to_char(h.moveinto_fr_date,'yyyy') "+
  "                  then h.moveinto_fr_date "+
  "                  else least(nvl(moveinto_date,to_date('2999.12.31')),nvl(regist_date,to_date('2999.12.31')), r_dt.r_date) "+
  "         end min_date, "+
  "        a.sell_slip_no ,"+
  "        sum(b.r_land_amt)  land_amt,"+
  "        sum(b.r_build_amt) build_amt,"+
  "        sum(b.r_vat_amt)   vat_amt,"+
  "        sum(b.r_amt)  sell_amt"+
  "   FROM H_SALE_MASTER a,"+
  "        H_SALE_income  b,"+
  "        H_CODE_CUST   c,"+
  "        (select moveinto_fr_date "+
  "            from h_code_house "+
  "           where dept_code = '"+arg_dept_code+"'"+
  "             and sell_code = '"+arg_sell_code+"' ) h, "+
  "        (SELECT m.dept_code,"+
  "                m.sell_code,"+
  "                m.dongho,"+
  "                m.seq"+
  "           FROM H_SALE_MASTER m ,"+
  "                H_SALE_AGREE a"+
  "          WHERE m.dept_code = a.dept_code"+
  "            AND m.sell_code = a.sell_code"+
  "            AND m.dongho    = a.dongho"+
  "            AND m.seq       = a.seq"+
  "            AND a.degree_code = '50'"+
  "            AND a.f_pay_yn = 'Y'"+
  "            AND m.dept_code = '"+arg_dept_code+"'"+
  "            AND m.sell_code = '"+arg_sell_code+"' ) f_pay, "+
  "        (select i.dept_code,"+
  "                i.sell_code,"+
  "                i.dongho,"+
  "                i.seq,"+
  "                max(i.receipt_date) r_date"+
  "           from h_sale_income i"+
  "          where i.dept_code = '"+arg_dept_code+"'"+
  "            and i.sell_code = '"+arg_sell_code+"'"+
  "            and i.degree_code = '50'"+
  "         group by i.dept_code,"+
  "                i.sell_code,"+
  "                i.dongho,"+
  "                i.seq) r_dt"+
  "  WHERE (LENGTH(trim(A.sell_slip_no)) IS NULL OR             "+
  "             A.sell_slip_no IN (SELECT TO_CHAR(invoice_group_id) FROM v_invoice_reject )    "+
  "            )"+
  "    AND f_pay.dept_code = b.dept_code"+
  "    AND f_pay.sell_code = b.sell_code"+
  "    AND f_pay.dongho    = b.dongho"+
  "    AND f_pay.seq       = b.seq"+
  "    AND f_pay.dept_code = r_dt.dept_code"+
  "    AND f_pay.sell_code = r_dt.sell_code"+
  "    AND f_pay.dongho    = r_dt.dongho"+
  "    AND f_pay.seq       = r_dt.seq"+
  "    AND a.dept_code = b.dept_code"+
  "    AND a.sell_code = b.sell_code"+
  "    AND a.dongho    = b.dongho"+
  "    AND a.seq       = b.seq"+
  "    AND a.cust_code = c.cust_code (+)"+
  "    AND a.dept_code = '"+arg_dept_code+"'"+
  "    AND a.sell_code = '"+arg_sell_code+"'"+
   "    AND a.last_contract_date <= '2999.12.30'"+
  "    AND a.chg_date    > '2999.12.30'"+
  "    AND a.chg_div     <> '00'"+
  "  group by a.dongho,"+
  "        a.seq,"+
  " 	   a.contract_code,"+
  " 	   a.cust_code,"+
  "        c.cust_name,"+
  "        c.cust_div,"+
  "        c.biz_status,"+
  "        c.biz_type,"+
  "        c.CUR_ZIP_CODE,"+
  "        c.CUR_ADDR1,"+
  "        c.CUR_ADDR2,"+
  "        r_dt.r_date ,"+
  "        a.regist_date,"+
  "        a.moveinto_date,"+
  "        h.moveinto_fr_date, "+
  "        case when least(nvl(moveinto_date,to_date('2999.12.31')),nvl(regist_date,to_date('2999.12.31')), r_dt.r_date) = r_dt.r_date and "+
  "                          to_char(least(nvl(moveinto_date,to_date('2999.12.31')),nvl(regist_date,to_date('2999.12.31')), r_dt.r_date),'yyyy') <> to_char(h.moveinto_fr_date,'yyyy') "+
  "                  then h.moveinto_fr_date "+
  "                  else least(nvl(moveinto_date,to_date('2999.12.31')),nvl(regist_date,to_date('2999.12.31')), r_dt.r_date) "+
  "         end  , "+
  "        a.sell_slip_no "+
  "  ORDER BY  a.dongho,"+
  "           a.seq";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>