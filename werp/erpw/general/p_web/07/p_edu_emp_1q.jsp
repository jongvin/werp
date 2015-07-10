<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_edu_year = req.getParameter("arg_edu_year");
     String arg_edu_code = req.getParameter("arg_edu_code");
     String arg_edu_degree = req.getParameter("arg_edu_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("out_edu_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_part",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_office",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_day",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_place",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_comment",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("finish_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("result",GauceDataColumn.TB_DECIMAL,5,2));
    String query = "  SELECT  a.emp_no ," + 
     "          b.emp_name ," + 
     "          a.edu_code ," + 
     "          to_char(a.edu_year,'yyyy.mm.dd') edu_year," + 
     "          a.edu_degree ," + 
     "          a.spec_no_seq ," + 
     "          a.comp_code ," + 
     "          c.comp_name ," + 
     "          a.dept_code ," + 
     "          d.long_name dept_name ," + 
     "          a.grade_code ," + 
     "          e.grade_name ," + 
     "          a.edu_name out_edu_name ," + 
     "          a.edu_part ," + 
     "          a.edu_office ," + 
     "          to_char(a.edu_start_date,'yyyy.mm.dd') edu_start_date ," + 
     "          to_char(a.edu_end_date  ,'yyyy.mm.dd') edu_end_date," + 
     "          a.edu_day ," + 
     "          a.edu_time ," + 
     "          a.edu_place ," + 
     "          a.edu_comment ," + 
     "          a.remark, " + 
     "          a.finish_tag, " + 
     "          a.result " + 
     "      FROM p_edu_emp   			a,    " +
     "           p_pers_master		b,    " +
     "           z_code_comp			c,    " +
     "           z_code_dept			d,    " +
     "           p_code_grade			e    " +
     " where a.emp_no  =  b.emp_no " +
     "	and a.comp_code   =  c.comp_code(+) " +
     "	and a.dept_code   =  d.dept_code(+) " +
     "	and a.grade_code  =  e.grade_code(+) " +
     "	and a.receipt_tag =  'T' " +
     "	and a.edu_year    = '" + arg_edu_year + "' " +
     "	and a.edu_code    = '" + arg_edu_code + "' " +
     "	and a.edu_degree  = '" + arg_edu_degree + "' " +
     " order by a.comp_code, a.dept_code, a.grade_code, b.emp_name " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>