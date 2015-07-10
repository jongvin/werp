<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL, 18, 0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_DECIMAL, 18, 0));
    String query = "select a.sum_code," + 
     "       A.dept_code, " + 
     "       A.seq, " + 
     "       A.llevel, " + 
     "       a.name name, " + 
     "       a.tag tag " + 
     "       from " + 
     "         ( SELECT  c_spec_class_parent.sum_code," + 
     "                   '       ' dept_code,   " + 
     "                   c_spec_class_parent.no_seq * 1000000  seq," + 
     "                   to_number(c_spec_class_parent.llevel) llevel, " + 
     "                   c_spec_class_parent.name, " + 
     "                   1 tag  " + 
     "             FROM c_spec_class_parent   " + 
     "          union all" + 
     "           SELECT  '                    ' sum_code," + 
     "                   c_spec_class_child.dept_code,  " + 
     "                   c_spec_class_parent.no_seq  * 1000000 + c_spec_class_child.no_seq seq,  " + 
     "                   to_number(c_spec_class_parent.llevel) + 1 llevel,  " + 
     "                   z.long_name name, " + 
     "                   2 tag " + 
     "           FROM c_spec_class_child,   " + 
     "               c_spec_class_parent,  " + 
     "               z_code_dept z  " + 
     "           WHERE ( c_spec_class_parent.spec_no_seq = c_spec_class_child.spec_no_seq ) and " + 
     "                 ( c_spec_class_child.dept_code =  z.dept_code ) and  " +
     "                 ( z.dept_code = c_spec_class_child.dept_code ) and " + 
     "                 ( z.chg_const_start_date is not null ) and " + 
     "                 ( to_char(z.chg_const_start_date,'YYYY') <= '" + arg_year + "') and   " + 
     "                 ( to_char(z.chg_const_end_date,'YYYY') >= '" + arg_year + "')   " +    
     "                 ) A " + 
     "  order by a.seq      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>