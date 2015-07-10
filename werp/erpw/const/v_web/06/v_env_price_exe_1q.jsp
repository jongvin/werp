<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("env_item",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("contract_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("before_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.dept_code,																		" + 
     "                       a.seq,																				" + 
     "                       a.section,																		" + 
     "                       a.env_item,																		" + 
     "                       a.contents,																		" + 
     "                       a.contract_amt,																	" + 
     "                       a.exe_amt,																		" + 
     "                       a.before_amt,																	" + 
     "                       a.plan_amt,																		" + 
     "                       a.tot_amt        																" +
     "                  FROM v_env_amt a   																	" +
     "                 WHERE a.dept_code='" + arg_dept_code + "'										" +
     "              ORDER BY a.dept_code ASC,																" + 
     "                       a.seq ASC         																";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>