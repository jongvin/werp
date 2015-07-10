<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_degree = req.getParameter("arg_degree");
     String arg_dept_seq_key = req.getParameter("arg_dept_seq_key");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("english_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_unq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("charge_emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("charge_emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_limit_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.degree,   " + 
     "         a.dept_seq_key,   " + 
     "         a.dept_code,   " + 
     "         a.no_seq,   " + 
     "         b.comp_code,   " + 
     "         c.long_name,   " + 
     "         c.short_name,   " + 
     "         c.english_name,   " + 
     "         c.dept_proj_tag,   " + 
     "         c.process_code,   " + 
     "         to_char(c.const_start_date,'yyyy.mm.dd') const_start_date,   " + 
     "         to_char(c.const_end_date,'yyyy.mm.dd')  const_end_date,  " + 
     "         to_char(c.chg_const_start_date,'yyyy.mm.dd') chg_const_start_date,   " + 
     "         to_char(c.chg_const_end_date,'yyyy.mm.dd') chg_const_end_date,  " + 
     "          c.use_tag,  " + 
     "          nvl(c.const_term,0) const_term,  " + 
     "          nvl(c.chg_const_term,0) chg_const_term,  " + 
     "          nvl(c.proj_unq_key,0) proj_unq_key,  " + 
     "          d.proj_name proj_name,  " + 
     "          a.emp_no, " + 
     "          e.emp_name, " + 
     "          a.charge_emp_no, " + 
     "          f.emp_name charge_emp_name, " + 
     "          a.dept_limit_tag  " + 
     "    FROM z_code_chg_dept_content a,   " + 
     "         z_code_chg_dept_title b ," + 
     "         z_code_dept c,  " + 
     "         p_pers_master e,  " + 
     "         p_pers_master f,  " + 
     "         (  " + 
     "              SELECT  a.proj_unq_key proj_unq_key," + 
     "                      a.step ," + 
     "                      a.proj_code ," + 
     //"                      a.dept_code ," + 	r_proj 에서 삭제된 컬럼
     "                      a.proj_name, b.business_form     FROM r_proj a, r_proj_view_business_form b   " + 
     "                 WHERE  a.proj_unq_key = b.proj_unq_key       " + 
     "                   and  a.step = b.step       " + 
     "                   and a.recive_date is not null  " + 
     "                                           ) d " + 
     "   WHERE ( a.emp_no = e.emp_no (+) ) and  " + 
     "         ( a.charge_emp_no = f.emp_no (+) ) and  " + 
     "         ( a.dept_code = c.dept_code (+) ) and  " + 
     "         ( b.degree = a.degree ) and  " + 
     "         ( b.dept_seq_key = a.dept_seq_key ) and  " + 
     "         ( d.proj_unq_key (+) = c.proj_unq_key  ) and  " + 
     "         ( ( a.degree = " + arg_degree + ") AND  " + 
     "         ( a.dept_seq_key = " + arg_dept_seq_key + " )   " + 
     "         )         "  + 
     "   order by a.no_seq " ;
%><%@ include file="../comm_function/conn_q_end.jsp"%>