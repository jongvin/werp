<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_grade",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_grade_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("eval_grade_spec",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("exchange_score",GauceDataColumn.TB_DECIMAL,2,1));
     dSet.addDataColumn(new GauceDataColumn("eval_grade_base",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT p_eval_mbo_item_grade.eval_grade," + 
     "             p_eval_mbo_item_grade.eval_grade_name," + 
     "             p_eval_mbo_item_grade.eval_grade_spec," + 
     "             p_eval_mbo_item_grade.exchange_score," + 
     "             p_eval_mbo_item_grade.eval_grade_base " +
     "       FROM p_eval_mbo_item_grade        " +
     "	order by p_eval_mbo_item_grade.eval_grade   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>