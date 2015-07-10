<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_bigo1",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("cnt_bigo2",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("cnt_bigo3",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt_bigo",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("wbs_progress_month",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("wbs_progress_next",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("safety_month",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("safety_next",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("q_month",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("q_next",GauceDataColumn.TB_STRING,1000));
     dSet.addDataColumn(new GauceDataColumn("problem_bigo",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("opinion_bigo",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("decision_bigo",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("delay_int",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_date",GauceDataColumn.TB_STRING,20));
    String query = "SELECT a.dept_code, " +
     "                     to_char(a.yymm, 'yyyy.mm.dd') yymm,   " +
     "                     a.cnt_bigo1,   " +
     "                     a.cnt_bigo2,   " +
     "                     a.cnt_bigo3,   " +
     "                     a.cnt_amt_bigo,   " +
     "                     a.wbs_progress_month,   " +
     "                     a.wbs_progress_next,   " +
     "                     a.safety_month,   " +
     "                     a.safety_next,   " +
     "                     a.q_month,   " +
     "                     a.q_next,   " +
     "                     a.problem_bigo,   " +
     "                     a.opinion_bigo,   " +
     "                     a.decision_bigo,  " +
     "                     a.delay_int,	" +
     "                     a.delay_date	" +
     "                FROM c_spec_const_input a " +
     "               WHERE a.dept_code = '" + arg_dept_code + "' and  " +
     "                     a.yymm = '" + arg_yymm + "' " +
	  "                ORDER BY a.dept_code ASC,   " +
     "                         a.yymm ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>