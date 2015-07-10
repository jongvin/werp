<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_approve = req.getParameter("arg_approve");
     String arg_order = req.getParameter("arg_order");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("certificate_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("submit_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("certificate_no",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("approve_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("address",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("quantity",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("purpose",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("requestor_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approve_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approve_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("req_date",GauceDataColumn.TB_STRING,18));          
     dSet.addDataColumn(new GauceDataColumn("write_date",GauceDataColumn.TB_STRING,18));          
     dSet.addDataColumn(new GauceDataColumn("print_date",GauceDataColumn.TB_STRING,18));          
    String query = "  SELECT  a.emp_no ," + 
     "          b.emp_name, " +
     "          a.spec_no_seq ," + 
     "          a.certificate_div ," + 
     "          to_char(a.submit_year,'yyyy.mm.dd') submit_year," + 
     "          a.certificate_no ," + 
     "          to_char(a.approve_date,'yyyy.mm.dd') approve_date," + 
     "          a.address ," + 
     "          a.comp_code ," + 
     "          a.dept_code ," + 
     "          a.grade_code ," + 
     "          c.comp_name ," + 
     "          d.long_name dept_name ," + 
     "          e.grade_name ," + 
     "          to_char(a.s_date,'yyyy.mm.dd') s_date ," + 
     "          to_char(a.e_date,'yyyy.mm.dd') e_date ," + 
     "          a.quantity ," + 
     "          a.purpose ," + 
     "          a.remark ," + 
     "          a.requestor_name ," + 
     "          a.approve_div ," + 
     "          a.approve_yn, " +
     "			 to_char(a.req_date,'yyyy.mm.dd')  req_date,  " +
     "			 to_char(a.write_date,'yyyy.mm.dd')  write_date,  " +
     "			 to_char(a.print_date,'yyyy.mm.dd')  print_date  " +
     "	  FROM p_pers_certificate    a, " +
     "			 p_pers_master			  b,  " +
     "			 z_code_comp			  c,  " +
     "			 z_code_dept			  d,  " +
     "			 p_code_grade			  e  " +
     "	 where a.emp_no  =  b.emp_no " +
     "		and a.comp_code  =  c.comp_code(+) " +
     "		and a.dept_code  =  d.dept_code(+) " +
     "		and a.grade_code  =  e.grade_code(+) " +
     "        " + arg_approve + "  " + 
     "       ORDER BY " + arg_order + "         DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>