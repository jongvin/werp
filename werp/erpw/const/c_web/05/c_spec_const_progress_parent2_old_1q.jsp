<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	  dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("col_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,255));
   
	 String query =  " select llevel , col_tag , name , '"+arg_dept_cdoe+"' dept_code , '"+arg_yymm+"' yymm from " +
							" (select llevel, col_tag ,  " +
							"        decode(col_tag,'L','�빫','M','���','X','���','S','����',null,'�̿���') name from " +
							"(SELECT  '2' llevel , b.col_tag , b.cat_text  " +
							"from  " +
							"	c_spec_const_parent a,  " +
							"	y_budget_detail b  " +
							"WHERE ( a.dept_code = b.dept_code ) and  " +
							"	( a.spec_no_seq = b.spec_no_seq ) and  " +
							"	( ( a.dept_code = '"+arg_dept_cdoe+"') and  " +
							"	  ( a.yymm = '"+arg_yymm+"') ) and  " +
							"	a.spec_no_seq = b.spec_no_seq   " +
							"group by   b.col_tag )  " +
							"union all	 " +
							"select '1' llevel , '0' , long_name name from z_code_dept  " +
							"where dept_code =  '"+arg_dept_cdoe+"'	 " +
							"union all  " +
							"select llevel, col_tag , cat_text  name from  " +
							"(SELECT  '3' llevel , b.col_tag , b.cat_text   " +
							"from  " +
							"	c_spec_const_parent a,  " +
							"	y_budget_detail b  " +
							"WHERE ( a.dept_code = b.dept_code ) and  " +
							"	( a.spec_no_seq = b.spec_no_seq ) and  " +
							"	( ( a.dept_code = '"+arg_dept_cdoe+"') and  " +
							"	  ( a.yymm = '"+arg_yymm+"') ) and  " +
							"	a.spec_no_seq = b.spec_no_seq  )   " +
							")  " +
							"order by  col_tag  , llevel , name  " +

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>