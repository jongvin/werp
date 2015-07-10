<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_degree = req.getParameter("arg_degree");
     String arg_class = req.getParameter("arg_class");
     String arg_dept = req.getParameter("arg_dept");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("evl_year",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("evl_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("evl_f_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("evl_t_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("from_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("to_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("evl_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("evl_desc1",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("evl_desc2",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("plan_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cmp_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
    String query = "  SELECT  a.evl_year ," + 
     					 "          a.degree ," + 
     					 "          a.evl_class ," + 
     					 "          a.dept_code ," + 
     					 "          a.long_name ," + 
     					 "          to_char(b.evl_f_date,'YYYY.MM.DD')  evl_f_date, " +
     					 "          to_char(b.evl_t_date,'YYYY.MM.DD')  evl_t_date, " +
     					 "          to_char(b.from_date, 'YYYY.MM.DD')  from_date, " +
     					 "          to_char(b.to_date,   'YYYY.MM.DD')  to_date  , " +
     					 "          c.order_number, " +
     					 "          c.sbc_name, " +
     					 "          c.sbcr_name, " +
     					 "          c.profession_wbs_code, " +
     					 "          c.profession_wbs_name, " +
     					 "          c.evl_name, " +
     					 "          c.name2, " +
     					 "          c.evl_desc1, " +
     					 "          c.evl_desc2, " +
     					 "          d.sbc_amt, " +
     					 "          to_char(d.plan_start_dt,'YYYY.MM.DD') plan_start_dt, " +
     					 "          to_char(d.plan_end_dt,'YYYY.MM.DD') plan_end_dt, " +
     					 "          e.tm_prgs, " +
     					 "          decode(d.sbc_amt,0,0,(e.tm_prgs / d.sbc_amt) * 100) cmp_prgs_rt " +
     					 "     FROM s_evl_evldept a ," +
     					 "          s_evl_evlplan b, " +
     					 "          s_evl_proj_evlsbcr c, " +
     					 "          s_cn_list d, " +
     					 "         ( select nvl(sum(tm_prgs),0) + nvl(sum(tm_prgs_notax),0) + nvl(sum(tm_purchase_vat),0) + nvl(sum(tm_vat),0) tm_prgs " + 
     					 "             from s_pay " +
     					 "            where dept_code = '" + arg_dept + "'" +
     					 "              and order_number = " + arg_order_number + ") e" +
     					 "    WHERE c.evl_year  = a.evl_year " +
     					 "      and c.degree    = a.degree " +
     					 "      and c.evl_class = a.evl_class " +
     					 "      and c.dept_code = a.dept_code " +
     					 "      and c.evl_year  = b.evl_year " +
     					 "      and c.degree    = b.degree " +
     					 "      and c.evl_class = b.evl_class " +
     					 "      and c.dept_code = d.dept_code " +
     					 "      and c.order_number = d.order_number " +
     					 "      and c.EVL_YEAR = '" + arg_year + "'" +
     					 "      and c.DEGREE = " + arg_degree +
     					 "      and c.EVL_CLASS = '" + arg_class + "'" +
     					 "      and c.dept_code = '" + arg_dept + "'" +
     					 "      and c.order_number = " + arg_order_number +
     					 " ORDER BY a.dept_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>