<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_employ_degree = req.getParameter("arg_employ_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("last_pass_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("appl_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,0));
     dSet.addDataColumn(new GauceDataColumn("b_emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("b_regist_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("c_emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("c_resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("c_emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("d_emp_no",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("d_user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("d_password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("d_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("d_dept_code",GauceDataColumn.TB_STRING,7));
    String query = "select a.last_pass_tag," + 
     "		 a.appl_no," + 
     "		 a.appl_name," + 
     "		 a.emp_no," + 
     "		 a.user_id," + 
     "		 '' tag," + 
     "		 b.emp_no 	b_emp_no," + 
     "		 to_char(b.regist_date,'yyyy.mm.dd') b_regist_date," + 
     "		 c.emp_no 	c_emp_no," + 
     "		 c.resident_no 	c_resident_no," + 
     "		 c.emp_name c_emp_name," + 
     "		 d.empno   	d_emp_no," + 
     "		 d.user_id  d_user_id," + 
     "		 d.password d_password," + 
     "		 d.name     d_name," + 
     "		 d.dept_code d_dept_code" + 
     "  from p_emp_applicant  a," + 
     "  		 p_pers_last_empno b," + 
     "		 p_pers_master		 c," + 
     "		 z_authority_user	 d" + 
     " where a.emp_no = b.emp_no(+)" + 
     "   and a.emp_no = c.emp_no(+)" + 
     "	and a.emp_no = d.empno(+) " + 
     "   and a.employ_degree = '" + arg_employ_degree + "'  " +
     "	and a.last_pass_tag = 'T'    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>