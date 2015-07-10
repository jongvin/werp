<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_mssql_portal_q.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 	  String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,4,0));
     dSet.addDataColumn(new GauceDataColumn("co_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("depart",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("jikwi",GauceDataColumn.TB_STRING,20));
    String query = "SELECT a.resident_no, 									" +
						 "			0 spec_no_seq,										" +
						 "			a.seq,                                    " +
						 "			a.co_name,                                " +
						 "			a.depart,                                 " +
						 "			a.jikwi                                   " +
						 "		  from recruit_resume_career a               " +
						 "		 where a.resident_no = '"+ arg_resident_no +"' " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>