<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
// 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("key_receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("const_shortname",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_no1",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("const_position",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("constkind_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pq_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("join_cont_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("receive_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("receive_process_class",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("tender_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("order_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("const_from",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_to",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("parent_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("siteexplan_date",GauceDataColumn.TB_STRING,19));
     dSet.addDataColumn(new GauceDataColumn("siteexplan_place",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("siteexplan_cond",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("siteexplan_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("siteexplan_name",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("siteexplan_entrycompany",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("siteexplan_memo",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("regist_date",GauceDataColumn.TB_STRING,19));
     dSet.addDataColumn(new GauceDataColumn("regist_place",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("regist_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tender_no",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("tender_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tender_place",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("tender_cond",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("tender_guarantee",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("entry_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("entry_company",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("pq_limit_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("res_end_date",GauceDataColumn.TB_STRING,19));
     dSet.addDataColumn(new GauceDataColumn("pro_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("design_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("survey_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("office_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("presume_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("presume_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("valuation_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("budget_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("budget_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("budget_from_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("budget_to_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bid_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bid_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bid_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ocomp_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ocomp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ocomp_consortium",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("const_outline1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("const_outline2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("limit_contents1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("limit_contents2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("year_area",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("year_area_unit",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("volume_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("bulid_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("const_area",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("const_area_unit",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("comp_size",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("floor",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("approve_cond",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("before_opinion",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("after_opinion",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_name2",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("region_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("imp_supplier",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("bid_comp",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("cons_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("cons_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("r_process_class",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("masterdept_tag",GauceDataColumn.TB_STRING,3));
    String query = "  SELECT a.receive_code," + 
     "             a.receive_code key_receive_code, " +
     "             a.NAME, " + 
     "             a.CONST_SHORTNAME, " + 
     "             a.ORDER_NO, " + 
     "             a.ORDER_NO1, " + 
     "             a.REGION_CODE, " + 
     "             a.CONST_POSITION, " + 
     "             a.CONSTKIND_TAG, " + 
     "             a.PQ_TAG, " + 
     "             a.JOIN_CONT_TAG, " + 
     "             a.RECEIVE_TAG, " + 
     "             a.RECEIVE_PROCESS_CLASS, " + 
     "             a.TENDER_TAG, " + 
     "             a.ORDER_TAG, " + 
     "             to_char(a.CONST_FROM,'YYYY.MM.DD') CONST_FROM, " + 
     "             to_char(a.CONST_TO,'YYYY.MM.DD') CONST_TO, " + 
     "             a.DEPT_CODE, " + 
     "             a.PARENT_DEPT_CODE," + 
     "             a.APPROVE_CLASS, " + 
     "             to_char(a.SITEEXPLAN_DATE,'YYYYMMDD HH24MI') SITEEXPLAN_DATE, " + 
     "             a.SITEEXPLAN_PLACE, " + 
     "             a.SITEEXPLAN_COND, " + 
     "             a.SITEEXPLAN_TAG, " + 
     "             a.SITEEXPLAN_NAME, " + 
     "             a.SITEEXPLAN_ENTRYCOMPANY, " + 
     "             a.SITEEXPLAN_MEMO, " + 
     "             to_char(a.REGIST_DATE,'YYYYMMDD HH24MI') REGIST_DATE, " + 
     "             a.REGIST_PLACE, " + 
     "             a.REGIST_TAG, " + 
     "             a.TENDER_NO, " + 
     "             to_char(a.TENDER_DATE,'YYYYMMDD HH24MI') TENDER_DATE, " + 
     "             a.TENDER_PLACE, " + 
     "             a.TENDER_COND, " + 
     "             nvl(a.TENDER_GUARANTEE,0) TENDER_GUARANTEE, " + 
     "             a.ENTRY_TAG, " + 
     "             a.ENTRY_COMPANY, " + 
     "             to_char(a.PQ_LIMIT_DATE,'YYYY.MM.DD') PQ_LIMIT_DATE, " + 
     "             to_char(a.RES_END_DATE,'YYYYMMDD HH24MI') RES_END_DATE, " + 
     "             to_char(a.PRO_END_DATE,'YYYY.MM.DD') PRO_END_DATE, " + 
     "             nvl(a.DESIGN_AMT,0) DESIGN_AMT, " + 
     "             nvl(a.SURVEY_AMT,0) SURVEY_AMT, " + 
     "             nvl(a.OFFICE_AMT,0) OFFICE_AMT," + 
     "             nvl(a.PRESUME_AMT,0) PRESUME_AMT," + 
     "             nvl(a.PRESUME_PRICE,0) PRESUME_PRICE," + 
     "             nvl(a.VALUATION_AMT,0) VALUATION_AMT," + 
     "             nvl(a.BUDGET_AMT,0) BUDGET_AMT," + 
     "             nvl(a.BUDGET_RATE,0) BUDGET_RATE," + 
     "             nvl(a.BUDGET_FROM_RATE,0) BUDGET_FROM_RATE," + 
     "             nvl(a.BUDGET_TO_RATE,0) BUDGET_TO_RATE," + 
     "             to_char(a.BID_DATE,'YYYY.MM.DD') BID_DATE, " + 
     "             nvl(a.BID_AMT,0) BID_AMT," + 
     "             nvl(a.BID_RATE,0) BID_RATE," + 
     "             nvl(a.OCOMP_RATE,0) OCOMP_RATE," + 
     "             nvl(a.OCOMP_AMT,0) OCOMP_AMT," + 
     "             a.OCOMP_CONSORTIUM, " + 
     "             a.CONST_OUTLINE1, " + 
     "             a.CONST_OUTLINE2, " + 
     "             a.LIMIT_CONTENTS1, " + 
     "             a.LIMIT_CONTENTS2, " + 
     "             nvl(a.YEAR_AREA,0)  YEAR_AREA, " + 
     "             a.YEAR_AREA_UNIT, " + 
     "             nvl(a.VOLUME_RT,0) VOLUME_RT," + 
     "             nvl(a.BULID_RT,0) BULID_RT," + 
     "             nvl(a.CONST_AREA,0) CONST_AREA," + 
     "             a.CONST_AREA_UNIT, " + 
     "             a.COMP_SIZE, " + 
     "             a.FLOOR, " + 
     "             a.APPROVE_COND, " + 
     "             a.BEFORE_OPINION, " + 
     "             a.AFTER_OPINION, " + 
     "             a.REMARK, " + 
     "  	          b.order_name, " + 
     " 		       c.order_name    order_name2, " + 
     "    	       d.name          region_name, " +
     "             a.imp_supplier, " +
     "             a.input_name," +
     "             a.bid_comp, " +
     "             '' cons_year, " +
     "             '' cons_no, " +
     "             '' r_process_class, " + 
     "				 a.masterdept_tag " +
     "        FROM r_receive_code  a, " + 
     "  	          r_code_order b, " + 
     " 		       r_code_order c, " + 
     " 		       y_region_code d " +
     "       WHERE a.order_no = b.order_no (+) " +
     " 	      and a.order_no1 = c.order_no (+) " +
     "         and a.region_code = d.region_code (+)  " +
     "         and a.receive_tag = '1' " +
     "         and ( a.tender_date is null or substrb(to_char(a.tender_date,'YYYY'),1,4) = " + "'" + arg_date + "'" + " )" +
     "    order by a.receive_code desc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>