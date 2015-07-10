<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_bus_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("proj_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("hos_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("gen_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("work_mm",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("plan_yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("plan_mm",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("reset_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  to_char(a.work_year,'yyyy.mm.dd') work_year ," + 
				       "          a.proj_bus_type ," + 
				       "          a.spec_no_seq ," + 
				       "          a.proj_name ," + 
				       "          a.hos_cnt, " +
				       "          a.gen_cnt, " +
				       "          to_char(a.work_yymm,'yyyy.mm.dd') work_yymm ," + 
				       "          to_char(a.work_yymm,'mm') work_mm ," + 
				       "          to_char(a.plan_yymm,'yyyy.mm.dd') plan_yymm, " +
				       "          to_char(a.plan_yymm,'mm') plan_mm, " +
				       "          a.remark, " +
				       "				'Y' reset_tag " +
				       "     FROM g_mis_sale_plan    a " + 
				       "    where to_char(a.work_year,'yyyy') = to_char(to_date('" + arg_work_year + "'),'yyyy') " +
				       " order by a.proj_bus_type asc ," + 
				       "          a.work_yymm     asc  ," + 
				       "          a.proj_name 	 asc	" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>