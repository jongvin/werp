<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_comp = req.getParameter("arg_comp");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("bonsa_close",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.dept_code ,								  " +	 
     "          					a.long_name ,                         " +
     "          					b.process_code,                       " +
     "          					nvl(c.bonsa_close,'N') bonsa_close    " +
     "        				FROM f_code_dept a, z_code_dept b, c_spec_const_closing c" +
     "                where a.dept_code = b.dept_code               " +
     "                  and b.comp_code = '" + arg_comp + "'        " +
     "                  and a.dept_code = c.dept_code (+)       " +
     "                  and c.yymm (+) = '" + arg_date + "'       " +
     "               order by a.dept_code                           " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>