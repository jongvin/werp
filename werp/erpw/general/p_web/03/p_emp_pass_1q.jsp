<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_employ_degree = req.getParameter("arg_employ_degree");
     String arg_interview_degree = req.getParameter("arg_interview_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("interview_degree",GauceDataColumn.TB_NUMBER,1));
     dSet.addDataColumn(new GauceDataColumn("appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("pass_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("last_approval",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("a_employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("a_interview_degree",GauceDataColumn.TB_NUMBER,1));
     dSet.addDataColumn(new GauceDataColumn("a_appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("appl_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("appl_part",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("appl_part2",GauceDataColumn.TB_STRING,50));
  String query = "	select distinct b.employ_degree, 							" +
	"		       b.interview_degree,                               " +
	"				 b.appl_no,                                        " +
	"				 b.pass_tag,		                                 " +
	"				 b.last_approval,	                                 " +
	"				 a.employ_degree    a_employ_degree,               " +
	"		       a.interview_degree a_interview_degree,            " +
	"				 a.appl_no 			  a_appl_no,                     " +
	"				 c.appl_name,                                       " +
	"				 c.appl_part,                                       " +
	"				 c.appl_part2                                       " +
	"		 from p_emp_inter_appl a,                                " +
	"		      p_emp_pass b,                                      " +
	"				p_emp_applicant c                                  " +
	"		where a.employ_degree    = b.employ_degree(+)            " +
	"		  and a.interview_degree = b.interview_degree(+)         " +
	"		  and	a.appl_no          = b.appl_no(+)                  " +
	"		  and a.employ_degree    = c.employ_degree               " +
	"		  and a.appl_no          = c.appl_no                     " +
	"		  and a.employ_degree    = '" + arg_employ_degree + "'   " +
	"		  and a.interview_degree = '" + arg_interview_degree + "'    " +
	"		order by c.appl_part,                                " +
	"		       c.appl_name,                               " +
	"				 b.pass_tag                                       " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>