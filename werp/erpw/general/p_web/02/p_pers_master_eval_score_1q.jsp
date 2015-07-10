<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("eval_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("upper_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("latter_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("total_score",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  p_pers_eval_score.emp_no ," + 
     "          p_pers_eval_score.eval_year ," + 
     "          p_pers_eval_score.upper_score ," + 
     "          p_pers_eval_score.latter_score ," + 
     "          p_pers_eval_score.total_score ," + 
     "          p_pers_eval_score.remark     FROM p_pers_eval_score        " +
     "   where p_pers_eval_score.emp_no = '" + arg_emp_no   + "'    " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>