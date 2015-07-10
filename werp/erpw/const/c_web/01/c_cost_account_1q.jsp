<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_code = req.getParameter("arg_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("gl_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("acct_code",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("acct_desc",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("je_description",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("accounted_net",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code ,                            				" +		
     "          to_char(a.gl_date,'YYYY.MM.DD') gl_date,                         " +
     "          a.acct_code ,                                                    " +
     "          a.acct_desc ,                                                    " +
     "          a.je_description ,                                                    " +
     "          a.accounted_net                                                  " +
     "       FROM efin_cost_accounts_v  a                                     " +
     "   WHERE a.DEPT_CODE  	 = '" + arg_dept + "'                              " +
     "     AND to_char(a.gl_date,'yyyy.mm') || '.01'   = '" + arg_date  + "'      " +
     "     AND a.acct_code   	 = '" + arg_code  + "'                             " +
     " ORDER BY a.gl_date ASC                                                    " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>    