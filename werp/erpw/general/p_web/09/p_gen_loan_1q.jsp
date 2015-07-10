<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_repay_yn = req.getParameter("arg_repay_yn") + "%";
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("loan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("last_repay_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("loan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("loan_rem",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("interest",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("repay_method",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("repay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("surety",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  " + 
     "          a.comp_code ," + 
     "          a.emp_no ," + 
     "          b.emp_name ," + 
     "          a.spec_no_seq ," + 
     "          to_char(a.loan_date,'YYYY.MM.DD') loan_date ," + 
     "          a.dept_code ," + 
     "          c.long_name dept_name ," + 
     "          a.grade_code ," + 
     "          d.grade_name ," + 
     "          to_char(a.last_repay_date,'YYYY.MM.DD') last_repay_date ," + 
     "          a.loan_amt ," + 
     "          a.loan_rem ," + 
     "          a.interest ," + 
     "          a.repay_method ," + 
     "          a.repay_yn ," + 
     "          a.surety ," + 
     "          a.remark     FROM p_gen_loan a, p_pers_master b, z_code_dept c, p_code_grade d       " +
     "   where a.emp_no = b.emp_no  " + 
     "     and a.dept_code = c.dept_code(+) " +
     "     and a.grade_code = d.grade_code(+) " +
     "     and trunc(a.loan_date, 'year') = '" + arg_date + "'    " + 
     "     and a.repay_yn like '" + arg_repay_yn + "' " +
     "     and a.comp_code like '" + arg_comp_code + "' " +
     "	ORDER BY a.loan_date, b.emp_name          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>