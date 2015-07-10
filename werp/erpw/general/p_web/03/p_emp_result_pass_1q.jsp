<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_employ_degree = req.getParameter("arg_employ_degree");     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("interview_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("appl_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pass_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("last_approval",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("appl_part",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("appl_part2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sex",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("b_employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("b_appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("b_emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("b_user_id",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("b_last_pass_tag",GauceDataColumn.TB_STRING,1));     
    String query = "  SELECT  a.employ_degree ," + 
     "          a.interview_degree ," + 
     "          a.appl_no ," + 
     "          a.pass_tag ," + 
     "          a.appl_no ," + 
     "          b.appl_name ," + 
     "          b.sex,   " +
     "          b.appl_part ," + 
     "          b.appl_part2 ," + 
     "          a.last_approval,   " +
     "          b.employ_degree	b_employ_degree,   " +
     "          b.appl_no	b_appl_no,   " +
     "          b.emp_no	b_emp_no,   " +
     "          b.user_id 	b_user_id,  " +
     "          b.last_pass_tag	b_last_pass_tag   " +
     "  FROM p_emp_pass a, p_emp_applicant b,  " +
     "       ( select max(interview_degree) interview_degree    		" +
     "			  from p_emp_inter_degree								 		" +
     "			 where employ_degree = '" + arg_employ_degree + "'		" +
     "			) c	" +     
     " where a.employ_degree = b.employ_degree " +
     "   and a.appl_no = b.appl_no " +
     "   and a.interview_degree = c.interview_degree " +
     "   and a.employ_degree = '" + arg_employ_degree + "' " +
     "   and a.pass_tag = 'T'        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%> 