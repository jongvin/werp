<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("relation_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("family_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rrn_pre",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("rrn_post",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("school_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("school_year",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("division",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("school_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("school_pay_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  p_pers_school_expenses.emp_no ," + 
     "          p_pers_school_expenses.seq ," + 
     "          p_pers_school_expenses.relation_code ," + 
     "          p_pers_school_expenses.family_name ," + 
     "          p_pers_school_expenses.rrn_pre ," + 
     "          p_pers_school_expenses.rrn_post ," + 
     "          p_pers_school_expenses.school_name ," + 
     "          p_pers_school_expenses.school_year ," + 
     "          p_pers_school_expenses.division ," + 
     "          p_pers_school_expenses.school_amt ," + 
     "          p_pers_school_expenses.school_pay_date  " +
     "   FROM p_pers_school_expenses    " +
     "  where p_pers_school_expenses.emp_no = '" + arg_emp_no   + "'    " +
     " ORDER BY p_pers_school_expenses.seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>