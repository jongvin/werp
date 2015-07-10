<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_eval_degree = req.getParameter("arg_eval_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("base_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("section_item",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("detail_item",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          a.spec_no_seq ," + 
     "          a.base_code ," + 
     "          a.seq ," + 
     "          a.section_item ," + 
     "          a.detail_item   " +
     "	  FROM p_eval_base_item    a   " +
     "    where a.eval_code = '" + arg_eval_code + "' " +
     "      and a.eval_degree = '" + arg_eval_degree + "' " +
     "	order by a.section_item, a.base_code, a.seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>