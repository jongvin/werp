<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 		String arg_eval_code = req.getParameter("arg_eval_code");
     	String arg_eval_degree = req.getParameter("arg_eval_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("eval_name",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          b.eval_name " + 
     "		FROM p_eval_degree   a,  " +
     "		     p_eval_code     b  " +
     "	  where a.eval_code  = b.eval_code " +
     "		 and a.eval_code  <> '01' " + 
  	  "       and not exists (select * from p_eval_degree b " +
	  "							 where a.eval_code = b.eval_code " +
	  "							   and a.eval_degree = b.eval_degree " +
	  "						      and b.eval_code = '" + arg_eval_code + "' " +
	  "    						   and b.eval_degree = '" + arg_eval_degree + "' ) " +
     " order by a.eval_code, a.eval_degree ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>