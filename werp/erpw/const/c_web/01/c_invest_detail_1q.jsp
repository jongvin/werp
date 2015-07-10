<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_code = req.getParameter("arg_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("acntcode",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code , 												" +
     "          to_char(a.yymm,'YYYY.MM.DD') yymm ,                           " +
     "          a.acntcode ,                                                  " +
     "          a.seq ,                                                       " +
     "          a.amt ,                                                       " +
     "          F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) name,  		" + 
     "          a.spec_no_seq ,                                               " +
     "          a.spec_unq_num                                                " +
     "  		FROM c_invest_detail a                                            " +
     "   WHERE a.DEPT_CODE  	 = '" + arg_dept + "'                           " +
     "     AND a.YYMM   	    = '" + arg_date  + "'                          " +
     "     AND a.acntcode      = '" + arg_code + "'                           " +
     " ORDER BY a.SPEC_NO_SEQ ASC,                                            " +
     "         a.SPEC_UNQ_NUM ASC                                             " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>