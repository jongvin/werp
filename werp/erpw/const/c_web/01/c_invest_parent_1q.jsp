<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("acntname",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("process_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.dept_code ,                             	" +
     "          to_char(a.yymm,'YYYY.MM.DD') yymm ,     			            " +
     "          a.acntcode ,                                               " +
     "          a.acntname ,                                               " +
     "          a.amt ,                                                    " +
     "          a.process_yn                                               " +
     "       FROM c_invest_parent a                                        " +
     "   WHERE a.DEPT_CODE  	 = '" + arg_dept + "'                        " +
     "     AND a.YYMM   	    = '" + arg_date  + "'                       " +
     " ORDER BY a.acntcode ASC                                             " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>