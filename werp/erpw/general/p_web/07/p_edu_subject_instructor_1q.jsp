<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";
     String arg_edu_code = req.getParameter("arg_edu_code") + "%" ;
     String arg_subject = "%" + req.getParameter("arg_subject") + "%" ;
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("inst_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("inst_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("io_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("subject",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,18));     
    String query = "  select a.inst_no,                                 " +
				"			 c.inst_name,                                      " +
				"			 c.io_tag,                                         " +
				"			 c.comp_code,                                      " +
				"			 c.dept_code,                                      " +
				"			 c.grade_code,                                     " +
				"			 d.comp_name,                                      " +
				"			 e.long_name dept_name,                            " +
				"			 f.grade_name,                                     " +
				"			 a.subject,                                        " +
				"			 to_char(a.edu_year,'yyyy') edu_year,              " +
				"			 to_char(g.start_date,'yyyy.mm.dd') start_date,    " +
				"			 to_char(g.end_date,'yyyy.mm.dd') end_date         " +
				"	  from p_edu_subject a,                                  " +
				"	       p_edu_curriculum b,                               " +
				"			 p_edu_instructor c,                               " +
				"			 z_code_comp d,                                    " +
				"			 z_code_dept e,                                    " +
				"			 p_code_grade f,                                   " +
				"			 p_edu_degree g                                    " +
				"	 where a.edu_code = b.edu_code                           " +
				"	   and a.edu_year = c.edu_year                           " +
				"		and a.inst_no  = c.inst_no                            " +
				"		and a.edu_code  = g.edu_code                          " +
				"		and a.edu_year  = g.edu_year                          " +
				"		and a.edu_degree  = g.edu_degree                      " +
				"		and c.comp_code = d.comp_code(+)                      " +
				"		and c.dept_code = e.dept_code(+)                      " +
				"		and c.grade_code = f.grade_code(+)                    " +
				"	   and c.comp_code like '" + arg_comp_code + "'          " +
				"		and a.edu_code like '" + arg_edu_code  + "'              " +
				"		and a.subject like '" + arg_subject + "'              " +
				" order by c.io_tag, a.inst_no " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>