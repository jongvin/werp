<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_date = req.getParameter("arg_work_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));          
     dSet.addDataColumn(new GauceDataColumn("b_emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("b_regist_date",GauceDataColumn.TB_STRING,18));     
     dSet.addDataColumn(new GauceDataColumn("c_emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("c_user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("c_password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("c_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("c_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ins_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ret_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.emp_no," + 
     "    						  a.emp_name, " + 
     "    						  a.resident_no, " + 
     "    						  b.emp_no b_emp_no, " + 
     "    						  to_char(b.regist_date,'yyyy.mm.dd') b_regist_date, " + 
     "    						  c.empno c_emp_no, " + 
     "    						  c.user_id c_user_id, " + 
     "    						  c.password c_password, " + 
     "    						  c.name c_name, " + 
     "    						  c.dept_code c_dept_code, " + 
     "							  'Y' ins_tag, " +
     "							  'Y' ret_tag " +
     "                 FROM p_pers_master     a,   " +
     "							 p_pers_last_empno b,   " +
     "							 z_authority_user  c		" +
     "					 where a.emp_no = b.emp_no    " +
     "						and a.emp_no = c.empno(+)  " +
     "						and substr(a.emp_no,1,6) = '" + arg_work_date + "' " +
     "	order by a.emp_no ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>