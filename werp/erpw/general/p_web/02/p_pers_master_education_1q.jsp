<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_part",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_part_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("edu_office",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_office_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("edu_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("edu_day",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("edu_place",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_comment",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("finish_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("result",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("receipt_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.emp_no ," + 
     "          a.edu_code ," + 
     "          to_char(a.edu_year,'yyyy') edu_year," + 
     "          a.edu_degree ," + 
     "          a.spec_no_seq ," + 
     "          a.edu_name ," + 
     "          a.edu_part ," + 
     "          b.edu_part_name ," + 
     "          a.edu_office ," + 
     "          c.edu_office_name ," + 
     "          to_char(a.edu_start_date,'yyyy.mm.dd') edu_start_date ," + 
     "          to_char(a.edu_end_date  ,'yyyy.mm.dd') edu_end_date," + 
     "          a.edu_day ," + 
     "          a.edu_time ," + 
     "          a.edu_place ," + 
     "          a.edu_comment ," + 
     "          a.remark, " + 
     "          a.finish_tag, " + 
     "          a.result, " + 
     "          a.receipt_tag " + 
     "      FROM p_edu_emp   			a,    " +
     "			  p_code_edu_part    b,    " +
     "			  p_code_edu_office  c    " +
     "     where a.edu_part    = b.edu_part_code  (+)" +
     "		 and a.edu_office  = c.edu_office_code(+)  " +
     "		 and a.emp_no = '" + arg_emp_no + "'    " +
     "  order by a.edu_year, a.edu_name  " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>