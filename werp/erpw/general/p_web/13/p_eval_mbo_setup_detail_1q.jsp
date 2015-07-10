<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_year = req.getParameter("arg_eval_year");
     String arg_self_evaluator = req.getParameter("arg_self_evaluator");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("section_item",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("important_service",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("detail_service",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("result_index",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("measure_base",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("object_value",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("specific_gravity",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("attain_time",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.eval_code ," + 
     "          to_char(a.eval_year,'yyyy.mm.dd') eval_year ," + 
     "          a.self_evaluator ," + 
     "          a.spec_no_seq ," + 
     "          a.seq ," + 
     "          a.section_item ," + 
     "          a.important_service ," + 
     "          a.detail_service ," + 
     "          a.result_index ," + 
     "          a.measure_base ," + 
     "          a.object_value ," + 
     "          a.specific_gravity ," + 
     "          a.attain_time   " +
     "	  FROM p_eval_mbo_setup_detail a       " +
     "	 where a.eval_code = '01'  " +
     "		and to_char(a.eval_year,'yyyy') = to_char(to_date('" + arg_eval_year + "'),'yyyy') " +
     "		and self_evaluator = '" + arg_self_evaluator + "'  " +
     " order by a.section_item, a.seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>