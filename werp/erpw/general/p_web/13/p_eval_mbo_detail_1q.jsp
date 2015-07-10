<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_degree = req.getParameter("arg_eval_degree");
     String arg_self_evaluator = req.getParameter("arg_self_evaluator");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("self_attain_level",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("self_eval_view",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("self_eval_grade",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("self_eval_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("fir_eval_view",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("fir_eval_grade",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_eval_score",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("b_eval_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("b_self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("b_spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_section_item",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("b_important_service",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("b_detail_service",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("b_result_index",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_measure_base",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_object_value",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("b_specific_gravity",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_attain_time",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT a.eval_code,   " + 
     "         to_char(a.eval_year,'yyyy.mm.dd') eval_year,   " + 
     "         a.eval_degree,   " + 
     "         a.self_evaluator,   " + 
     "         a.spec_no_seq,   " + 
     "         a.self_attain_level,   " + 
     "         a.self_eval_view,   " + 
     "         a.self_eval_grade,   " + 
     "         a.self_eval_score,   " + 
     "         a.fir_eval_view,   " + 
     "         a.fir_eval_grade,   " + 
     "         a.fir_eval_score,   " + 
     "         b.eval_code				b_eval_code,   " + 
     "         b.eval_year				b_eval_year,   " + 
     "         b.self_evaluator		b_self_evaluator,   " + 
     "         b.spec_no_seq			b_spec_no_seq,   " + 
     "         b.seq						b_seq,   " + 
     "         b.section_item			b_section_item,   " + 
     "         b.important_service	b_important_service,   " + 
     "         b.detail_service		b_detail_service,   " + 
     "         b.result_index			b_result_index,   " + 
     "         b.measure_base			b_measure_base,   " + 
     "         b.object_value			b_object_value,   " + 
     "         b.specific_gravity	b_specific_gravity,   " + 
     "         b.attain_time  		b_attain_time" + 
     "    FROM p_eval_mbo_detail			a,   " + 
     "         p_eval_mbo_setup_detail b, " + 
     "         p_eval_mbo_setup_list   c " + 
     "   WHERE a.eval_code(+) = b.eval_code" + 
     "     and a.eval_year(+) = b.eval_year" + 
     "     and a.self_evaluator(+) = b.self_evaluator" + 
     "     and a.spec_no_seq(+)  = b.spec_no_seq" + 
     "     and c.eval_code 		= b.eval_code" + 
     "     and c.eval_year 		= b.eval_year" + 
     "     and c.self_evaluator  = b.self_evaluator" + 
     "     and b.eval_code   = '01'" + 
     "     and to_char(b.eval_year,'yyyy') = substr('" + arg_eval_degree + "',1,4)" + 
     "     and a.eval_degree(+) = '" + arg_eval_degree + "' " + 
     "     and b.self_evaluator = '" + arg_self_evaluator + "'  " +
     "     and c.fir_agree_yn   = 'Y'  " +
     " order by  b.section_item, b.seq  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>