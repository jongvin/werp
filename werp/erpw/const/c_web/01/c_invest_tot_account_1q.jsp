<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("gl_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("acct_code",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("acct_desc",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("je_description",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("accounted_net",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code ,                            				" +		
     "          a.gl_date,                         " +
     "          a.acct_code ,                                                    " +
     "          a.acct_desc ,                                                    " +
     "          a.je_description ,                                                    " +
     "          NVL(a.accounted_net,0) accounted_net " + 
     "     from (                                                 " +
     "           SELECT  a.dept_code ,                            				" +		
     "                  to_char(a.gl_date,'YYYY.MM.DD') gl_date,                       " +
     "                   0 seq, " + 
     "                   a.acct_code ,                                                    " +
     "                   a.acct_desc ,                                                    " +
     "                   a.je_description ,                                                    " +
     "                   NVL(a.accounted_net,0) accounted_net " + 
     "                FROM efin_cost_accounts_v  a                                     " +
     "            WHERE a.DEPT_CODE  	 = '" + arg_dept + "'                              " + 
     "              and a.acct_code <> '743411' " ; 
     if ( arg_date.equals("2005.05.01") ) {
     	   query = query + "  AND to_char(a.gl_date,'yyyy.mm') || '.01'   = '1900.01.01'    ";
     }
     else  {   
     	   query = query + "   AND to_char(a.gl_date,'yyyy.mm') || '.01'   = '" + arg_date  + "'      ";

     }
     query = query + " " + 
     "        union all  " + 
     "          SELECT  a.dept_code ,                            				" +		
     "                  to_char(a.gl_date,'YYYY.MM.DD') gl_date,                         " +
     "                  NVL(a.seq,0),  " + 
     "                  a.acct_code ,                                                    " +
     "                  a.acct_desc ,                                                    " +
     "                  a.je_description ,                                                    " +
     "                  NVL(a.accounted_net,0)                         " +
     "                FROM c_invest_200505  a                                     " +
     "            WHERE a.DEPT_CODE  	 = '" + arg_dept + "'                              " +
     "              AND to_char(a.gl_date,'yyyy.mm') || '.01'   = '" + arg_date  + "'      " +
     "        union all " + 
     "            SELECT  a.dept_code ,                            				" +		
     "                    to_char(a.gl_date,'YYYY.MM.DD') gl_date,                         " +
     "                    NVL(a.invest_unq_num,0),  " + 
     "                    a.acct_code ,                                                    " +
     "                    a.acct_desc ,                                                    " +
     "                    a.je_description ,                                                    " +
     "                    NVL(a.accounted_net,0)                                                   " +
     "                 FROM c_invest_vat  a                                     " +
     "             WHERE a.DEPT_CODE  	 = '" + arg_dept + "'                              " +
     "               AND to_char(a.gl_date,'yyyy.mm') || '.01'   = '" + arg_date  + "'      " +
     "             ) a " + 
     " ORDER BY a.acct_code,a.gl_date,a.seq ASC         " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>    