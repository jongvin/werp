<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_mssql_portal_q.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 	  String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,4,0));
     dSet.addDataColumn(new GauceDataColumn("relation",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("code2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,40));
    String query = "SELECT a.resident_no, 																	" +
						 "			0 spec_no_seq,																		" +
						 "			a.seq,                                                            " +
						 "			a.relation,                                                    	" +
						 "			b.code2,                                                          " +
						 "			a.name                                                           	" +
						 "		  from recruit_resume_family a left outer join recruit_code_table b  " +
						 "		    on b.code_group = 'F_RELATION'                                  " +
						 "		  and a.relation =  b.code                                        " +
						 "		 where a.resident_no = '"+ arg_resident_no +"' " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>