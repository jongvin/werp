<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("welfare_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("welfare_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("welfare_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("welfare_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT a.emp_no," + 
     "             a.spec_no_seq," + 
     "             a.seq," + 
     "             to_char(a.welfare_date,'yyyy.mm.dd') welfare_date," + 
     "          a.comp_code," + 
     "    			c.comp_name," + 
     "          a.dept_code," + 
     "          d.long_name dept_name," + 
     "             a.grade_code," + 
     "             e.grade_name," + 
     "             a.welfare_code," + 
     "            b.welfare_name," + 
     "            a.welfare_amt," + 
     "             a.remark        FROM p_gen_welfare   a," + 
     " 			p_code_welfare  b," + 
     " 			z_code_comp     c," + 
     " 			z_code_dept     d," + 
     " 			p_code_grade    e  " +
     "   where a.welfare_code = b.welfare_code(+)   " +
     "    and a.comp_code = c.comp_code(+)    " +
     "    and a.dept_code = d.dept_code(+)    " +
     "    and a.grade_code = e.grade_code(+)  " +
     "    and a.emp_no     = '" + arg_emp_no   + "'    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>