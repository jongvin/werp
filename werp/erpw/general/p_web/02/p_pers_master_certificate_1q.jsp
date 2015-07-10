<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("certificate_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("certificate_no",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("submit_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("address",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cer_grade",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("quantity",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("purpose",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("company_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("requestor_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  p_pers_certificate.certificate_div ," + 
     "          p_pers_certificate.work_year ," + 
     "          p_pers_certificate.seq ," + 
     "          p_pers_certificate.certificate_no ," + 
     "          p_pers_certificate.submit_date ," + 
     "          p_pers_certificate.address ," + 
     "          p_pers_certificate.emp_no ," + 
     "          p_pers_certificate.s_date ," + 
     "          p_pers_certificate.e_date ," + 
     "          p_pers_certificate.cer_grade ," + 
     "          p_pers_certificate.quantity ," + 
     "          p_pers_certificate.purpose ," + 
     "          p_pers_certificate.remark ," + 
     "          p_pers_certificate.company_code ," + 
     "          p_pers_certificate.requestor_name     FROM p_pers_certificate        " +
     "   where p_pers_certificate.emp_no = '" + arg_emp_no   + "'    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>