<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_degree = req.getParameter("arg_eval_degree");
     String arg_self_evaluator = req.getParameter("arg_self_evaluator");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("self_eval_score",GauceDataColumn.TB_DECIMAL,1,0));
     dSet.addDataColumn(new GauceDataColumn("b_eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("b_eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("b_spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_base_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("b_section_item",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("b_detail_item",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT a.eval_code,   " + 
     "                       a.eval_degree,   " + 
     "                       a.self_evaluator,   " + 
     "                       a.spec_no_seq,   " + 
     "                       a.self_eval_score,   " + 
     "                       b.eval_code				b_eval_code,    " + 
     "                       b.eval_degree			b_eval_degree,  " + 
     "                       b.spec_no_seq			b_spec_no_seq,  " + 
     "                       b.seq						b_seq,   		 " + 
     "                       b.base_code				b_base_code,    " + 
     "                       b.section_item			b_section_item, " + 
     "                       b.detail_item			b_detail_item   " + 
     "                  FROM p_eval_world_detail		a,   " + 
     "                       p_eval_base_item 			b " + 
     "                 WHERE a.eval_code(+)   = b.eval_code " + 
     "                   and a.eval_degree(+) = b.eval_degree " + 
     "                   and a.spec_no_seq(+) = b.spec_no_seq " + 
     "	                and b.eval_code 	  = '03'  " +
     "                   and b.eval_degree    = '" + arg_eval_degree + "' " + 
     "                   and a.self_evaluator(+) = '" + arg_self_evaluator + "'  " +
     " order by b.base_code, b.seq   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>