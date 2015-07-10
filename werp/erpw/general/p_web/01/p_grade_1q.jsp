<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_seq",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("use_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("retire_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("levelup_obj_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("levelup_year",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("levelup_paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("start_paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("limit_paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("minus_year",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("old_grade_code",GauceDataColumn.TB_STRING,3));
    String query = "  SELECT  p_code_grade.grade_code ," + 
     "          p_code_grade.grade_name ," + 
     "          p_code_grade.order_seq ," + 
     "          p_code_grade.use_yn ," + 
     "          p_code_grade.level_code ," + 
     "          p_code_grade.retire_rate ," + 
     "          p_code_grade.levelup_obj_yn ," + 
     "          p_code_grade.levelup_year ," + 
     "          p_code_grade.levelup_paystep ," + 
     "          p_code_grade.start_paystep ," + 
     "          p_code_grade.limit_paystep ," + 
     "          p_code_grade.minus_year ," + 
     "          p_code_grade.old_grade_code  " +
     "	  FROM p_code_grade   " +
     "	order by  grade_code    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>