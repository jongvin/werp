<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String as_dept_code = req.getParameter("as_dept_code");
     String as_dongho 	 = req.getParameter("as_dongho");
     String al_seq 		 = req.getParameter("al_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("contract_code",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("chg_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_id",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("last_contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("fund_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("loan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("moveinto_plan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("moveinto_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sell_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("all_sum",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  Select master.dept_code," + 
     "         master.sell_code," + 
     "			master.dongho," + 
     "         nvl(master.pyong, 0) pyong," + 
     "         master.style," + 
     "         master.class," + 
     "         master.option_code," + 
     "         master.cust_code," + 
     "         cust.cust_name," + 
     "			cust.cust_div," + 
     "			master.contract_code," +
	 "			master.chg_div," +
     "         master.union_code," + 
     "         master.union_id," + 
     "         to_char(master.last_contract_date, 'YYYY.MM.DD') last_contract_date," + 
     "         nvl(master.fund_amt, 0) fund_amt," + 
     "         nvl(master.loan_amt, 0) loan_amt," + 
     "         nvl(master.guarantee_amt, 0) guarantee_amt," + 
     "         to_char(master.moveinto_plan_date, 'YYYY.MM.DD') moveinto_plan_date," + 
     "         master.moveinto_code," + 
     "         nvl(sum(agree.sell_amt), 0) sell_sum," + 
     "         nvl(sum(agree.tot_amt), 0) degree_sum," + 
     "         nvl(sum(agree.sell_amt), 0) - nvl(sum(agree.tot_amt), 0) all_sum" + 
     "    From h_sale_master master," + 
     "         h_sale_agree agree," + 
     "         h_code_cust cust" + 
     "   Where master.dept_code = agree.dept_code" + 
     "     And master.sell_code = agree.sell_code" + 
     "     And master.dongho = agree.dongho" + 
     "     And master.seq = agree.seq" + 
     "     And master.cust_code = cust.cust_code(+)" + 
     "     And master.dept_code = '" + as_dept_code + "'" + 
     "     And master.dongho    = '" + as_dongho + "'" + 
     "     And master.seq       = " + al_seq +
     " Group By master.dept_code," + 
     "         master.sell_code," + 
     "			master.dongho," + 
     "         nvl(master.pyong, 0)," + 
     "         master.style," + 
     "         master.class," + 
     "         master.option_code," + 
     "         master.cust_code," + 
     "         cust.cust_name," + 
     "         cust.cust_div," + 
     "			master.contract_code," + 
	 "			master.chg_div," +
     "         master.union_code," + 
     "         master.union_id," + 
     "         to_char(master.last_contract_date, 'YYYY.MM.DD')," + 
     "         nvl(master.fund_amt, 0)," + 
     "         nvl(master.loan_amt, 0)," + 
     "         nvl(master.guarantee_amt, 0)," + 
     "         to_char(master.moveinto_plan_date, 'YYYY.MM.DD')," + 
     "         master.moveinto_code     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>