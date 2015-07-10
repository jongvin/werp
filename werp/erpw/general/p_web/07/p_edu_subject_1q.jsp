<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_edu_year = req.getParameter("arg_edu_year");
     String arg_edu_code = req.getParameter("arg_edu_code");
     String arg_edu_degree = req.getParameter("arg_edu_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("subject",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("inst_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("inst_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT to_char(a.edu_year, 'YYYY.MM.DD') edu_year,	" +
     "         a.edu_code ,									  " +
     "		   a.edu_degree,                            " +
     "         a.spec_no_seq ,									  " +
     "         a.no_seq ,									  " +
     "         a.subject ,                     " +
	  "         a.inst_no,                                " +
     "         b.inst_name                               " +
     "    FROM p_edu_subject a,                         " +
     "         p_edu_instructor b                          " +
     "  where a.inst_no 	 = b.inst_no (+)           " +
     "    and a.edu_year = '" + arg_edu_year + "' " +
     "    and a.edu_code = '" + arg_edu_code + "' " +
     "    and a.edu_degree = '" + arg_edu_degree + "' " +
     " order by a.no_seq " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>