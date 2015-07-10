<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("date_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("const_shortname",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_no1",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name2",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("region_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("const_position",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("constkind_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pq_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("join_cont_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("receive_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("receive_process_class",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("tender_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("order_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("notice_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_time",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("field_explan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pq_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pq_limit_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tender_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_from",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_to",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("presume_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("presume_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("const_outline1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("const_outline2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("limit_contents1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("limit_contents2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("notice_material",GauceDataColumn.TB_STRING,20));
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
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT a.DATE_YEAR,   " + 
     "         a.NO,   " + 
     "         a.NAME,   " + 
     "         a.CONST_SHORTNAME,   " + 
     "         a.RECEIVE_CODE,   " + 
     "         a.ORDER_NO,   " + 
     "			b.order_name," + 
     "         a.ORDER_NO1, " + 
     "			c.order_name    order_name2,   " + 
     "         a.REGION_CODE, " + 
     "			d.name          region_name,  " + 
     "         a.CONST_POSITION,   " + 
     "         a.CONSTKIND_TAG,   " + 
     "         a.PQ_TAG,   " + 
     "         a.JOIN_CONT_TAG,   " + 
     "         a.RECEIVE_TAG,   " + 
     "         a.RECEIVE_PROCESS_CLASS,   " + 
     "         a.TENDER_TAG,   " + 
     "         a.ORDER_TAG,   " + 
     "         to_char(a.INPUT_DATE,'YYYY.MM.DD')   INPUT_DATE," + 
     "         to_char(a.NOTICE_DATE,'YYYY.MM.DD')  NOTICE_DATE, " + 
     "         a.ORDER_TIME,   " + 
     "         to_char(a.FIELD_EXPLAN_DATE,'YYYY.MM.DD') FIELD_EXPLAN_DATE,   " + 
     "         a.PQ_CODE,   " + 
     "         to_char(a.PQ_LIMIT_DATE,'YYYY.MM.DD')  PQ_LIMIT_DATE,   " + 
     "         to_char(a.TENDER_DATE,'YYYY.MM.DD')    TENDER_DATE,   " + 
     "         to_char(a.CONST_FROM,'YYYY.MM.DD')     CONST_FROM,   " + 
     "         to_char(a.CONST_TO,'YYYY.MM.DD')       CONST_TO,   " + 
     "         a.PRESUME_PRICE,   " + 
     "         a.PRESUME_AMT,   " + 
     "         a.CONST_OUTLINE1,   " + 
     "         a.CONST_OUTLINE2,   " + 
     "         a.LIMIT_CONTENTS1,   " + 
     "         a.LIMIT_CONTENTS2,   " + 
     "         a.NOTICE_MATERIAL,   " + 
     "         a.YEAR_AREA,   " + 
     "         a.YEAR_AREA_UNIT,   " + 
     "         a.VOLUME_RT,   " + 
     "         a.BULID_RT,   " + 
     "         a.CONST_AREA,   " + 
     "         a.CONST_AREA_UNIT,   " + 
     "         a.COMP_SIZE,   " + 
     "         a.FLOOR,   " + 
     "         a.APPROVE_COND,   " + 
     "         a.BEFORE_OPINION,   " + 
     "         a.AFTER_OPINION,   " + 
     "         a.REMARK  , a.input_name" + 
     "    FROM R_RECEIVED_CONSTRUCTION  a," + 
     "			r_code_order b," + 
     "			r_code_order c, " + 
     " 		       y_region_code d " +
     "   WHERE a.order_no = b.order_no (+)" + 
     "	  and a.order_no1 = c.order_no (+)" + 
     "     and a.region_code = d.region_code (+)  " +
     "	  and a.RECEIVE_CODE IS null " + 
     "	  and a.DATE_YEAR = " + "'" + arg_date + "'" + 
     "  order by a.date_year desc,a.no desc               ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>