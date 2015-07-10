<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%>
<%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class_tag = req.getParameter("arg_class_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("class_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("parents_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("length",GauceDataColumn.TB_STRING,2,0));
     dSet.addDataColumn(new GauceDataColumn("class_num",GauceDataColumn.TB_STRING,3)); 
 
    String query = " select									     " +
				   " class_tag , parents_name , length,	         " +
   				   " to_number(class_tag) as class_num		     " +
				   " from e_safety_code_parent				     " +  
				   " where class_tag in (" + arg_class_tag  + " )" + 
				   " order by class_tag asc						 " ;
%>
<%@
include file="../../../comm_function/conn_q_end.jsp"%>