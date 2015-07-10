<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_eval_degree = req.getParameter("arg_eval_degree");
     String arg_self_evaluator = req.getParameter("arg_self_evaluator");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("base_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_base_grade",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("fir_comment",GauceDataColumn.TB_STRING,400));
     dSet.addDataColumn(new GauceDataColumn("b_base_code",GauceDataColumn.TB_STRING,2));     
    String query = "  SELECT  a.eval_code ," + 
     " 				         	a.eval_degree ," + 
     " 				         	a.self_evaluator ," + 
     " 				         	a.base_code ," + 
     " 				         	a.fir_base_grade ," + 
     " 				         	a.fir_comment,   " +
     "                       	b.base_code				b_base_code    " + 
     " 						 FROM p_eval_world_fir   a,  " +
     " 						      p_eval_base        b " + 
     " 						where a.eval_code(+)   = b.eval_code " + 
     "            		  and a.eval_degree(+) = b.eval_degree " + 
     "						  and a.base_code(+)   = b.base_code " +
     "	         		  and b.eval_code 	  = '" + arg_eval_code + "'  " +
     " 						  and b.eval_degree    = '" + arg_eval_degree + "' " + 
     " 						  and a.self_evaluator(+) = '" + arg_self_evaluator + "'  " +
     " order by a.base_code   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>