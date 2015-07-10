<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sell_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("moveinto_fr_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("moveinto_to_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_fr_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("use_inspect_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tot_house",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("contract_delay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remain_discount_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("lease_delay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ontime_contract_delay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ontime_remain_discount_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("penalty_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("income_taxrate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("residence_taxrate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("term_interest_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("union_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("ledger_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("ledger_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("ledger_items",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("union_movein_from",GauceDataColumn.TB_STRING,18));
	 dSet.addDataColumn(new GauceDataColumn("union_movein_to",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("base_pyong_memo",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("rent_delay_yn",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("loan_tele",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("recp_tele",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("addr_tele",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("mh_tele",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("loan_bank_code",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("share_rate",GauceDataColumn.TB_DECIMAL,5,3));
	  dSet.addDataColumn(new GauceDataColumn("acntno_due",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("acntno_pre",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("home_page_yn",GauceDataColumn.TB_STRING,1));
	 
    String query = "  SELECT  h_code_house.dept_code dept_code," + 
     "          h_code_dept.long_name," + 
     "          h_code_house.sell_code ," + 
     "          h_code_common.code_name code_name," + 
     "          to_char(h_code_house.sell_date,'yyyy.mm.dd') sell_date ," + 
     "          to_char(h_code_house.moveinto_fr_date,'yyyy.mm.dd') moveinto_fr_date ," + 
     "          to_char(h_code_house.moveinto_to_date,'yyyy.mm.dd') moveinto_to_date ," + 
     "          to_char(h_code_house.approve_date,'yyyy.mm.dd') approve_date ," + 
     "          to_char(h_code_house.const_fr_date, 'yyyy.mm.dd') const_fr_date ," + 
     "          to_char(h_code_house.use_inspect_date,'yyyy.mm.dd') use_inspect_date ," + 
     "          h_code_house.tot_house ," + 
     "          h_code_house.contract_delay_yn ," + 
     "          h_code_house.remain_discount_yn ," + 
     "          h_code_house.lease_delay_yn ," + 
     "          h_code_house.ontime_contract_delay_yn ," + 
     "          h_code_house.ontime_remain_discount_yn ," + 
     "          h_code_house.penalty_rate ," + 
     "          h_code_house.income_taxrate ," + 
     "          h_code_house.residence_taxrate ," + 
     "          h_code_house.term_interest_rate ," + 
     "          h_code_house.delay_days ," + 
     "          h_code_house.delay_rate ," + 
     "          h_code_house.union_yn ," + 
     "          h_code_house.remark ," +
     "          h_code_house.ledger_name ," +
     "          h_code_house.ledger_phone ," +
     "          h_code_house.ledger_items ,"+
	 "          to_char(h_code_house.union_movein_from,'yyyy.mm.dd') union_movein_from ," + 
     "          to_char(h_code_house.union_movein_to,'yyyy.mm.dd') union_movein_to  ,"+
	 "          h_code_house.base_pyong_memo, "+
	 "          h_code_house.rent_delay_yn ,"+
	 "          to_char(h_code_house.cont_date,'yyyy.mm.dd') cont_date ,"+
	 "          h_code_house.loan_tele ,"+
	 "          h_code_house.recp_tele ,"+
	 "          h_code_house.addr_tele ,"+
	 "          h_code_house.mh_tele ,"+
	 "          h_code_dept.process_code, "+
	 "          h_code_house.loan_bank_code, "+
	 "          h_code_house.share_rate, "+
	 "          h_code_house.acntno_due, "+
	 "          h_code_house.acntno_pre,"+
	 "          h_code_house.home_page_yn"+
	 "          FROM h_code_house ," + 
     "          h_code_dept ," + 
     "          h_code_common  WHERE ( h_code_house.dept_code = h_code_dept.dept_code ) and  " + 
     "                                  ( h_code_house.sell_code = h_code_common.code ) and  " + 
     "             ( ( h_code_common.code_div = '03' ) )      " +
     "      order by h_code_dept.long_name " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>