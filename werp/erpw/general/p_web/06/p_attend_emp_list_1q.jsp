<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,30));     
    String query = "    select a.resident_no ,	    		" +
						 "	          a.emp_name ,         		" +
						 "	          b.short_name dept_name ,  " +
						 "	          c.grade_name         		" +
						 "		  from p_pers_master a,      		" +
						 "		       z_code_dept   b,      		" +
						 "		       p_code_grade   c      		" +
						 "		 where a.dept_code = b.dept_code(+) " +
						 "		   and a.grade_code = c.grade_code(+) " +
						 "       and a.service_div_code = '2'  " +
						 "       and a.att_exc_yn <> 'T'  " +
						 "	 order by a.emp_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>