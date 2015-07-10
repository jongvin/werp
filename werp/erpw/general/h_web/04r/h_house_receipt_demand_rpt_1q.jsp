<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code    = req.getParameter("as_dept_code");
     String as_sell_code    = req.getParameter("as_sell_code");
     String al_count        = req.getParameter("al_count");
     String ad_receipt_date = req.getParameter("ad_receipt_date");
     String as_deposit      = req.getParameter("as_deposit");
     String as_from_pyong   = req.getParameter("as_from_pyong");
     String as_to_pyong     = req.getParameter("as_to_pyong");
     String as_from_dongho  = req.getParameter("as_from_dongho");
     String as_to_dongho    = req.getParameter("as_to_dongho");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
    String query = "Select master.dongho," + 
     "          master.seq," + 
     "          agree.degree_code" + 
     "  From h_sale_agree agree," + 
     "          h_code_deposit deposit," + 
     "         ( select master.dept_code, master.sell_code," + 
     "                     master.dongho, master.pyong, master.seq" + 
     "            from h_sale_master master," + 
     "                   h_sale_agree agree" + 
     "          Where master.dept_code = '" + as_dept_code + "'" + 
     "            And master.sell_code = '" + as_sell_code + "'" + 
     "            And master.pyong  between '" + as_from_pyong  + "' and '" + as_to_pyong  + "' " + 
     "            And master.dongho between '" + as_from_dongho + "' and '" + as_to_dongho + "' " + 
     "            And master.sell_code = '" + as_sell_code + "'" + 
     "            And master.last_contract_date <= '" + ad_receipt_date + "'" + 
     "            And master.chg_date > '" + ad_receipt_date + "'" + 
     "            And master.chg_div <> '00'" + 
     "            And master.chg_div <> '03'" + 
     "            And master.dept_code = agree.dept_code" + 
     "            And master.sell_code = agree.sell_code" + 
     "            And master.dongho = agree.dongho" + 
     "            And master.seq = agree.seq" + 
     "            And agree.agree_date < '" + ad_receipt_date + "'" + 
     "            And agree.f_pay_yn = 'N'" + 
     "       group by master.dept_code, master.sell_code," + 
     "                master.dongho, master.pyong, master.seq" + 
     "         having count(*) >= '" + al_count + "'" + 
     "       ) master" + 
     " Where master.dept_code = agree.dept_code" + 
     "   And master.sell_code = agree.sell_code" + 
     "   And master.dongho = agree.dongho" + 
     "   And master.seq = agree.seq" + 
     "   And agree.agree_date =" + 
     "       ( select max(agree_date) max_agree_date" + 
     "           from h_sale_agree agree" + 
     "          Where dept_code = master.dept_code" + 
     "            And sell_code = master.sell_code" + 
     "            And dongho = master.dongho" + 
     "            And seq = master.seq" + 
     "            And agree_date < '" + ad_receipt_date + "'" + 
     "            And f_pay_yn = 'N' )" + 
     "   And master.dept_code = deposit.dept_code(+)" + 
     "   And master.sell_code = deposit.sell_code(+)" + 
     "   And master.pyong  between '" + as_from_pyong  + "' and '" + as_to_pyong  + "' " + 
     "   And master.dongho between '" + as_from_dongho + "' and '" + as_to_dongho + "' " + 
     "   And deposit.deposit_no(+) = '" + as_deposit + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>